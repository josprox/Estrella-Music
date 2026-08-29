import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/background/background_execution_service.dart';
import 'package:harmonymusic/services/download/download_integrity_service.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

import 'package:harmonymusic/ui/screens/Album/album_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:harmonymusic/music_provider/music_catalog_service.dart';
import 'package:harmonymusic/music_provider/models/playback_source.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/services/system/permission_service.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import '/models/media_item_builder.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
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
        activeDownloads.removeWhere(
            (f) => f.hashCode == -1); // cleaned up via .then() below
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
    final settingsScreenController = Get.find<SettingsScreenController>();
    final downloadingFormat = settingsScreenController.downloadingFormat.string;

    final source = await _resolveDownloadSource(song, downloadingFormat);
    if (source == null) {
      return;
    }
    final progressId = song.id;
    song = source.song;
    final playback = source.playback;
    unawaited(BackgroundExecutionService.updateCurrentSong(song.title));

    final dirPath = settingsScreenController.downloadLocationPath.string;
    final actualDownformat =
        playback.mimeType?.contains('mp4') == true ? "m4a" : "opus";
    final RegExp invalidChar =
        RegExp(r'Container.|\/|\\|\"|\<|\>|\*|\?|\:|\!|\[|\]|\Â¡|\||\%');
    final songTitle = "${song.title.trim()} (${song.artist?.trim()})"
        .replaceAll(invalidChar, "");
    final filePath = "$dirPath/$songTitle.$actualDownformat";
    final temporaryFilePath = '$filePath.part';
    printINFO("Downloading filePath: $filePath");
    final temporaryFile = File(temporaryFilePath);
    if (await temporaryFile.exists()) await temporaryFile.delete();
    final stopwatch = Stopwatch()..start();

    try {
      final downloadHeaders = Map<String, String>.from(playback.headers);
      final contentLength = playback.contentLength;
      if (contentLength != null && contentLength > 0) {
        downloadHeaders['Range'] = 'bytes=0-${contentLength - 1}';
      }
      final response = await _dio.download(
        playback.uri.toString(),
        temporaryFilePath,
        options: Options(headers: downloadHeaders),
        onReceiveProgress: (count, total) {
          if (total <= 0) return;
          songProgressMap[progressId] = ((count / total) * 100).toInt();
        },
      );
      if (!await temporaryFile.exists() || await temporaryFile.length() == 0) {
        throw const FileSystemException(
            'The audio stream returned an empty file');
      }
      final finalFile = File(filePath);
      if (await finalFile.exists()) await finalFile.delete();
      await temporaryFile.rename(filePath);
      if (!await DownloadIntegrityService.isPlausibleAudioFile(finalFile)) {
        await finalFile.delete();
        throw const FileSystemException(
            'The audio stream is not a valid audio file');
      }
      stopwatch.stop();
      final bytes = await finalFile.length();
      final seconds = stopwatch.elapsedMilliseconds / 1000;
      final kilobytesPerSecond = seconds <= 0 ? 0 : bytes / 1024 / seconds;
      printINFO(
        'Download completed (${response.statusCode}): '
        '${(bytes / 1024 / 1024).toStringAsFixed(2)} MiB in '
        '${seconds.toStringAsFixed(1)}s '
        '(${kilobytesPerSecond.toStringAsFixed(0)} KiB/s)',
      );

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
      final streamInfoJson = <String, dynamic>{
        'url': filePath,
        'headers': playback.headers,
        'mimeType': playback.mimeType,
        'bitrate': playback.bitrate,
        'size': contentLength ?? await finalFile.length(),
        'loudnessDb': playback.loudnessDb,
      };
      // [playbility status, info map]
      songJson["streamInfo"] = [true, streamInfoJson];

      SqliteStore.box("SongDownloads").put(song.id, songJson);
      Get.find<LibrarySongsController>().librarySongsList.add(song);
      printINFO("Downloaded successfully");

      // Metadata is persisted in SongDownloads. Avoid mutating a streamed
      // container after download: AudioTags cannot safely rewrite every
      // Opus/M4A response and used to leave truncated files marked complete.
    } catch (error, stackTrace) {
      if (await temporaryFile.exists()) await temporaryFile.delete();
      printERROR('Downloading failed for ${song.id}: $error\n$stackTrace');
      _showDownloadError(S.current.downloadError3);
    }
  }

  Future<_DownloadSource?> _resolveDownloadSource(
    MediaItem song,
    String downloadingFormat,
  ) async {
    try {
      final source = await Get.find<MusicCatalogService>()
          .resolveDownload(song, format: downloadingFormat);
      if (source.type != PlaybackSourceType.authorizedStream) {
        throw const _UnavailableVideoException(
          'The active provider does not expose a downloadable stream',
        );
      }
      return _DownloadSource(song: song, playback: source);
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

      final source = await Get.find<MusicCatalogService>()
          .resolveDownload(recovered, format: downloadingFormat);
      if (source.type != PlaybackSourceType.authorizedStream) {
        _showDownloadError(originalError);
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
      return _DownloadSource(song: recovered, playback: source);
    } catch (error, stackTrace) {
      printERROR('No fue posible recuperar ${song.id}: $error\n$stackTrace');
      _showDownloadError(originalError);
      return null;
    }
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
  const _DownloadSource({required this.song, required this.playback});

  final MediaItem song;
  final PlaybackSource playback;
}

class _UnavailableVideoException implements Exception {
  const _UnavailableVideoException(this.message);

  final String message;
}
