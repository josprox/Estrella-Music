import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

class SyncedLyricsService {
  /// Save manual/automatic translation to local SqliteStore box for a song ID
  static Future<void> saveTranslation(
      String songId, String translatedSynced, String translatedPlain) async {
    final lyricsBox = await SqliteStore.openBox("lyrics");
    final Map<String, dynamic> lyricsData = Map<String, dynamic>.from(
        lyricsBox.get(songId) ?? {"synced": "", "plainLyrics": ""});
    lyricsData["translatedSynced"] = translatedSynced;
    lyricsData["translatedPlain"] = translatedPlain;
    await lyricsBox.put(songId, lyricsData);
    await lyricsBox.close();
    printINFO("Saved lyrics translation to SqliteStore for song $songId");
  }
}
