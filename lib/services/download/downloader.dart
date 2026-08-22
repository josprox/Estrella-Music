import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:audiotags/audiotags.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/background/background_execution_service.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

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
  final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(minutes: 5),
  ));
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
    final List<Future<void>> activeDownloads = [];
    int completedCount = 0;

    for (MediaItem song in jobSongList) {
      if (isPlaylist && !playlistQueue.containsKey(currentPlaylistId.value)) {
        currentPlaylistId.value = "";
        playlistDownloadingProgress.value = 0;
        break;
      }

      if (SqliteStore.box("SongDownloads").containsKey(song.id)) {
        songQueue.removeWhere((s) => s.id == song.id);
        continue;
      }

      // Skip if this song is already being downloaded
      if (songProgressMap.containsKey(song.id)) {
        continue;
      }

      // Wait if we reached the limit of concurrent downloads
      while (activeDownloads.length >= maxConcurrentDownloads) {
        await Future.any(activeDownloads);
        activeDownloads.removeWhere((f) =>
            f.hashCode ==
            -1); // cleaned up via .then() below
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
    final songId = song.id;
    currentSong =
        song; // This might still flicker if multiple songs are downloading, but we'll use individual progress in UI
    songProgressMap[songId] = 0;
    await writeFileStream(song);
    songQueue.removeWhere((s) => s.id == songId);
    songProgressMap.remove(songId);
  }

  Future<void> writeFileStream(MediaItem song) async {
    Completer<void> complete = Completer();

    final settingsScreenController = Get.find<SettingsScreenController>();
    final downloadingFormat = settingsScreenController.downloadingFormat.string;

    final source = await _resolveDownloadSource(song, downloadingFormat);
    if (source == null) {
      complete.complete();
      return complete.future;
    }
    final progressId = song.id;
    song = source.song;
    final requiredAudioStream = source.audio;
    unawaited(BackgroundExecutionService.updateCurrentSong(song.title));

    final dirPath = settingsScreenController.downloadLocationPath.string;
    final actualDownformat =
        requiredAudioStream.audioCodec.name.contains("mp") ? "m4a" : "opus";
    final RegExp invalidChar =
        RegExp(r'Container.|\/|\\|\"|\<|\>|\*|\?|\:|\!|\[|\]|\¡|\||\%');
    final songTitle = "${song.title.trim()} (${song.artist?.trim()})"
        .replaceAll(invalidChar, "");
    String filePath = "$dirPath/$songTitle.$actualDownformat";
    printINFO("Downloading filePath: $filePath");
    final totalBytes = requiredAudioStream.size;

    _dio.download(
        requiredAudioStream.url,
        options: Options(headers: {"Range": 'bytes=0-$totalBytes'}),
        filePath, onReceiveProgress: (count, total) {
      if (total <= 0) return;
      songProgressMap[progressId] = ((count / total) * 100).toInt();
    }).then(
      (value) async {
        printINFO(value.data);

        String? year;
        try {
          if (song.extras?['year'] != null) {
            year = song.extras?['year'];
          } else {
            if (song.album != null) {
              final musicServ = Get.find<MusicServices>();
              year = await musicServ.getSongYear(song.id);
            }
          }
        } catch (_) {}

        // Save Thumbnail
        try {
          final thumbnailPath =
              "${settingsScreenController.supportDirPath}/thumbnails/${song.id}.png";
          await _dio.downloadUri(song.artUri!, thumbnailPath);
          // ignore: empty_catches
        } catch (e) {}

        if (song.extras == null) {
          song = song.copyWith(extras: {});
        }
        song.extras!['url'] = filePath;
        song.extras!['date'] = DateTime.now().millisecondsSinceEpoch;
        final songJson = MediaItemBuilder.toJson(song);
        final streamInfoJson = requiredAudioStream.toJson();
        streamInfoJson['url'] = filePath;
        // [playbility status, info map]
        songJson["streamInfo"] = [true, streamInfoJson];

        SqliteStore.box("SongDownloads").put(song.id, songJson);
        Get.find<LibrarySongsController>().librarySongsList.add(song);
        printINFO("Downloaded successfully");

        final trackDetails = (song.extras?['trackDetails'])?.split("/");
        final int? trackNumber = int.tryParse(trackDetails?[0] ?? "");
        final int? totalTracks = int.tryParse(trackDetails?[1] ?? "");

        try {
          /// Reverted -- Removed AudioTags as using this package, app is flagged as TROJ_GEN.R002V01K623 by TrendMicro-HouseCall
          final imageUrl = song.artUri!.toString();
          Tag tag = Tag(
              title: song.title,
              trackArtist: song.artist,
              album: song.album,
              year: int.tryParse(year ?? ""),
              trackNumber: trackNumber,
              trackTotal: totalTracks,
              albumArtist: song.artist,
              genre: song.genre,
              pictures: [
                Picture(
                    bytes: (await NetworkAssetBundle(Uri.parse((imageUrl)))
                            .load(imageUrl))
                        .buffer
                        .asUint8List(),
                    mimeType: MimeType.png,
                    pictureType: PictureType.coverFront)
              ]);

          await AudioTags.write(filePath, tag);
        } catch (e) {
          printERROR("$e");
        }
        complete.complete();
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
            Get.context!, S.current.downloadError3,
            size: SanckBarSize.BIG,
            duration: const Duration(seconds: 2),
            top: !GetPlatform.isDesktop));
        printINFO(
            "Downloading failed due to network/stream error! Please try again");
        complete.complete();
      },
    );

    return complete.future;
  }

  Future<_DownloadSource?> _resolveDownloadSource(
    MediaItem song,
    String downloadingFormat,
  ) async {
    try {
      final response = await StreamProvider.fetch(song.id);
      if (response.videoUnavailable) {
        printINFO(
          'Video ${song.id} is unavailable; attempting to find replacement',
        );
        throw _UnavailableVideoException(response.statusMSG);
      }
      if (!response.playable) {
        printINFO(
          'Song ${song.id} is not playable (${response.statusMSG}); '
          'attempting recovery as it may have a new ID',
        );
        // Treat all non-playable songs the same as unavailable — the video
        // ID may have changed and a search can find the replacement.
        throw _UnavailableVideoException(response.statusMSG);
      }
      final audio = _selectAudio(response, downloadingFormat);
      if (audio == null) {
        _showDownloadError(response.statusMSG);
        return null;
      }
      return _DownloadSource(song: song, audio: audio);
    } on _UnavailableVideoException catch (error) {
      return _recoverUnavailableSong(song, downloadingFormat, error.message);
    } catch (error) {
      printERROR('No fue posible obtener la URL de ${song.id}: $error');
      _showDownloadError(S.current.downloadError3);
      return null;
    }
  }

  Future<_DownloadSource?> _recoverUnavailableSong(
    MediaItem song,
    String downloadingFormat,
    String originalError,
  ) async {
    try {
      final recovered =
          await Get.find<CatalogRecoveryService>().findSimilarSong(
        title: song.title,
        artistName: song.artist,
        albumName: song.album,
        duration: song.duration,
        excludeIds: {song.id},
      );
      if (recovered == null) {
        printINFO('No replacement was found for unavailable song ${song.id}');
        _showDownloadError(originalError);
        return null;
      }

      final response = await StreamProvider.fetch(recovered.id);
      final audio = _selectAudio(response, downloadingFormat);
      if (!response.playable || audio == null) {
        printINFO(
          'Replacement ${recovered.id} is not downloadable: '
          '${response.statusMSG}',
        );
        _showDownloadError(response.statusMSG);
        return null;
      }

      try {
        await Get.find<CatalogRecoveryService>().persistRecoveredSong(
          oldSong: song,
          recoveredSong: recovered,
        );
        printINFO('Updated unavailable song ${song.id} to ${recovered.id}');
      } catch (error, stackTrace) {
        printERROR(
          'Could not persist replacement ${song.id} -> ${recovered.id}; '
          'the recovered song will still be downloaded: '
          '$error\n$stackTrace',
        );
      }
      return _DownloadSource(song: recovered, audio: audio);
    } catch (error, stackTrace) {
      printERROR('No fue posible recuperar ${song.id}: $error\n$stackTrace');
      _showDownloadError(originalError);
      return null;
    }
  }

  Audio? _selectAudio(StreamProvider response, String format) {
    if (!response.playable) return null;
    return format == 'opus'
        ? response.highestBitrateOpusAudio
        : response.highestBitrateMp4aAudio;
  }

  void _showDownloadError(String message) {
    final context = Get.context;
    if (context == null) return;
    final translatedMessage = message == 'networkError' ? message.t : message;
    ScaffoldMessenger.of(context).showSnackBar(snackbar(
      context,
      translatedMessage,
      size: SanckBarSize.BIG,
      duration: const Duration(seconds: 2),
      top: !GetPlatform.isDesktop,
    ));
  }
}

class _DownloadSource {
  const _DownloadSource({required this.song, required this.audio});

  final MediaItem song;
  final Audio audio;
}

class _UnavailableVideoException implements Exception {
  const _UnavailableVideoException(this.message);

  final String message;
}
