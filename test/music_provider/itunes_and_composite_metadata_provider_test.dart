import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/music_provider/models/music_identity.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/models/provider_capabilities.dart';
import 'package:estrella_music/music_provider/models/provider_entities.dart';
import 'package:estrella_music/music_provider/music_metadata_editor.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/providers/composite_metadata_provider.dart';
import 'package:estrella_music/music_provider/providers/itunes_metadata_provider.dart';

void main() {
  test('ItunesMetadataProvider queries iTunes Search API and transforms artwork to high-res',
      () async {
    final dio = Dio();
    dio.httpClientAdapter = _MockHttpClientAdapter((options) async {
      expect(options.path, 'https://itunes.apple.com/search');
      expect(options.queryParameters['term'], 'Daft Punk Get Lucky');
      final payload = {
        'resultCount': 1,
        'results': [
          {
            'trackId': 123456,
            'trackName': 'Get Lucky',
            'artistName': 'Daft Punk',
            'collectionName': 'Random Access Memories',
            'trackTimeMillis': 248000,
            'artworkUrl100':
                'https://is1-ssl.mzstatic.com/image/thumb/Music/v4/100x100bb.jpg',
            'releaseDate': '2013-04-19T07:00:00Z',
            'trackNumber': 8,
            'primaryGenreName': 'Pop',
          }
        ]
      };
      return ResponseBody.fromString(
        jsonEncode(payload),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    });

    final provider = ItunesMetadataProvider(
      client: dio,
      minimumRequestInterval: Duration.zero,
    );

    final candidates =
        await provider.searchMetadata('Daft Punk Get Lucky');
    expect(candidates, hasLength(1));
    final candidate = candidates.first;
    expect(candidate.title, 'Get Lucky');
    expect(candidate.artist, 'Daft Punk');
    expect(candidate.album, 'Random Access Memories');
    expect(candidate.year, 2013);
    expect(candidate.trackNumber, 8);
    expect(candidate.genre, 'Pop');
    expect(
      candidate.artworkUri.toString(),
      'https://is1-ssl.mzstatic.com/image/thumb/Music/v4/600x600bb.jpg',
    );
  });

  test('CompositeMetadataProvider falls back to secondary when primary returns empty',
      () async {
    final primary = _FakeMetadataSearchProvider(
      id: 'fake.primary',
      results: const [],
    );
    final fallback = _FakeMetadataSearchProvider(
      id: 'fake.fallback',
      results: const [
        TrackMetadataCandidate(
          sourceId: 'mb:1',
          title: 'Fallback Song',
          artist: 'Fallback Artist',
          album: 'Fallback Album',
        )
      ],
    );

    final composite = CompositeMetadataProvider(
      primary: primary,
      fallback: fallback,
    );

    final results = await composite.searchMetadata('Fallback Song');
    expect(results, hasLength(1));
    expect(results.first.title, 'Fallback Song');
  });
}

class _MockHttpClientAdapter implements HttpClientAdapter {
  _MockHttpClientAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) =>
      handler(options);

  @override
  void close({bool force = false}) {}
}

class _FakeMetadataSearchProvider implements MusicMetadataSearchProvider {
  _FakeMetadataSearchProvider({
    required this.id,
    required this.results,
  });

  @override
  final String id;
  final List<TrackMetadataCandidate> results;

  @override
  String get displayName => id;

  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(
        search: true,
        artwork: true,
      );

  @override
  Future<void> initialize(MusicProviderContext context) async {}
  @override
  Future<List<TrackMetadataCandidate>> searchMetadata(String query,
          {int limit = 20}) async =>
      results;
  @override
  Future<ProviderSearchResults> search(String query) async =>
      const ProviderSearchResults();
  @override
  Future<void> refresh() async {}
  @override
  Future<List<ProviderTrack>> getTracks() async => const [];
  @override
  Future<ProviderTrack?> getTrack(String sourceId) async => null;
  @override
  Future<List<ProviderAlbum>> getAlbums() async => const [];
  @override
  Future<ProviderAlbum?> getAlbum(String sourceId) async => null;
  @override
  Future<List<ProviderArtist>> getArtists() async => const [];
  @override
  Future<ProviderArtist?> getArtist(String sourceId) async => null;
  @override
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity) async => null;
  @override
  Future<ProviderLyrics?> getLyrics(ProviderTrack track) async => null;
  @override
  Future<PlaybackSource> getPlayback(ProviderTrack track) =>
      throw const MusicProviderException('no playback');
  @override
  Future<void> dispose() async {}
}
