import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/music_discovery_provider.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/providers/public_ip_resolver.dart';
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
    expect(results.tracks.single.identity.providerId,
        StreamingProvider.providerId);
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

  test(
      'routes rich catalog requests through streaming server with playback context',
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

  test('uses context clientIp without querying the public IP resolver',
      () async {
    final ipAdapter = _MockIpResolverAdapter(ip: '198.51.100.99');
    final ipResolver = PublicIpResolver(
      client: Dio()..httpClientAdapter = ipAdapter,
    );

    final customProvider = StreamingProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => 'joss-red-jwt',
      playbackContextLoader: () async => const StreamingPlaybackContext(
        clientIp: '203.0.113.8',
        visitorData: 'visitor-token',
      ),
      ipResolver: ipResolver,
      client: dio,
    );
    await customProvider
        .initialize(const MusicProviderContext(profileId: 'personal'));

    final track = (await customProvider.getTrack('t1'))!;
    await customProvider.getPlayback(track);

    expect(adapter.lastPlaybackRequest?['clientIp'], '203.0.113.8');
    expect(ipAdapter.requestCount, 0,
        reason: 'IP resolver should not be called when context has clientIp');
  });

  test(
      'resolves clientIp lazily and sends it in playback and download when missing from context',
      () async {
    final ipAdapter = _MockIpResolverAdapter(ip: '198.51.100.50');
    final ipResolver = PublicIpResolver(
      client: Dio()..httpClientAdapter = ipAdapter,
    );

    final lazyProvider = StreamingProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => 'joss-red-jwt',
      playbackContextLoader: () async => const StreamingPlaybackContext(
        visitorData: 'visitor-token',
      ),
      ipResolver: ipResolver,
      client: dio,
    );
    await lazyProvider
        .initialize(const MusicProviderContext(profileId: 'lazy-profile'));

    expect(ipAdapter.requestCount, 0,
        reason:
            'App startup and provider initialize must not block on IP lookup');

    final track = (await lazyProvider.getTrack('t1'))!;
    await lazyProvider.getPlayback(track);

    expect(ipAdapter.requestCount, 1);
    expect(adapter.lastPlaybackRequest?['clientIp'], '198.51.100.50');

    await lazyProvider.getDownload(track, format: 'opus');
    expect(adapter.lastDownloadRequest?['clientIp'], '198.51.100.50');
    expect(ipAdapter.requestCount, 1,
        reason: 'Cached IP is reused across playback and download');
  });

  test('resolver failure does not crash playback and omits clientIp gracefully',
      () async {
    final ipResolver = PublicIpResolver(
      client: Dio()..httpClientAdapter = _FailingIpResolverAdapter(),
    );

    final fallbackProvider = StreamingProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => 'joss-red-jwt',
      playbackContextLoader: () async => const StreamingPlaybackContext(),
      ipResolver: ipResolver,
      client: dio,
    );
    await fallbackProvider
        .initialize(const MusicProviderContext(profileId: 'fallback'));

    final track = (await fallbackProvider.getTrack('t1'))!;
    final source = await fallbackProvider.getPlayback(track);

    expect(source.type, PlaybackSourceType.authorizedStream);
    expect(adapter.lastPlaybackRequest?.containsKey('clientIp'), isFalse);
  });

  test(
      'resolves stream directly on device via server recipe without server playback fallback',
      () async {
    adapter.enableRecipe = true;
    final track = (await provider.getTrack('t1'))!;
    final source = await provider.getPlayback(track);

    expect(source.type, PlaybackSourceType.authorizedStream);
    expect(source.uri.toString(), 'https://stream.direct.test/audio.m4a');
    expect(source.bitrate, 320000);
    expect(adapter.recipeRequestCount, 1);
    expect(adapter.upstreamPlayerRequestCount, 1);
    expect(adapter.playbackRequestCount, 0,
        reason: 'Direct recipe execution avoids server playback endpoint');
  });

  test(
      'resolves download directly on device via server recipe without server download fallback',
      () async {
    adapter.enableRecipe = true;
    final track = (await provider.getTrack('t1'))!;
    final source = await provider.getDownload(track, format: 'opus');

    expect(source.type, PlaybackSourceType.authorizedStream);
    expect(source.uri.toString(), 'https://stream.direct.test/audio.opus');
    expect(source.bitrate, 160000);
    expect(adapter.recipeRequestCount, 1);
    expect(adapter.upstreamPlayerRequestCount, 1);
    expect(adapter.downloadRequestCount, 0,
        reason: 'Direct recipe execution avoids server download endpoint');
  });
}

class _StreamingAdapter implements HttpClientAdapter {
  bool enableRecipe = false;
  Map<String, dynamic>? lastPlaybackRequest;
  Map<String, dynamic>? lastCatalogRequest;
  Map<String, dynamic>? lastDownloadRequest;
  String? lastProfileId;
  int catalogRequestCount = 0;
  int libraryRequestCount = 0;
  int playbackRequestCount = 0;
  int downloadRequestCount = 0;
  int recipeRequestCount = 0;
  int upstreamPlayerRequestCount = 0;

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
    } else if (path.endsWith('/resolve-recipe') && enableRecipe) {
      recipeRequestCount++;
      body = {
        'status': 'success',
        'data': {
          'status': 'success',
          'videoId': 't1',
          'candidates': [
            {
              'url': 'https://upstream.test/player',
              'method': 'POST',
              'headers': {'User-Agent': 'MockClient/1.0'},
              'body': {'videoId': 't1'},
              'playbackHeaders': {'User-Agent': 'MockClient/1.0'},
            }
          ]
        }
      };
    } else if (options.uri.host == 'upstream.test') {
      upstreamPlayerRequestCount++;
      body = {
        'playabilityStatus': {'status': 'OK'},
        'streamingData': {
          'adaptiveFormats': [
            {
              'url': 'https://stream.direct.test/audio.m4a',
              'mimeType': 'audio/mp4; codecs="mp4a.40.2"',
              'bitrate': 320000,
              'contentLength': 234567,
              'loudnessDb': -1.5,
            },
            {
              'url': 'https://stream.direct.test/audio.opus',
              'mimeType': 'audio/webm; codecs="opus"',
              'bitrate': 160000,
              'contentLength': 123456,
              'loudnessDb': -1.5,
            }
          ]
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

class _MockIpResolverAdapter implements HttpClientAdapter {
  _MockIpResolverAdapter({required this.ip});

  final String ip;
  int requestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    final encoded = utf8.encode(jsonEncode({'ip': ip}));
    return ResponseBody.fromBytes(
      encoded,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FailingIpResolverAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
      error: 'Cannot reach IP service',
    );
  }

  @override
  void close({bool force = false}) {}
}
