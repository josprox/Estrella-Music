import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/providers/musicbrainz_metadata_provider.dart';

void main() {
  test('searches MusicBrainz without account and maps public metadata',
      () async {
    final adapter = _MusicBrainzAdapter();
    final provider = MusicBrainzMetadataProvider(
      client: Dio()..httpClientAdapter = adapter,
      minimumRequestInterval: Duration.zero,
    );
    await provider.initialize(
      const MusicProviderContext(profileId: 'public-metadata'),
    );

    final first = await provider.searchMetadata('8 AM Nicki Nicole');
    final cached = await provider.searchMetadata('8 AM Nicki Nicole');

    expect(first, hasLength(1));
    expect(first.single.sourceId, 'musicbrainz:recording-id');
    expect(first.single.title, '8 AM');
    expect(first.single.artist, 'Nicki Nicole & Young Miko');
    expect(first.single.album, '8 AM');
    expect(first.single.duration, const Duration(milliseconds: 147603));
    expect(first.single.year, 2023);
    expect(first.single.trackNumber, 1);
    expect(
      first.single.artworkUri.toString(),
      'https://coverartarchive.org/release-group/group-id/front-500',
    );
    expect(cached.single.title, '8 AM');
    expect(adapter.requestCount, 1, reason: 'repeated queries use local cache');
    expect(adapter.lastAuthorization, isNull,
        reason: 'public lookup must not receive Joss Red credentials');
    expect(adapter.lastUserAgent, contains('EstrellaMusic/2.4.0'));
  });

  test('serializes simultaneous lookups and shares the cached response',
      () async {
    final adapter = _MusicBrainzAdapter();
    final provider = MusicBrainzMetadataProvider(
      client: Dio()..httpClientAdapter = adapter,
      minimumRequestInterval: Duration.zero,
    );

    final results = await Future.wait([
      provider.searchMetadata('8 AM Nicki Nicole'),
      provider.searchMetadata('8 AM Nicki Nicole'),
    ]);

    expect(results.every((items) => items.single.title == '8 AM'), isTrue);
    expect(adapter.requestCount, 1);
  });
}

class _MusicBrainzAdapter implements HttpClientAdapter {
  int requestCount = 0;
  String? lastAuthorization;
  String? lastUserAgent;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    lastAuthorization = options.headers['Authorization']?.toString();
    lastUserAgent = options.headers['User-Agent']?.toString();
    expect(options.uri.host, 'musicbrainz.org');
    expect(options.uri.queryParameters['fmt'], 'json');
    return ResponseBody.fromString(
      jsonEncode({
        'recordings': [
          {
            'id': 'recording-id',
            'title': '8 AM',
            'length': 147603,
            'first-release-date': '2023-05-17',
            'artist-credit': [
              {'name': 'Nicki Nicole', 'joinphrase': ' & '},
              {'name': 'Young Miko'},
            ],
            'releases': [
              {
                'id': 'release-id',
                'title': '8 AM',
                'status': 'Official',
                'date': '2023-05-17',
                'release-group': {
                  'id': 'group-id',
                  'title': '8 AM',
                  'primary-type': 'Single',
                },
                'media': [
                  {
                    'track': [
                      {'number': '1', 'title': '8 AM'}
                    ]
                  }
                ],
              }
            ],
          }
        ],
      }),
      200,
      headers: {
        Headers.contentTypeHeader: ['application/json']
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
