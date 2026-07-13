import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/services/music/lyrics_providers.dart';

class SyncedLyricsService {
  static final List<LyricsProvider> _providers = [
    LrcLibProvider(),
    BetterLyricsProvider(),
    PaxsenixProvider(),
    KugouProvider(),
  ];

  static Future<Map<String, dynamic>?> getSyncedLyrics(
      MediaItem song, int durInSec) async {
    final lyricsBox = await SqliteStore.openBox("lyrics");
    // check if lyrics available in local database
    if (lyricsBox.containsKey(song.id)) {
      final cached = await lyricsBox.get(song.id);
      await lyricsBox.close();
      if (cached != null) {
        return Map<String, dynamic>.from(cached);
      }
    }

    final dur = song.duration?.inSeconds ?? durInSec;
    final url =
        'https://lrclib.net/api/get?artist_name=${song.artist?.replaceAll(" ", "+")}&track_name=${song.title.replaceAll(" ", "+")}&album_name=${song.album?.replaceAll(" ", "+")}&duration=$dur';
    try {
      final response = (await Dio().get(url)).data;
      if (response["syncedLyrics"] != null || response["plainLyrics"] != null) {
        printINFO("Synced or Plain Lyrics Available from LRCLIB");
        final lyricsData = {
          "synced": response["syncedLyrics"] ?? "",
          "plainLyrics": response["plainLyrics"] ?? ""
        };
        await lyricsBox.put(song.id, lyricsData);
        await lyricsBox.close();
        return lyricsData;
      }
    } on DioException catch (e) {
      printERROR(e.response);
    } finally {
      if (lyricsBox.isOpen) {
        await lyricsBox.close();
      }
    }
    return null;
  }

  /// Search across all lyrics providers concurrently
  static Future<List<LyricsSearchResult>> searchManual(
    String query, {
    String? trackName,
    String? artistName,
    int? duration,
    String? album,
  }) async {
    final List<Future<List<LyricsSearchResult>>> futures = [];
    for (var provider in _providers) {
      futures.add(
        provider.search(
          query,
          trackName: trackName,
          artistName: artistName,
          duration: duration,
          album: album,
        ).catchError((err) {
          printERROR("Provider ${provider.name} search failed: $err");
          return <LyricsSearchResult>[];
        }),
      );
    }

    final resultsList = await Future.wait(futures);
    final List<LyricsSearchResult> flatResults = [];
    for (var results in resultsList) {
      flatResults.addAll(results);
    }
    return flatResults;
  }

  /// Save manually selected lyrics to local SqliteStore box
  static Future<Map<String, dynamic>> saveManualLyrics(
      String songId, String lyrics, bool isSynced) async {
    final lyricsBox = await SqliteStore.openBox("lyrics");
    final lyricsData = {
      "synced": isSynced ? lyrics : "",
      "plainLyrics": isSynced ? "" : lyrics
    };
    await lyricsBox.put(songId, lyricsData);
    await lyricsBox.close();
    printINFO("Manually selected lyrics saved to SqliteStore for song $songId (synced=$isSynced)");
    return lyricsData;
  }

  /// Save manual/automatic translation to local SqliteStore box for a song ID
  static Future<void> saveTranslation(
      String songId, String translatedSynced, String translatedPlain) async {
    final lyricsBox = await SqliteStore.openBox("lyrics");
    final Map<String, dynamic> lyricsData = Map<String, dynamic>.from(
      lyricsBox.get(songId) ?? {"synced": "", "plainLyrics": ""}
    );
    lyricsData["translatedSynced"] = translatedSynced;
    lyricsData["translatedPlain"] = translatedPlain;
    await lyricsBox.put(songId, lyricsData);
    await lyricsBox.close();
    printINFO("Saved lyrics translation to SqliteStore for song $songId");
  }
}
