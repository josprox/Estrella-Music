import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:dio/dio.dart';
import 'package:audiotags/audiotags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/download/download_integrity_service.dart';
import 'package:harmonymusic/services/background/background_execution_service.dart';

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
import 'package:path/path.dart' as p;

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
  final int maxConcurrentResolutions = 8;

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
    if (isJobRunning.isTrue) return;
    isJobRunning.value = true;
    await BackgroundExecutionService.startDownloads();
    try {
      while (playlistQueue.isNotEmpty || songQueue.isNotEmpty) {
        if (playlistQueue.isNotEmpty) {
          final playlistId = playlistQueue.keys.first;
          final songs = playlistQueue[playlistId]?.toList();
          if (songs == null) {
            playlistQueue.remove(playlistId);
            continue;
          }
          currentPlaylistId.value = playlistId;
          await downloadSongList(songs, isPlaylist: true);
          if (playlistQueue.containsKey(playlistId)) {
            _markCollectionDownloaded(playlistId);
            playlistQueue.remove(playlistId);
          }
          currentPlaylistId.value = '';
          playlistDownloadingProgress.value = 0;
        } else {
          await downloadSongList(songQueue.toList());
        }
      }
    } finally {
      isJobRunning.value = false;
      currentSong = null;
      await BackgroundExecutionService.stopDownloads();
      if (playlistQueue.isNotEmpty || songQueue.isNotEmpty) {
        await triggerDownloadingJob();
      }
    }
  }

  void _markCollectionDownloaded(String playlistId) {
    final tag = Key(playlistId).hashCode.toString();
    if (Get.isRegistered<PlaylistScreenController>(tag: tag)) {
      Get.find<PlaylistScreenController>(tag: tag).isDownloaded.value = true;
    } else if (Get.isRegistered<AlbumScreenController>(tag: tag)) {
      Get.find<AlbumScreenController>(tag: tag).isDownloaded.value = true;
    }
  }

  Future<void> downloadSongList(List<MediaItem> jobSongList,
      {bool isPlaylist = false}) async {
    final pendingSongs = <MediaItem>[];
    final downloadsBox = SqliteStore.box('SongDownloads');
    for (final song in jobSongList) {
      if (isPlaylist && !playlistQueue.containsKey(currentPlaylistId.value)) {
        currentPlaylistId.value = '';
        playlistDownloadingProgress.value = 0;
        return;
      }
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
      pendingSongs.add(song);
    }

    final format =
        Get.find<SettingsScreenController>().downloadingFormat.string;
    final preparedDownloads = await _prepareDownloadBatch(pendingSongs, format);
    await Get.find<CatalogRecoveryService>().persistRecoveredSongs([
      for (final prepared in preparedDownloads)
        if (prepared.originalSong.id != prepared.song.id)
          (
            oldSong: prepared.originalSong,
            recoveredSong: prepared.song,
          ),
    ]);

    var nextDownload = 0;
    var completedCount = 0;
    Future<void> worker() async {
      while (true) {
        if (isPlaylist && !playlistQueue.containsKey(currentPlaylistId.value)) {
          return;
        }
        final index = nextDownload++;
        if (index >= preparedDownloads.length) return;
        await _downloadSongTask(preparedDownloads[index]);
        completedCount++;
        if (isPlaylist) {
          playlistDownloadingProgress.value = completedCount;
        }
      }
    }

    final workerCount = preparedDownloads.length < maxConcurrentDownloads
        ? preparedDownloads.length
        : maxConcurrentDownloads;
    await Future.wait(List.generate(workerCount, (_) => worker()));
  }

  Future<List<_ResolvedDownload>> _prepareDownloadBatch(
    List<MediaItem> songs,
    String format,
  ) async {
    if (songs.isEmpty) return [];
    final results = List<_ResolvedDownload?>.filled(songs.length, null);
    var nextIndex = 0;

    Future<void> worker() async {
      while (true) {
        final index = nextIndex++;
        if (index >= songs.length) return;
        results[index] = await _resolveDownload(
          songs[index],
          format,
          persistRecovery: false,
        );
      }
    }

    final workerCount = songs.length < maxConcurrentResolutions
        ? songs.length
        : maxConcurrentResolutions;
    await Future.wait(List.generate(workerCount, (_) => worker()));

    for (var index = 0; index < results.length; index++) {
      if (results[index] == null) songQueue.remove(songs[index]);
    }
    return results.whereType<_ResolvedDownload>().toList();
  }

  Future<void> _downloadSongTask(_ResolvedDownload prepared) async {
    currentSong = prepared.song;
    songProgressMap[prepared.originalSong.id] = 0;
    await _writeFileStream(
      prepared.song,
      prepared: prepared,
      progressId: prepared.originalSong.id,
    );
    songQueue.removeWhere((song) =>
        song.id == prepared.originalSong.id || song.id == prepared.song.id);
    songProgressMap.remove(prepared.originalSong.id);
  }

  Future<void> _writeFileStream(
    MediaItem song, {
    int retryCount = 0,
    String? progressId,
    _ResolvedDownload? prepared,
  }) async {
    final progressKey = progressId ?? song.id;
    final settingsScreenController = Get.find<SettingsScreenController>();
    final downloadingFormat = settingsScreenController.downloadingFormat.string;
    final resolution =
        prepared ?? await _resolveDownload(song, downloadingFormat);
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
      final downloadTask = UriDownloadTask(
        url: requiredAudioStream.url,
        directoryUri: Uri.directory(
          dirPath,
          windows: Platform.isWindows,
        ),
        filename: p.basename(partialPath),
        group: 'music-downloads',
        updates: Updates.statusAndProgress,
        retries: 1,
        allowPause: true,
      );
      final result = await FileDownloader().download(
        downloadTask,
        onProgress: (progress) {
          if (progress < 0) return;
          songProgressMap[progressKey] = (progress * 100).clamp(0, 100).toInt();
        },
      );
      if (result.status != TaskStatus.complete) {
        throw StateError(
          'Background download ended with status ${result.status}',
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
        await _writeFileStream(
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
    String downloadingFormat, {
    bool persistRecovery = true,
  }) async {
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
      if (persistRecovery) {
        await Get.find<CatalogRecoveryService>().persistRecoveredSong(
          oldSong: song,
          recoveredSong: recovered,
        );
      }
      resolvedSong = recovered;
      response = recoveredResponse;
      audio = recoveredAudio;
    }
    return _ResolvedDownload(
      originalSong: song,
      song: resolvedSong,
      audio: audio,
    );
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
  const _ResolvedDownload({
    required this.originalSong,
    required this.song,
    required this.audio,
  });

  final MediaItem originalSong;
  final MediaItem song;
  final Audio audio;
}
