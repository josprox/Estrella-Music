import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;
import 'package:harmonymusic/utils/helpers/helper.dart';

class LyricsSearchResult {
  final String providerName;
  final String trackName;
  final String artistName;
  final String? albumName;
  final int? duration;
  final String lyrics;
  final bool isSynced;

  LyricsSearchResult({
    required this.providerName,
    required this.trackName,
    required this.artistName,
    this.albumName,
    this.duration,
    required this.lyrics,
    required this.isSynced,
  });

  String get displayName => "$trackName - $artistName ${albumName != null ? '($albumName)' : ''}";
}

abstract class LyricsProvider {
  String get name;
  Future<List<LyricsSearchResult>> search(String query, {String? trackName, String? artistName, int? duration, String? album});
}

// ----------------------------------------------------
// 1. LRCLIB PROVIDER
// ----------------------------------------------------
class LrcLibProvider implements LyricsProvider {
  @override
  String get name => "LrcLib";

  final Dio _dio = Dio();

  @override
  Future<List<LyricsSearchResult>> search(String query, {String? trackName, String? artistName, int? duration, String? album}) async {
    try {
      final Map<String, dynamic> params = {};
      if (trackName != null && trackName.isNotEmpty) params['track_name'] = trackName;
      if (artistName != null && artistName.isNotEmpty) params['artist_name'] = artistName;
      if (album != null && album.isNotEmpty) params['album_name'] = album;
      
      Response response;
      if (params.isNotEmpty) {
        response = await _dio.get("https://lrclib.net/api/search", queryParameters: params);
      } else {
        response = await _dio.get("https://lrclib.net/api/search", queryParameters: {'q': query});
      }

      if (response.statusCode == 200 && response.data is List) {
        final List results = response.data;
        return results.map<LyricsSearchResult?>((item) {
          final String? synced = item['syncedLyrics'];
          final String? plain = item['plainLyrics'];
          if (synced == null && plain == null) return null;
          return LyricsSearchResult(
            providerName: name,
            trackName: item['trackName'] ?? '',
            artistName: item['artistName'] ?? '',
            albumName: item['albumName'],
            duration: (item['duration'] as num?)?.toInt(),
            lyrics: synced ?? plain ?? '',
            isSynced: synced != null && synced.isNotEmpty,
          );
        }).whereType<LyricsSearchResult>().toList();
      }
    } catch (e) {
      printERROR("LrcLib search failed: $e");
    }
    return [];
  }
}

// ----------------------------------------------------
// TTML PARSER HELPER (For BetterLyrics & Paxsenix)
// ----------------------------------------------------
class TTMLParser {
  static double _parseTime(String timeStr) {
    timeStr = timeStr.trim();
    if (timeStr.endsWith("ms")) {
      return (double.tryParse(timeStr.substring(0, timeStr.length - 2)) ?? 0.0) / 1000.0;
    }
    if (timeStr.endsWith("s")) {
      return double.tryParse(timeStr.substring(0, timeStr.length - 1)) ?? 0.0;
    }
    final parts = timeStr.split(':');
    if (parts.length == 2) {
      final mins = double.tryParse(parts[0]) ?? 0.0;
      final secs = double.tryParse(parts[1]) ?? 0.0;
      return mins * 60.0 + secs;
    } else if (parts.length == 3) {
      final hrs = double.tryParse(parts[0]) ?? 0.0;
      final mins = double.tryParse(parts[1]) ?? 0.0;
      final secs = double.tryParse(parts[2]) ?? 0.0;
      return hrs * 3600.0 + mins * 60.0 + secs;
    }
    return double.tryParse(timeStr) ?? 0.0;
  }

  static String _formatLrcTime(double timeInSecs) {
    final int ms = (timeInSecs * 1000).toInt();
    final int minutes = ms ~/ 60000;
    final int seconds = (ms % 60000) ~/ 1000;
    final int centiseconds = (ms % 1000) ~/ 10;
    
    final minStr = minutes.toString().padLeft(2, '0');
    final secStr = seconds.toString().padLeft(2, '0');
    final csStr = centiseconds.toString().padLeft(2, '0');
    
    return "[$minStr:$secStr.$csStr]";
  }

  static String toLRC(String ttml) {
    try {
      final document = xml.XmlDocument.parse(ttml);
      double globalOffset = 0.0;
      
      // Try to find audio metadata offset
      final audioNode = document.findAllElements('audio').firstOrNull;
      if (audioNode != null) {
        globalOffset = double.tryParse(audioNode.getAttribute('lyricOffset') ?? '') ?? 0.0;
      }

      final pNodes = document.findAllElements('p');
      final List<String> lrcLines = [];
      final Set<String> agents = {};

      for (var p in pNodes) {
        final beginAttr = p.getAttribute('begin');
        final agentAttr = p.getAttribute('agent') ?? p.parent?.getAttribute('agent') ?? '';
        final roleAttr = p.getAttribute('role') ?? '';
        final isBackground = roleAttr == 'x-bg';

        if (agentAttr.isNotEmpty) {
          agents.add(agentAttr.toLowerCase());
        }

        if (beginAttr == null || beginAttr.isEmpty) continue;
        
        final startTime = _parseTime(beginAttr) + globalOffset;
        final timeTag = _formatLrcTime(startTime);
        
        // Collect span elements
        final spans = p.findElements('span');
        String lineText = "";
        
        if (spans.isEmpty) {
          lineText = p.innerText.trim();
        } else {
          final List<String> wordTimings = [];
          for (var span in spans) {
            final spanRole = span.getAttribute('role') ?? '';
            if (spanRole == 'x-translation' || spanRole == 'x-roman') continue;
            
            final spanBegin = span.getAttribute('begin');
            final spanEnd = span.getAttribute('end');
            final text = span.innerText;
            lineText += text;
            
            if (spanBegin != null && spanEnd != null) {
              final wStart = _parseTime(spanBegin) + globalOffset;
              final wEnd = _parseTime(spanEnd) + globalOffset;
              wordTimings.add("${text.trim()}:$wStart:$wEnd");
            }
          }
          if (wordTimings.isNotEmpty) {
            // Keep word-level timings in standard <word:start:end|...> format
            // but we will also support plain line synced
          }
        }
        
        if (lineText.trim().isEmpty) continue;

        String agentTag = "";
        if (isBackground) {
          agentTag = "{bg}";
        } else if (agents.length > 1 && agentAttr.isNotEmpty) {
          final String mappedAgent = agentAttr.toLowerCase().contains('v2') || agentAttr.toLowerCase() == 'v2' ? 'v2' : 'v1';
          agentTag = "{agent:$mappedAgent}";
        }
        
        lrcLines.add("$timeTag$agentTag${lineText.trim()}");
      }
      return lrcLines.join("\n");
    } catch (e) {
      printERROR("Failed to parse TTML: $e");
      return "";
    }
  }
}

// ----------------------------------------------------
// 2. BETTER LYRICS (APPLE MUSIC WRAPPER)
// ----------------------------------------------------
class BetterLyricsProvider implements LyricsProvider {
  @override
  String get name => "BetterLyrics";

  final Dio _dio = Dio();

  @override
  Future<List<LyricsSearchResult>> search(String query, {String? trackName, String? artistName, int? duration, String? album}) async {
    try {
      final tName = trackName ?? query;
      final aName = artistName ?? "";
      final response = await _dio.get("https://lyrics-api.boidu.dev/getLyrics", queryParameters: {
        's': tName,
        'a': aName,
        if (duration != null && duration > 0) 'd': duration,
        if (album != null && album.isNotEmpty) 'al': album,
      });

      if (response.statusCode == 200 && response.data is Map) {
        final data = response.data;
        final String? ttml = data['ttml']?.toString();
        if (ttml != null && ttml.trim().isNotEmpty) {
          final lrc = TTMLParser.toLRC(ttml);
          if (lrc.isNotEmpty) {
            return [
              LyricsSearchResult(
                providerName: name,
                trackName: tName,
                artistName: aName,
                albumName: album,
                duration: duration,
                lyrics: lrc,
                isSynced: true,
              )
            ];
          }
        }
      }
    } catch (e) {
      printERROR("BetterLyrics search failed: $e");
    }
    return [];
  }
}

// ----------------------------------------------------
// 3. PAXSENIX PROVIDER (APPLE MUSIC)
// ----------------------------------------------------
class PaxsenixProvider implements LyricsProvider {
  @override
  String get name => "Paxsenix";

  final Dio _dio = Dio();
  String? _appleToken;

  Future<String> _getAppleToken() async {
    if (_appleToken != null) return _appleToken!;
    try {
      final res = await _dio.get("https://beta.music.apple.com");
      final body = res.data.toString();
      final indexJsRegex = RegExp(r'/assets/index~[^/]+\.js');
      final match = indexJsRegex.firstMatch(body);
      if (match != null) {
        final jsPath = match.group(0);
        final jsRes = await _dio.get("https://beta.music.apple.com$jsPath");
        final jsBody = jsRes.data.toString();
        final tokenRegex = RegExp(r'eyJh([^"]*)');
        final tokenMatch = tokenRegex.firstMatch(jsBody);
        if (tokenMatch != null) {
          _appleToken = tokenMatch.group(0);
          return _appleToken!;
        }
      }
    } catch (e) {
      printERROR("Paxsenix failed to fetch Apple token: $e");
    }
    return "";
  }

  @override
  Future<List<LyricsSearchResult>> search(String query, {String? trackName, String? artistName, int? duration, String? album}) async {
    try {
      final tName = trackName ?? query;
      final aName = artistName ?? "";
      final searchQ = "$tName $aName".trim();
      final token = await _getAppleToken();
      if (token.isEmpty) return [];

      final searchRes = await _dio.get(
        "https://amp-api.music.apple.com/v1/catalog/us/search",
        queryParameters: {
          'term': searchQ,
          'types': 'songs',
          'limit': 10,
          'l': 'en-US',
          'platform': 'web',
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Origin': 'https://music.apple.com',
          'Referer': 'https://music.apple.com/',
        }),
      );

      final List<LyricsSearchResult> results = [];
      if (searchRes.statusCode == 200 && searchRes.data is Map) {
        final songsData = searchRes.data['results']?['songs']?['data'];
        if (songsData is List) {
          for (var song in songsData) {
            final attrs = song['attributes'];
            if (attrs == null) continue;
            final String trackId = song['id']?.toString() ?? '';
            final String songTitle = attrs['name'] ?? '';
            final String songArtist = attrs['artistName'] ?? '';
            final String? songAlbum = attrs['albumName'];
            final int? songDuration = (attrs['durationInMillis'] as num?)?.toInt() != null
                ? ((attrs['durationInMillis'] as num).toInt() ~/ 1000)
                : null;

            // Fetch lyrics from Paxsenix API for this track ID
            try {
              final lyricRes = await _dio.get(
                "https://lyrics.paxsenix.org/apple-music/lyrics",
                queryParameters: {'id': trackId},
              );

              if (lyricRes.statusCode == 200 && lyricRes.data is Map) {
                final ttml = lyricRes.data['ttmlContent']?.toString();
                String lyricsText = "";
                bool synced = false;

                if (ttml != null && ttml.trim().isNotEmpty) {
                  lyricsText = TTMLParser.toLRC(ttml);
                  synced = lyricsText.isNotEmpty;
                }

                if (lyricsText.isEmpty) {
                  lyricsText = lyricRes.data['elrc']?.toString() ?? lyricRes.data['plain']?.toString() ?? '';
                  synced = lyricRes.data['elrc'] != null;
                }

                if (lyricsText.isNotEmpty) {
                  results.add(LyricsSearchResult(
                    providerName: name,
                    trackName: songTitle,
                    artistName: songArtist,
                    albumName: songAlbum,
                    duration: songDuration,
                    lyrics: lyricsText,
                    isSynced: synced,
                  ));
                }
              }
            } catch (e) {
              // Ignore single track fetch errors to proceed with next search result
            }
          }
        }
      }
      return results;
    } catch (e) {
      printERROR("Paxsenix search failed: $e");
    }
    return [];
  }
}

// ----------------------------------------------------
// 4. KUGOU PROVIDER
// ----------------------------------------------------
class KugouProvider implements LyricsProvider {
  @override
  String get name => "KuGou";

  final Dio _dio = Dio();

  @override
  Future<List<LyricsSearchResult>> search(String query, {String? trackName, String? artistName, int? duration, String? album}) async {
    try {
      final tName = trackName ?? query;
      final aName = artistName ?? "";
      final searchQ = "$tName $aName".trim();

      // Step 1: Search song to get hashes
      final songRes = await _dio.get(
        "https://mobileservice.kugou.com/api/v3/search/song",
        queryParameters: {
          'version': 9108,
          'plat': 0,
          'pagesize': 8,
          'showtype': 0,
          'keyword': searchQ,
        },
      );

      final List<LyricsSearchResult> results = [];
      if (songRes.statusCode == 200 && songRes.data is Map) {
        final infoList = songRes.data['data']?['info'];
        if (infoList is List) {
          for (var item in infoList) {
            final String hash = item['hash']?.toString() ?? '';
            final String songName = item['songname'] ?? '';
            final String singerName = item['singername'] ?? '';
            final String? albumName = item['album_name'];
            final int songDur = (item['duration'] as num?)?.toInt() ?? 0;

            if (hash.isEmpty) continue;

            // Step 2: Search lyrics candidates by hash
            try {
              final lyrSearch = await _dio.get(
                "https://lyrics.kugou.com/search",
                queryParameters: {
                  'ver': 1,
                  'man': 'yes',
                  'client': 'pc',
                  'hash': hash,
                },
              );

              if (lyrSearch.statusCode == 200 && lyrSearch.data is Map) {
                final candidates = lyrSearch.data['candidates'];
                if (candidates is List && candidates.isNotEmpty) {
                  final cand = candidates.first;
                  final String lyrId = cand['id']?.toString() ?? '';
                  final String accessKey = cand['accesskey']?.toString() ?? '';

                  if (lyrId.isNotEmpty && accessKey.isNotEmpty) {
                    // Step 3: Download lyrics
                    final lyrDownload = await _dio.get(
                      "https://lyrics.kugou.com/download",
                      queryParameters: {
                        'fmt': 'lrc',
                        'charset': 'utf8',
                        'client': 'pc',
                        'ver': 1,
                        'id': lyrId,
                        'accesskey': accessKey,
                      },
                    );

                    if (lyrDownload.statusCode == 200 && lyrDownload.data is Map) {
                      final String? contentB64 = lyrDownload.data['content']?.toString();
                      if (contentB64 != null && contentB64.isNotEmpty) {
                        final String rawLrc = utf8.decode(base64.decode(contentB64));
                        results.add(LyricsSearchResult(
                          providerName: name,
                          trackName: songName,
                          artistName: singerName,
                          albumName: albumName,
                          duration: songDur,
                          lyrics: rawLrc,
                          isSynced: rawLrc.contains(RegExp(r'\[\d\d:\d\d\.\d{2,3}\]')),
                        ));
                      }
                    }
                  }
                }
              }
            } catch (e) {
              // Ignore single candidate errors
            }
          }
        }
      }
      return results;
    } catch (e) {
      printERROR("Kugou search failed: $e");
    }
    return [];
  }
}
