import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:audiotags/audiotags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/download/download_integrity_service.dart';

import 'package:harmonymusic/ui/screens/Album/album_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:harmonymusic/services/music/stream_service.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/services/system/permission_service.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import '/models/media_item_builder.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/utils/localization/l10n_extensions.dart';

class Downloader extends GetxService {
  final _dio = Dio();
  MediaItem? currentSong;
  RxMap<String, List<MediaItem>> playlistQueue =
      <String, List<MediaItem>>{}.obs;
  final currentPlaylistId = "".obs;
  final songProgressMap = <String, int>{}.obs;
  final playlistDownloadingProgress = 0.obs;
  final isJobRunning = false.obs;
  final int maxConcurrentDownloads = 3;

  RxList<MediaItem> songQueue = <MediaItem>[].obs;

  Future<bool> checkPermissionNDir() async {
    final settingsScreenController = Get.find<SettingsScreenController>();

    if (!settingsScreenController.isCurrentPathsupportDownDir &&
        !await PermissionService.getExtStoragePermission()) {
      return false;
    }

    final dirPath =
        Get.find<SettingsScreenController>().downloadLocationPath.string;
    final directory = Directory(dirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return true;
  }

  Future<void> downloadPlaylist(
      String playlistId, List<MediaItem> songList) async {
    if (!(await checkPermissionNDir())) return;

    // for toggle between downloading request & cancelling
    if (playlistQueue.containsKey(playlistId)) {
      songQueue.removeWhere((element) => songList.contains(element));
      playlistQueue.remove(playlistId);
      return;
    }

    playlistQueue[playlistId] = songList;
    songQueue.addAll(songList);

    if (isJobRunning.isFalse) {
      await triggerDownloadingJob();
    }
  }

  Future<void> download(MediaItem? song, {List<MediaItem>? songList}) async {
    if (!(await checkPermissionNDir())) return;
    if (songList != null) {
      songQueue.addAll(songList);
    } else {
      songQueue.add(song!);
    }
    if (isJobRunning.isFalse) {
      await triggerDownloadingJob();
    }
  }

  Future<void> triggerDownloadingJob() async {
    //check if playlist download in queue => download playlistsongs else download from general songs queue
    if (playlistQueue.isNotEmpty) {
      isJobRunning.value = true;
      for (String playlistId in playlistQueue.keys.toList()) {
        //checked in case download cancel request
        if (playlistQueue.containsKey(playlistId)) {
          currentPlaylistId.value = playlistId;
          await downloadSongList((playlistQueue[playlistId]!).toList(),
              isPlaylist: true);
          if (Get.isRegistered<PlaylistScreenController>(
                  tag: Key(playlistId).hashCode.toString()) &&
              playlistQueue.containsKey(playlistId)) {
            Get.find<PlaylistScreenController>(
                    tag: Key(playlistId).hashCode.toString())
                .isDownloaded
                .value = true;
          }
          // in case of album
          else if (Get.isRegistered<AlbumScreenController>(
                  tag: Key(playlistId).hashCode.toString()) &&
              playlistQueue.containsKey(playlistId)) {
            Get.find<AlbumScreenController>(
                    tag: Key(playlistId).hashCode.toString())
                .isDownloaded
                .value = true;
          }
          playlistQueue.remove(playlistId);
        }
        currentPlaylistId.value = "";
        playlistDownloadingProgress.value = 0;
      }
    } else {
      isJobRunning.value = true;
      await downloadSongList(songQueue.toList());
    }

    if (songQueue.isNotEmpty) {
      triggerDownloadingJob();
    } else {
      isJobRunning.value = false;
      currentSong = null;
    }
  }

  Future<void> downloadSongList(List<MediaItem> jobSongList,
      {bool isPlaylist = false}) async {
    final List<Future<void>> activeDownloads = [];
    int completedCount = 0;

    for (MediaItem song in jobSongList) {
      if (isPlaylist && !playlistQueue.containsKey(currentPlaylistId.value)) {
        currentPlaylistId.value = "";
        playlistDownloadingProgress.value = 0;
        break;
      }

      final downloadsBox = SqliteStore.box('SongDownloads');
      if (downloadsBox.containsKey(song.id)) {
        final record = downloadsBox.get(song.id);
        if (await DownloadIntegrityService.isValidRecord(record)) {
          songQueue.remove(song);
          continue;
        }
        final invalidPath = DownloadIntegrityService.pathFromRecord(record);
        await downloadsBox.delete(song.id);
        if (invalidPath != null) {
          final invalidFile = File(invalidPath);
          if (await invalidFile.exists()) await invalidFile.delete();
        }
      }

      // Wait if we reached the limit of concurrent downloads
      while (activeDownloads.length >= maxConcurrentDownloads) {
        await Future.delayed(const Duration(milliseconds: 100));
        activeDownloads.removeWhere((f) =>
            f.hashCode ==
            -1); // Dummy to trigger cleanup if I used a wrapper, but I'll use then() instead
      }

      final downloadTask = _downloadSongTask(song, isPlaylist, jobSongList);
      activeDownloads.add(downloadTask);
      downloadTask.then((_) {
        activeDownloads.remove(downloadTask);
        completedCount++;
        if (isPlaylist) {
          playlistDownloadingProgress.value = completedCount;
        }
      });
    }

    await Future.wait(activeDownloads);
  }

  Future<void> _downloadSongTask(
      MediaItem song, bool isPlaylist, List<MediaItem> jobSongList) async {
    currentSong =
        song; // This might still flicker if multiple songs are downloading, but we'll use individual progress in UI
    songProgressMap[song.id] = 0;
    await writeFileStream(song);
    songQueue.remove(song);
    songProgressMap.remove(song.id);
  }

  Future<void> writeFileStream(
    MediaItem song, {
    int retryCount = 0,
    String? progressId,
  }) async {
    final progressKey = progressId ?? song.id;
    final settingsScreenController = Get.find<SettingsScreenController>();
    final downloadingFormat = settingsScreenController.downloadingFormat.string;
    final resolution = await _resolveDownload(song, downloadingFormat);
    if (resolution == null) return;
    final resolvedSong = resolution.song;
    final requiredAudioStream = resolution.audio;

    final dirPath = settingsScreenController.downloadLocationPath.string;
    final actualDownformat =
        requiredAudioStream.audioCodec.name.contains("mp") ? "m4a" : "opus";
    final RegExp invalidChar =
        RegExp(r'Container.|\/|\\|\"|\<|\>|\*|\?|\:|\!|\[|\]|\¡|\||\%');
    final songTitle =
        "${resolvedSong.title.trim()} (${resolvedSong.artist?.trim()})"
            .replaceAll(invalidChar, "");
    final filePath = "$dirPath/$songTitle.$actualDownformat";
    final partialPath = '$filePath.part';
    printINFO("Downloading filePath: $filePath");
    final partialFile = File(partialPath);
    final finalFile = File(filePath);
    try {
      if (await partialFile.exists()) await partialFile.delete();
      final response = await _dio.download(
        requiredAudioStream.url,
        partialPath,
        deleteOnError: true,
        options: Options(
          receiveTimeout: const Duration(minutes: 5),
          followRedirects: true,
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
        onReceiveProgress: (count, total) {
          final expected = total > 0 ? total : requiredAudioStream.size;
          if (expected <= 0) return;
          songProgressMap[progressKey] =
              ((count / expected) * 100).clamp(0, 100).toInt();
        },
      );
      final status = response.statusCode ?? 0;
      if (status < 200 || status >= 300) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Unexpected download status $status',
        );
      }
      if (!await DownloadIntegrityService.isPlausibleAudioFile(
        partialFile,
        expectedSize: requiredAudioStream.size,
      )) {
        throw const FormatException('Downloaded file is incomplete or invalid');
      }
      if (await finalFile.exists()) await finalFile.delete();
      await partialFile.rename(filePath);

      String? year;
      try {
        year = resolvedSong.extras?['year']?.toString();
        if (year == null && resolvedSong.album != null) {
          year = await Get.find<MusicServices>().getSongYear(resolvedSong.id);
        }
      } catch (_) {}

      try {
        final thumbnailPath =
            "${settingsScreenController.supportDirPath}/thumbnails/${resolvedSong.id}.png";
        if (resolvedSong.artUri != null) {
          await _dio.downloadUri(resolvedSong.artUri!, thumbnailPath);
        }
      } catch (_) {}

      final extras = Map<String, dynamic>.from(resolvedSong.extras ?? {})
        ..['url'] = filePath
        ..['date'] = DateTime.now().millisecondsSinceEpoch;
      final downloadedSong = resolvedSong.copyWith(extras: extras);
      await _writeAudioTags(downloadedSong, filePath, year);

      if (!await DownloadIntegrityService.isPlausibleAudioFile(finalFile)) {
        throw const FormatException('Audio file became invalid after tagging');
      }
      final songJson = MediaItemBuilder.toJson(downloadedSong);
      final streamInfoJson = requiredAudioStream.toJson()..['url'] = filePath;
      songJson['streamInfo'] = [true, streamInfoJson];
      await SqliteStore.box('SongDownloads').put(downloadedSong.id, songJson);

      final libraryController = Get.find<LibrarySongsController>();
      if (!libraryController.librarySongsList
          .any((item) => item.id == downloadedSong.id)) {
        libraryController.librarySongsList.add(downloadedSong);
      }
      printINFO('Downloaded and validated successfully');
    } catch (error, stackTrace) {
      if (await partialFile.exists()) await partialFile.delete();
      if (await finalFile.exists() &&
          !await DownloadIntegrityService.isPlausibleAudioFile(finalFile)) {
        await finalFile.delete();
      }
      printERROR('Download failed validation: $error\n$stackTrace');
      if (retryCount == 0) {
        printINFO('Refreshing the stream URL and retrying the download once');
        await writeFileStream(
          resolvedSong,
          retryCount: 1,
          progressId: progressKey,
        );
        return;
      }
      _showDownloadError(S.current.downloadError3);
    }
  }

  Future<_ResolvedDownload?> _resolveDownload(
    MediaItem song,
    String downloadingFormat,
  ) async {
    var resolvedSong = song;
    var response = await StreamProvider.fetch(song.id);
    var audio = _selectAudio(response, downloadingFormat);
    if (!response.playable || audio == null) {
      if (response.statusMSG == 'networkError') {
        _showDownloadError(response.statusMSG.t);
        return null;
      }
      final recovered =
          await Get.find<CatalogRecoveryService>().findSimilarSong(
        title: song.title,
        artistName: song.artist,
        albumName: song.album,
        duration: song.duration,
        excludeIds: {song.id},
      );
      if (recovered == null) {
        _showDownloadError(response.statusMSG);
        return null;
      }
      final recoveredResponse = await StreamProvider.fetch(recovered.id);
      final recoveredAudio = _selectAudio(recoveredResponse, downloadingFormat);
      if (!recoveredResponse.playable || recoveredAudio == null) {
        _showDownloadError(recoveredResponse.statusMSG);
        return null;
      }
      await Get.find<CatalogRecoveryService>().persistRecoveredSong(
        oldSong: song,
        recoveredSong: recovered,
      );
      resolvedSong = recovered;
      response = recoveredResponse;
      audio = recoveredAudio;
    }
    return _ResolvedDownload(song: resolvedSong, audio: audio);
  }

  Audio? _selectAudio(StreamProvider response, String format) {
    if (!response.playable) return null;
    return format == 'opus'
        ? response.highestBitrateOpusAudio
        : response.highestBitrateMp4aAudio;
  }

  Future<void> _writeAudioTags(
      MediaItem song, String filePath, String? year) async {
    final trackDetails = (song.extras?['trackDetails'])?.split('/');
    final trackNumber = int.tryParse(trackDetails?[0] ?? '');
    final totalTracks = int.tryParse(trackDetails?[1] ?? '');
    try {
      final pictures = <Picture>[];
      if (song.artUri != null) {
        final imageUrl = song.artUri.toString();
        pictures.add(Picture(
          bytes: (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
              .buffer
              .asUint8List(),
          mimeType: MimeType.png,
          pictureType: PictureType.coverFront,
        ));
      }
      await AudioTags.write(
        filePath,
        Tag(
          title: song.title,
          trackArtist: song.artist,
          album: song.album,
          year: int.tryParse(year ?? ''),
          trackNumber: trackNumber,
          trackTotal: totalTracks,
          albumArtist: song.artist,
          genre: song.genre,
          pictures: pictures,
        ),
      );
    } catch (error) {
      printERROR('$error');
    }
  }

  void _showDownloadError(String message) {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(snackbar(
      context,
      message,
      size: SanckBarSize.BIG,
      duration: const Duration(seconds: 2),
      top: !GetPlatform.isDesktop,
    ));
  }
}

class _ResolvedDownload {
  const _ResolvedDownload({required this.song, required this.audio});

  final MediaItem song;
  final Audio audio;
}
