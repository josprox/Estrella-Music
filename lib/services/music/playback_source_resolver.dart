import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import 'package:estrella_music/models/hm_streaming_data.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/services/download/download_integrity_service.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:estrella_music/services/system/permission_service.dart';
import 'package:estrella_music/ui/screens/Settings/settings_screen_controller.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

/// Service responsible for resolving playable audio stream URLs from local storage,
/// cache, or streaming catalog providers.
class PlaybackSourceResolver {
  PlaybackSourceResolver({
    required String cacheDirPath,
    MusicCatalogService? catalogService,
  })  : _cacheDir = cacheDirPath,
        _catalogService = catalogService;

  final String _cacheDir;
  final MusicCatalogService? _catalogService;

  MusicCatalogService get _catalog =>
      _catalogService ?? Get.find<MusicCatalogService>();

  /// Resolves playable stream data for [songId] in order of priority:
  /// 1. Local Downloads (`SongDownloads`)
  /// 2. Audio Cache (`SongsCache`) - skipped if [generateNewUrl] is true
  /// 3. Online Provider Stream (`MusicCatalogService`)
  Future<HMStreamingData> resolveStreamData(
    String songId, {
    MediaItem? providerTrack,
    bool generateNewUrl = false,
    bool offlineReplacementUrl = false,
  }) async {
    printINFO("Requested stream for id: $songId");

    // 1. Audio Cache check
    final songsCacheBox = await SqliteStore.openBox('SongsCache');
    final cachedFile = File('$_cacheDir/cachedSongs/$songId.mp3');

    if (!offlineReplacementUrl && !generateNewUrl && songsCacheBox.containsKey(songId)) {
      if (!await DownloadIntegrityService.isPlausibleAudioFile(cachedFile)) {
        await songsCacheBox.delete(songId);
        if (await cachedFile.exists()) await cachedFile.delete();
      } else {
        printINFO("Resolved song from cache box ($songId)");
        final streamInfo = songsCacheBox.get(songId)["streamInfo"];
        Audio? cacheAudioPlaceholder;
        if (streamInfo != null && streamInfo.isNotEmpty) {
          streamInfo[1]['url'] = cachedFile.uri.toString();
          cacheAudioPlaceholder = Audio.fromJson(streamInfo[1]);
        } else {
          cacheAudioPlaceholder = Audio(
            audioCodec: Codec.mp4a,
            bitrate: 0,
            loudnessDb: 0,
            duration: 0,
            size: 0,
            url: cachedFile.uri.toString(),
            itag: 0,
          );
        }

        return HMStreamingData(
          playable: true,
          statusMSG: "OK",
          lowQualityAudio: cacheAudioPlaceholder,
          highQualityAudio: cacheAudioPlaceholder,
        );
      }
    }

    // 2. Song Downloads check
    final songDownloadsBox = SqliteStore.box("SongDownloads");
    if (!offlineReplacementUrl && songDownloadsBox.containsKey(songId)) {
      final song = songDownloadsBox.get(songId);
      final path = DownloadIntegrityService.pathFromRecord(song);
      final isInternalPath = path?.contains(
              "${Get.find<SettingsScreenController>().supportDirPath}/Music") ??
          false;
      final hasPermission =
          isInternalPath || await PermissionService.getExtStoragePermission();

      if (!hasPermission ||
          !await DownloadIntegrityService.isValidRecord(song)) {
        await songDownloadsBox.delete(songId);
        if (path != null) {
          final invalidFile = File(path);
          if (await invalidFile.exists()) await invalidFile.delete();
        }
        return resolveStreamData(
          songId,
          providerTrack: providerTrack,
          offlineReplacementUrl: true,
        );
      }

      final streamInfoJson = song["streamInfo"];
      Audio? audio;
      if (streamInfoJson != null && streamInfoJson.isNotEmpty) {
        final localStream = Map<dynamic, dynamic>.from(streamInfoJson[1]);
        localStream['url'] = File(path!).uri.toString();
        audio = Audio.fromJson(localStream);
      } else {
        audio = Audio(
          itag: 140,
          audioCodec: Codec.mp4a,
          bitrate: 0,
          duration: 0,
          loudnessDb: 0,
          url: File(path!).uri.toString(),
          size: 0,
        );
      }

      return HMStreamingData(
        playable: true,
        statusMSG: "OK",
        highQualityAudio: audio,
        lowQualityAudio: audio,
      );
    }

    // 3. Online Provider Resolution
    final qualityIndex =
        SqliteStore.box('AppPrefs').get('streamingQuality') ?? 1;
    HMStreamingData? streamInfo;

    final item = providerTrack ??
        MediaItem(id: songId, title: songId, extras: const {});
    try {
      if (generateNewUrl) {
        await _catalog.invalidatePlayback(item);
      }
      final source = await _catalog.resolvePlayback(item);
      final audio = audioFromPlaybackSource(source);
      streamInfo = HMStreamingData(
        playable: true,
        statusMSG: 'OK',
        lowQualityAudio: audio,
        highQualityAudio: audio,
      );
    } catch (error) {
      return HMStreamingData(playable: false, statusMSG: error.toString());
    }

    streamInfo.setQualityIndex(qualityIndex as int);
    return streamInfo;
  }

  static Audio audioFromPlaybackSource(PlaybackSource source) => Audio(
        itag: 0,
        audioCodec:
            source.mimeType?.contains('opus') == true ? Codec.opus : Codec.mp4a,
        bitrate: source.bitrate ?? 0,
        duration: 0,
        loudnessDb: source.loudnessDb,
        url: source.uri.toString(),
        size: 0,
        headers: source.headers,
        mimeType: source.mimeType,
      );
}
