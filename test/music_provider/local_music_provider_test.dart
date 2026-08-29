import 'dart:io';
import 'dart:typed_data';

import 'package:audiotags/audiotags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harmonymusic/music_provider/music_provider.dart';
import 'package:harmonymusic/music_provider/models/playback_source.dart';
import 'package:harmonymusic/music_provider/providers/local_music_provider.dart';

void main() {
  late Directory root;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('estrella-local-provider-');
    await File('${root.path}${Platform.pathSeparator}track.mp3')
        .writeAsBytes([0]);
    await File('${root.path}${Platform.pathSeparator}track.lrc')
        .writeAsString('[00:01.00]Local lyric');
  });

  tearDown(() async {
    if (await root.exists()) await root.delete(recursive: true);
  });

  test('discovers local metadata, albums, artists, artwork and lyrics',
      () async {
    final provider = LocalMusicProvider(
      metadataReader: (_) async => Tag(
        title: 'Local track',
        trackArtist: 'Local artist',
        album: 'Local album',
        duration: 42000,
        pictures: [
          Picture(
            pictureType: PictureType.coverFront,
            mimeType: MimeType.png,
            bytes: Uint8List.fromList([1, 2, 3]),
          ),
        ],
      ),
    );

    await provider.initialize(MusicProviderContext(
      profileId: 'studio',
      settings: {
        'libraryRoots': [root.path]
      },
    ));

    final tracks = await provider.getTracks();
    expect(tracks, hasLength(1));
    expect(tracks.single.title, 'Local track');
    expect(tracks.single.identity.providerId, LocalMusicProvider.providerId);
    expect(tracks.single.identity.profileId, 'studio');
    expect(tracks.single.duration, const Duration(seconds: 42));

    final albums = await provider.getAlbums();
    expect(albums.single.title, 'Local album');
    expect(albums.single.tracks.single.title, 'Local track');

    final artists = await provider.getArtists();
    expect(artists.single.name, 'Local artist');
    expect(artists.single.albums.single.title, 'Local album');

    final artwork = await provider.getArtwork(tracks.single.identity);
    expect(artwork?.bytes, Uint8List.fromList([1, 2, 3]));
    expect((await provider.getLyrics(tracks.single))?.synced,
        contains('Local lyric'));
  });

  test('searches and resolves local playback without network', () async {
    final provider = LocalMusicProvider(
        metadataReader: (_) async => const Tag(
              title: 'Blue Star',
              trackArtist: 'Estrella',
              album: 'Offline',
              pictures: [],
            ));
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));

    final result = await provider.search('estrella');
    expect(result.tracks.single.title, 'Blue Star');

    final source = await provider.getPlayback(result.tracks.single);
    expect(source.type, PlaybackSourceType.localFile);
    expect(source.uri.isScheme('file'), isTrue);
    expect(File.fromUri(source.uri).existsSync(), isTrue);
    expect(provider.capabilities.sync, isFalse);
  });

  test('filters out WhatsApp and voice notes directories', () async {
    final waDir =
        Directory('${root.path}${Platform.pathSeparator}WhatsApp Audio');
    await waDir.create(recursive: true);
    await File('${waDir.path}${Platform.pathSeparator}AUD-2026.mp3')
        .writeAsBytes([0]);

    final provider = LocalMusicProvider(
      metadataReader: (_) async => const Tag(
        title: 'Voice note',
        pictures: [],
      ),
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));

    final tracks = await provider.getTracks();
    expect(
        tracks.any((t) => t.filePath?.contains('WhatsApp') == true), isFalse);
  });
}
