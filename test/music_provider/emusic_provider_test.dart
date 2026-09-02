import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/music_discovery_provider.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/providers/streaming_provider.dart';

void main() {
  late Dio dio;
  late StreamingProvider provider;
  late _StreamingAdapter adapter;

  setUp(() async {
    adapter = _StreamingAdapter();
    dio = Dio()..httpClientAdapter = adapter;
    provider = StreamingProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => 'joss-red-jwt',
      playbackContextLoader: () async => const StreamingPlaybackContext(
        clientIp: '203.0.113.8',
        visitorData: 'visitor-token',
      ),
      client: dio,
    );
    await provider
        .initialize(const MusicProviderContext(profileId: 'personal'));
  });

  test('declares capabilities and maps search entities with profile identity',
      () async {
    expect(provider.capabilities.search, isTrue);
    expect(provider.capabilities.sync, isTrue);

    final results = await provider.search('star');
    expect(results.tracks.single.title, 'Star');
    expect(
        results.tracks.single.identity.providerId, StreamingProvider.providerId);
    expect(results.tracks.single.identity.profileId, 'personal');
    expect(results.albums.single.title, 'Sky');
    expect(results.artists.single.name, 'Estrella');
  });

  test('loads track, album, artist, artwork and authorized playback', () async {
    expect((await provider.getTrack('t1'))?.title, 'Star');
    expect(
        (await provider.getAlbum('a1'))?.tracks.single.identity.sourceId, 't1');
    expect((await provider.getArtist('r1'))?.albums.single.identity.sourceId,
        'a1');

    final artwork = await provider.getArtwork(
      (await provider.getTrack('t1'))!.identity,
    );
    expect(artwork?.uri.toString(), 'https://img.test/star.jpg');

    final source = await provider.getPlayback((await provider.getTrack('t1'))!);
    final cachedSource =
        await provider.getPlayback((await provider.getTrack('t1'))!);
    expect(source.type, PlaybackSourceType.authorizedStream);
    expect(source.uri.toString(), 'https://stream.test/t1.m4a');
    expect(cachedSource.uri, source.uri);
    expect(source.headers['X-Playback'], 'authorized');
    expect(adapter.lastPlaybackRequest?['clientIp'], '203.0.113.8');
    expect(adapter.lastPlaybackRequest?['visitorData'], 'visitor-token');
    expect(adapter.lastProfileId, 'personal');
    expect(adapter.libraryRequestCount, 1,
        reason: 'all library entity reads share one snapshot');
    expect(adapter.playbackRequestCount, 1);
  });

  test('coalesces concurrent library reads into one server request', () async {
    await Future.wait<dynamic>([
      provider.getTracks(),
      provider.getAlbums(),
      provider.getArtists(),
      provider.getTrack('t1'),
    ]);

    expect(adapter.libraryRequestCount, 1);
  });

  test('requests a dedicated authorized download source with the format',
      () async {
    final source = await provider.getDownload(
      (await provider.getTrack('t1'))!,
      format: 'opus',
    );
    await provider.getDownload(
      (await provider.getTrack('t1'))!,
      format: 'opus',
    );

    expect(source.uri.toString(), 'https://download.test/t1.opus');
    expect(source.headers['X-Download'], 'authorized');
    expect(source.contentLength, 123456);
    expect(adapter.lastDownloadRequest?['format'], 'opus');
    expect(adapter.lastDownloadRequest?['visitorData'], 'visitor-token');
    expect(adapter.downloadRequestCount, 1);
    expect(adapter.lastProfileId, 'personal');
  });

  test('routes rich catalog requests through streaming server with playback context',
      () async {
    final discovery = provider as MusicDiscoveryProvider;
    expect(await discovery.getSearchSuggestion('estrella'), ['Estrella Music']);
    expect(
        adapter.lastCatalogRequest?['action'], 'music/get_search_suggestions');
    expect(adapter.lastProfileId, 'personal');
    expect(adapter.catalogRequestCount, 1);
  });

  test('keeps a streaming profile active when capabilities are unavailable',
      () async {
    final offline = StreamingProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => 'joss-red-jwt',
      client: Dio()..httpClientAdapter = _OfflineAdapter(),
    );

    await offline.initialize(const MusicProviderContext(profileId: 'offline'));
    expect(offline.capabilities.tracks, isTrue);
    expect(offline.capabilities.sync, isTrue);
  });

  test('reports missing authentication and provider errors explicitly',
      () async {
    final unauthenticated = StreamingProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => null,
      client: dio,
    );
    expect(
      unauthenticated.initialize(
        const MusicProviderContext(profileId: 'blocked'),
      ),
      throwsA(isA<MusicProviderException>()),
    );
    expect(await provider.getTrack('missing'), isNull);
  });
}

class _StreamingAdapter implements HttpClientAdapter {
  Map<String, dynamic>? lastPlaybackRequest;
  Map<String, dynamic>? lastCatalogRequest;
  Map<String, dynamic>? lastDownloadRequest;
  String? lastProfileId;
  int catalogRequestCount = 0;
  int libraryRequestCount = 0;
  int playbackRequestCount = 0;
  int downloadRequestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final path = options.uri.path;
    dynamic body;
    var status = 200;
    if (path.endsWith('/capabilities')) {
      body = {
        'status': 'success',
        'data': {
          'capabilities': {
            'search': true,
            'playback': true,
            'tracks': true,
            'albums': true,
            'artists': true,
            'artwork': true,
            'lyrics': false,
            'sync': true,
          }
        }
      };
    } else if (path.endsWith('/catalog')) {
      catalogRequestCount++;
      lastCatalogRequest = Map<String, dynamic>.from(options.data as Map);
      lastProfileId = options.headers['X-Music-Profile-Id']?.toString();
      final action = lastCatalogRequest?['action']?.toString();
      if (action == 'music/get_search_suggestions') {
        body = {
          'status': 'success',
          'data': {
            'contents': [
              {
                'searchSuggestionsSectionRenderer': {
                  'contents': [
                    {
                      'searchSuggestionRenderer': {
                        'navigationEndpoint': {
                          'searchEndpoint': {'query': 'Estrella Music'}
                        }
                      }
                    }
                  ]
                }
              }
            ]
          }
        };
      } else {
        body = {
          'status': 'success',
          'data': {
            'tracks': [
              {
                'sourceId': 't1',
                'title': 'Star',
                'artist': 'Estrella',
                'album': 'Sky',
                'duration': 180,
                'artworkUrl': 'https://img.test/star.jpg',
              }
            ],
            'albums': [
              {
                'sourceId': 'a1',
                'title': 'Sky',
                'artist': 'Estrella',
                'artworkUrl': 'https://img.test/star.jpg',
                'tracks': [
                  {
                    'sourceId': 't1',
                    'title': 'Star',
                    'artist': 'Estrella',
                    'album': 'Sky',
                    'duration': 180,
                  }
                ]
              }
            ],
            'artists': [
              {
                'sourceId': 'r1',
                'name': 'Estrella',
                'tracks': [],
                'albums': [],
              }
            ],
            'query': 'estrella',
          }
        };
      }
    } else if (path.endsWith('/library')) {
      libraryRequestCount++;
      body = {
        'status': 'success',
        'data': {
          'tracks': [
            {
              'sourceId': 't1',
              'title': 'Star',
              'artist': 'Estrella',
              'album': 'Sky',
              'duration': 180,
              'artworkUrl': 'https://img.test/star.jpg',
            }
          ],
          'albums': [
            {
              'sourceId': 'a1',
              'title': 'Sky',
              'artist': 'Estrella',
              'tracks': [
                {
                  'sourceId': 't1',
                  'title': 'Star',
                  'artist': 'Estrella',
                  'album': 'Sky',
                  'duration': 180,
                }
              ]
            }
          ],
          'artists': [
            {
              'sourceId': 'r1',
              'name': 'Estrella',
              'tracks': [],
              'albums': [
                {
                  'sourceId': 'a1',
                  'title': 'Sky',
                  'artist': 'Estrella',
                  'tracks': [],
                }
              ],
            }
          ],
        }
      };
    } else if (path.endsWith('/playback')) {
      playbackRequestCount++;
      lastPlaybackRequest = Map<String, dynamic>.from(options.data as Map);
      lastProfileId = options.headers['X-Music-Profile-Id']?.toString();
      body = {
        'status': 'success',
        'data': {
          'url': 'https://stream.test/t1.m4a',
          'headers': {'X-Playback': 'authorized'},
          'mimeType': 'audio/mp4',
          'bitrate': 256000,
          'size': 123456,
          'expiresAt':
              DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        }
      };
    } else if (path.endsWith('/download')) {
      downloadRequestCount++;
      lastDownloadRequest = Map<String, dynamic>.from(options.data as Map);
      lastProfileId = options.headers['X-Music-Profile-Id']?.toString();
      body = {
        'status': 'success',
        'data': {
          'url': 'https://download.test/t1.opus',
          'headers': {'X-Download': 'authorized'},
          'mimeType': 'audio/opus',
          'bitrate': 128000,
          'size': 123456,
          'expiresAt':
              DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        }
      };
    } else if (path.contains('/tracks/missing')) {
      status = 404;
      body = {'status': 'error', 'message': 'Missing track'};
    } else if (path.contains('/tracks/')) {
      body = {
        'status': 'success',
        'data': {
          'sourceId': 't1',
          'title': 'Star',
          'artist': 'Estrella',
          'album': 'Sky',
          'duration': 180,
          'artworkUrl': 'https://img.test/star.jpg',
        }
      };
    } else if (path.contains('/artwork/')) {
      body = {
        'status': 'success',
        'data': {'url': 'https://img.test/star.jpg'},
      };
    } else {
      status = 404;
      body = {'status': 'error', 'message': 'Not found'};
    }

    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _OfflineAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
      error: 'Offline',
    );
  }

  @override
  void close({bool force = false}) {}
}
