import 'package:dio/dio.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

class TranslationService {
  static final Dio _dio = Dio();

  /// Finds public lyrics independently from the active music provider.
  ///
  /// Providers may supply their own lyrics, but online lookup is a playback UI
  /// feature: it must work equally for local and eMusic profiles.  Keeping it
  /// here prevents the local provider from being the only profile with this
  /// fallback.
  static Future<Map<String, String>?> fetchOnlineLyrics({
    required String title,
    required String artist,
    String? album,
    Duration? duration,
  }) async {
    final normalizedTitle = title.trim();
    if (normalizedTitle.isEmpty) return null;

    final normalizedArtist = artist.trim();
    final normalizedAlbum = album?.trim() ?? '';
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 4),
      receiveTimeout: const Duration(seconds: 4),
      headers: const {'User-Agent': 'EstrellaMusic/2.0'},
    ));

    Map<String, String>? parseLyrics(dynamic value) {
      if (value is! Map) return null;
      final synced = value['syncedLyrics']?.toString().trim() ?? '';
      final plain = value['plainLyrics']?.toString().trim() ?? '';
      if (synced.isEmpty && plain.isEmpty) return null;
      return {'synced': synced, 'plain': plain};
    }

    try {
      final response = await dio.get(
        'https://lrclib.net/api/get',
        queryParameters: {
          'track_name': normalizedTitle,
          if (normalizedArtist.isNotEmpty) 'artist_name': normalizedArtist,
          if (normalizedAlbum.isNotEmpty) 'album_name': normalizedAlbum,
          if (duration != null && duration.inSeconds > 0)
            'duration': duration.inSeconds,
        },
      );
      final lyrics = parseLyrics(response.data);
      if (lyrics != null) return lyrics;
    } catch (_) {
      // A fuzzy search below handles incomplete or inconsistent metadata.
    }

    try {
      final response = await dio.get(
        'https://lrclib.net/api/search',
        queryParameters: {'q': '$normalizedTitle $normalizedArtist'.trim()},
      );
      if (response.data is List) {
        for (final candidate in response.data as List) {
          final lyrics = parseLyrics(candidate);
          if (lyrics != null) return lyrics;
        }
      }
    } catch (error) {
      printERROR('Failed to find online lyrics: $error');
    }
    return null;
  }

  /// Attempt to fetch translated lyrics from NetEase.
  /// Returns a Map with 'synced' and 'plain' translated lyrics if found.
  static Future<Map<String, String>?> fetchNetEaseTranslation(
      String title, String artist) async {
    try {
      final query = "$title $artist".trim();
      printINFO("Searching NetEase translation for: $query");

      // Step 1: Search song on NetEase to get the song ID
      final searchUrl =
          "https://music.163.com/api/search/get/web?type=1&limit=5&s=${Uri.encodeComponent(query)}";
      final searchRes = await _dio.get(searchUrl);

      if (searchRes.statusCode == 200 && searchRes.data != null) {
        final data = searchRes.data;
        if (data is Map &&
            data['result'] != null &&
            data['result']['songs'] is List) {
          final List songs = data['result']['songs'];
          if (songs.isNotEmpty) {
            final songId = songs[0]['id'];
            if (songId != null) {
              // Step 2: Fetch lyrics details (contains translation in 'tlyric')
              final lyricUrl =
                  "https://music.163.com/api/song/lyric?os=pc&id=$songId&lv=-1&kv=-1&tv=-1";
              final lyricRes = await _dio.get(lyricUrl);

              if (lyricRes.statusCode == 200 && lyricRes.data != null) {
                final lyricData = lyricRes.data;
                final String? tlyric =
                    lyricData['tlyric']?['lyric']?.toString();

                if (tlyric != null &&
                    tlyric.trim().isNotEmpty &&
                    tlyric != "null") {
                  printINFO(
                      "Found community translation from NetEase for: $query");

                  // If translation has times, it's synced. Otherwise, it's plain.
                  final isSynced =
                      tlyric.contains(RegExp(r'\[\d\d:\d\d\.\d{2,3}\]'));
                  return {
                    "synced": isSynced ? tlyric : "",
                    "plain": isSynced ? "" : tlyric,
                  };
                }
              }
            }
          }
        }
      }
    } catch (e) {
      printERROR("Failed to fetch NetEase translation: $e");
    }
    return null;
  }

  /// Fallback method to translate a standard LRC block using Google Translate gtx client.
  static Future<String> translateLrcWithGoogle(String originalLrc,
      {String targetLang = "es"}) async {
    if (originalLrc.trim().isEmpty) return "";

    try {
      printINFO(
          "Translating LRC lyrics with Google Translate fallback (to $targetLang)...");

      final RegExp lrcRegex = RegExp(r'^\[(\d\d:\d\d\.\d{2,3})\](.*)$');
      final lines = originalLrc.split('\n');
      final List<String> timestamps = [];
      final List<String> textLines = [];

      // 1. Separate timestamps from text
      for (var line in lines) {
        final trimmed = line.trim();
        final match = lrcRegex.firstMatch(trimmed);
        if (match != null) {
          timestamps.add(match.group(1)!);
          textLines.add(match.group(2)!.trim());
        } else {
          timestamps.add("");
          textLines.add(trimmed);
        }
      }

      // Filter out empty lines to avoid translating empty spaces, but keep indexing correct
      // We will join lines with a unique line-break indicator so Google doesn't merge lines
      final String joinedText = textLines.join('\n');

      // 2. Query Google Translate
      final response = await _dio.get(
        "https://translate.googleapis.com/translate_a/single",
        queryParameters: {
          'client': 'gtx',
          'sl': 'auto',
          'tl': targetLang,
          'dt': 't',
          'q': joinedText,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is List && data.isNotEmpty && data[0] is List) {
          final List segments = data[0];
          final StringBuffer sb = StringBuffer();
          for (var segment in segments) {
            if (segment is List && segment.isNotEmpty) {
              sb.write(segment[0].toString());
            }
          }

          final translatedJoined = sb.toString();
          // Split back into lines
          final translatedLines = translatedJoined.split('\n');

          // 3. Rebuild the LRC content aligning original timestamps
          final List<String> rebuiltLrc = [];
          for (int i = 0; i < textLines.length; i++) {
            final timestamp = timestamps[i];

            // Fallback to empty text if translation lines count differs
            String translatedText = "";
            if (i < translatedLines.length) {
              translatedText = translatedLines[i].trim();
            }

            if (timestamp.isNotEmpty) {
              rebuiltLrc.add("[$timestamp]$translatedText");
            } else {
              rebuiltLrc.add(translatedText);
            }
          }

          return rebuiltLrc.join('\n');
        }
      }
    } catch (e) {
      printERROR("Google Translate LRC failed: $e");
    }
    return "";
  }

  /// Search candidate lyrics from online providers (LRCLIB, NetEase)
  static Future<List<LyricsCandidate>> searchLyricsCandidates(
      String query) async {
    final results = <LyricsCandidate>[];
    final normalized = query.trim();
    if (normalized.isEmpty) return results;

    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 6),
      headers: const {'User-Agent': 'EstrellaMusic/2.0'},
    ));

    // 1. Search LRCLIB
    try {
      final response = await dio.get(
        'https://lrclib.net/api/search',
        queryParameters: {'q': normalized},
      );
      if (response.data is List) {
        for (final item in response.data) {
          if (item is Map) {
            final synced = item['syncedLyrics']?.toString().trim() ?? '';
            final plain = item['plainLyrics']?.toString().trim() ?? '';
            if (synced.isNotEmpty || plain.isNotEmpty) {
              results.add(LyricsCandidate(
                title: item['trackName']?.toString() ?? '',
                artist: item['artistName']?.toString() ?? '',
                album: item['albumName']?.toString() ?? '',
                duration: item['duration'] is num
                    ? (item['duration'] as num).toInt()
                    : 0,
                syncedLyrics: synced,
                plainLyrics: plain,
                provider: 'LRCLIB',
              ));
            }
          }
        }
      }
    } catch (e) {
      printERROR('LRCLIB search error: $e');
    }

    // 2. Search NetEase
    try {
      final neteaseUrl =
          "http://music.163.com/api/search/get/web?type=1&limit=5&s=${Uri.encodeComponent(normalized)}";
      final neteaseRes = await _dio.get(neteaseUrl);
      if (neteaseRes.statusCode == 200 &&
          neteaseRes.data is Map &&
          neteaseRes.data['result'] != null &&
          neteaseRes.data['result']['songs'] is List) {
        final List songs = neteaseRes.data['result']['songs'];
        for (final song in songs.take(3)) {
          final sId = song['id'];
          if (sId != null) {
            final lUrl =
                "http://music.163.com/api/song/lyric?os=pc&id=$sId&lv=-1&kv=-1&tv=-1";
            final lRes = await _dio.get(lUrl);
            if (lRes.statusCode == 200 && lRes.data is Map) {
              final lrc =
                  lRes.data['lrc']?['lyric']?.toString().trim() ?? '';
              if (lrc.isNotEmpty) {
                final artistName = (song['artists'] is List &&
                        song['artists'].isNotEmpty)
                    ? song['artists'][0]['name']?.toString() ?? ''
                    : '';
                results.add(LyricsCandidate(
                  title: song['name']?.toString() ?? '',
                  artist: artistName,
                  album: song['album']?['name']?.toString() ?? '',
                  duration: song['duration'] is num
                      ? ((song['duration'] as num) / 1000).toInt()
                      : 0,
                  syncedLyrics: lrc,
                  plainLyrics: '',
                  provider: 'NetEase',
                ));
              }
            }
          }
        }
      }
    } catch (e) {
      printERROR('NetEase search error: $e');
    }

    return results;
  }
}

class LyricsCandidate {
  final String title;
  final String artist;
  final String album;
  final int duration;
  final String syncedLyrics;
  final String plainLyrics;
  final String provider;

  bool get hasSynced => syncedLyrics.isNotEmpty;

  const LyricsCandidate({
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.syncedLyrics,
    required this.plainLyrics,
    required this.provider,
  });
}
