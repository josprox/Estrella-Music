import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harmonymusic/music_provider/models/playback_source.dart';
import 'package:harmonymusic/music_provider/music_discovery_provider.dart';
import 'package:harmonymusic/music_provider/music_provider.dart';
import 'package:harmonymusic/music_provider/providers/emusic_provider.dart';

void main() {
  late Dio dio;
  late EMusicProvider provider;
  late _EMusicAdapter adapter;

  setUp(() async {
    adapter = _EMusicAdapter();
    dio = Dio()..httpClientAdapter = adapter;
    provider = EMusicProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => 'joss-red-jwt',
      playbackContextLoader: () async => const EMusicPlaybackContext(
        clientIp: '203.0.113.8',
        visitorData: 'visitor-token',
        poToken: 'po-token',
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
        results.tracks.single.identity.providerId, EMusicProvider.providerId);
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
    expect(source.type, PlaybackSourceType.authorizedStream);
    expect(source.uri.toString(), 'https://stream.test/t1.m4a');
    expect(source.headers['X-Playback'], 'authorized');
    expect(adapter.lastPlaybackRequest?['clientIp'], '203.0.113.8');
    expect(adapter.lastPlaybackRequest?['visitorData'], 'visitor-token');
    expect(adapter.lastPlaybackRequest?['poToken'], 'po-token');
    expect(adapter.lastProfileId, 'personal');
  });

  test('routes rich catalog requests through eMusic with playback context',
      () async {
    final discovery = provider as MusicDiscoveryProvider;
    expect(await discovery.getSearchSuggestion('estrella'), ['Estrella Music']);
    expect(
        adapter.lastCatalogRequest?['action'], 'music/get_search_suggestions');
    expect(adapter.lastCatalogRequest?['visitorData'], 'visitor-token');
    expect(adapter.lastCatalogRequest?['clientIp'], '203.0.113.8');
    expect(adapter.lastCatalogRequest?['poToken'], 'po-token');
    expect(adapter.lastProfileId, 'personal');
  });

  test('reports missing authentication and provider errors explicitly',
      () async {
    final unauthenticated = EMusicProvider(
      baseUrl: () => 'https://emusic.test',
      tokenLoader: () async => null,
      client: dio,
    );
    expect(
      () => unauthenticated.initialize(
        const MusicProviderContext(profileId: 'blocked'),
      ),
      throwsA(isA<MusicProviderException>()),
    );
    expect(() => provider.getTrack('missing'),
        throwsA(isA<MusicProviderException>()));
  });
}

class _EMusicAdapter implements HttpClientAdapter {
  Map<String, dynamic>? lastPlaybackRequest;
  Map<String, dynamic>? lastCatalogRequest;
  String? lastProfileId;

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
      lastCatalogRequest = Map<String, dynamic>.from(options.data as Map);
      lastProfileId = options.headers['X-Music-Profile-Id']?.toString();
      body = {
        'status': 'success',
        'data': {
          'response': {
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
        }
      };
    } else if (path.endsWith('/search')) {
      body = {
        'status': 'success',
        'data': {
          'tracks': [_track],
          'albums': [_album],
          'artists': [_artist],
        }
      };
    } else if (path.endsWith('/tracks/t1')) {
      body = {
        'status': 'success',
        'data': {'track': _track}
      };
    } else if (path.endsWith('/tracks/missing')) {
      status = 404;
      body = {'status': 'error', 'message': 'Track not found'};
    } else if (path.endsWith('/albums/a1')) {
      body = {
        'status': 'success',
        'data': {'album': _album}
      };
    } else if (path.endsWith('/artists/r1')) {
      body = {
        'status': 'success',
        'data': {'artist': _artist}
      };
    } else if (path.endsWith('/artwork/t1')) {
      body = {
        'status': 'success',
        'data': {'url': 'https://img.test/star.jpg'}
      };
    } else if (path.endsWith('/playback')) {
      lastPlaybackRequest = Map<String, dynamic>.from(options.data as Map);
      lastProfileId = options.headers['X-Music-Profile-Id']?.toString();
      body = {
        'status': 'success',
        'data': {
          'url': 'https://stream.test/t1.m4a',
          'mimeType': 'audio/mp4',
          'bitrate': 256000,
          'headers': {'X-Playback': 'authorized'},
        }
      };
    } else {
      status = 404;
      body = {'status': 'error', 'message': 'Not found'};
    }
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json']
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _track = {
  'sourceId': 't1',
  'title': 'Star',
  'artist': 'Estrella',
  'album': 'Sky',
  'duration': 180,
  'thumbnailUrl': 'https://img.test/star.jpg',
};

const _album = {
  'sourceId': 'a1',
  'title': 'Sky',
  'artist': 'Estrella',
  'tracks': [_track],
};

const _artist = {
  'sourceId': 'r1',
  'name': 'Estrella',
  'albums': [_album],
  'tracks': [_track],
};
