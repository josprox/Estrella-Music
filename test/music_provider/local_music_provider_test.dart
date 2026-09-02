import 'dart:io';
import 'dart:typed_data';

import 'package:audiotags/audiotags.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/music_metadata_editor.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/providers/local_music_provider.dart';
import 'package:estrella_music/music_provider/providers/local_song_metadata_store.dart';

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

  test('infers title and artist from filename and stores them immediately',
      () async {
    await File('${root.path}${Platform.pathSeparator}track.mp3').delete();
    final audioFile = File(
      '${root.path}${Platform.pathSeparator}'
      '01 - Daft Punk - Get Lucky (Official Audio).mp3',
    );
    await audioFile.writeAsBytes([0]);
    final metadataStore = _MemoryLocalSongMetadataStore();
    final provider = LocalMusicProvider(
      metadataReader: (_) async => null,
      metadataStore: metadataStore,
    );

    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));

    final track = (await provider.getTracks()).single;
    expect(track.title, 'Get Lucky');
    expect(track.artist, 'Daft Punk');
    final stored = metadataStore.records[track.identity.sourceId];
    expect(stored?['title'], 'Get Lucky');
    expect(stored?['artist'], 'Daft Punk');
    expect(stored?['source'], 'filename');
    expect(track.metadata['metadataSource'], 'filename');
    expect(track.metadata['metadataStoredInHive'], isTrue);
  });

  test('manual metadata replacement preserves fields missing in the match',
      () async {
    Tag current = Tag(
      title: 'Rough title',
      trackArtist: 'Old artist',
      album: 'Old album',
      genre: 'Funk',
      duration: 42000,
      pictures: [
        Picture(
          pictureType: PictureType.coverFront,
          mimeType: MimeType.png,
          bytes: Uint8List.fromList([1, 2, 3]),
        ),
      ],
    );
    final metadataStore = _MemoryLocalSongMetadataStore();
    final provider = LocalMusicProvider(
      metadataReader: (_) async => current,
      metadataStore: metadataStore,
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));
    final original = (await provider.getTracks()).single;

    final updated = await provider.applyMetadata(
      original,
      const TrackMetadataCandidate(
        sourceId: 'online-id',
        title: 'Final title',
        artist: 'Final artist',
        album: 'Final album',
        year: 2024,
      ),
    );

    expect(updated.title, 'Final title');
    expect(updated.artist, 'Final artist');
    expect(updated.album, 'Final album');
    final stored = metadataStore.records[original.identity.sourceId];
    expect(stored?['year'], 2024);
    expect(stored?['genre'], 'Funk');
    expect(stored?['source'], 'manual');
    expect(current.title, 'Rough title');
    expect(current.pictures.single.bytes, Uint8List.fromList([1, 2, 3]));

    final reloaded = LocalMusicProvider(
      metadataReader: (_) async => current,
      metadataStore: metadataStore,
    );
    await reloaded.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));
    final restored = (await reloaded.getTracks()).single;
    expect(restored.title, 'Final title');
    expect(restored.artist, 'Final artist');
    expect(restored.album, 'Final album');
    expect(restored.metadata['metadataSource'], 'manual');
  });

  test('filename parser keeps meaningful text and removes download noise', () {
    final parsed = LocalFilenameMetadata.parse(
      'C:/Music/07 - Rosalía - DESPECHÁ [Official Video].mp3',
    );

    expect(parsed.artist, 'Rosalía');
    expect(parsed.title, 'DESPECHÁ');
  });

  test('filename parser recognizes downloader title and artist parentheses',
      () {
    final parsed = LocalFilenameMetadata.parse(
      '/storage/emulated/0/Music/1TRAGO (Danna).opus',
    );
    final live = LocalFilenameMetadata.parse('C:/Music/My Song (Live).mp3');

    expect(parsed.title, '1TRAGO');
    expect(parsed.artist, 'Danna');
    expect(live.title, 'My Song (Live)');
    expect(live.artist, isNull);
  });

  test('automatic metadata is persisted and not looked up again', () async {
    final metadataStore = _MemoryLocalSongMetadataStore();
    final provider = LocalMusicProvider(
      metadataReader: (_) async => const Tag(
        title: '1TRAGO',
        trackArtist: 'Danna',
        duration: 180000,
        pictures: [],
      ),
      metadataStore: metadataStore,
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));
    final original = (await provider.getTracks()).single;
    expect(provider.shouldLookupMetadataAutomatically(original), isTrue);

    final updated = await provider.applyAutomaticMetadata(
      original,
      const TrackMetadataCandidate(
        sourceId: 'musicbrainz:1trago',
        title: '1TRAGO',
        artist: 'Danna Paola',
        album: 'K.O.',
        year: 2021,
      ),
    );

    expect(updated.artist, 'Danna Paola');
    expect(updated.album, 'K.O.');
    expect(updated.metadata['metadataSource'], 'automatic');
    expect(provider.shouldLookupMetadataAutomatically(updated), isFalse);
    final stored = metadataStore.records[original.identity.sourceId];
    expect(stored?['source'], 'automatic');
    expect(stored?['automaticLookupStatus'], 'matched');
  });

  test('an automatic no-match is persisted and not retried immediately',
      () async {
    final metadataStore = _MemoryLocalSongMetadataStore();
    final provider = LocalMusicProvider(
      metadataReader: (_) async => const Tag(
        title: 'Obscure Song',
        duration: 120000,
        pictures: [],
      ),
      metadataStore: metadataStore,
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));
    final original = (await provider.getTracks()).single;

    await provider.recordAutomaticMetadataLookup(
      original,
      AutomaticMetadataLookupOutcome.noMatch,
    );

    final refreshed = await provider.getTrack(original.identity.sourceId);
    expect(refreshed, isNotNull);
    expect(refreshed!.metadata['automaticLookupStatus'], 'no_match');
    expect(provider.shouldLookupMetadataAutomatically(refreshed), isFalse);
  });

  test('discovers directory sidecar artwork like cover.jpg', () async {
    final albumDir = Directory('${root.path}${Platform.pathSeparator}AlbumFolder');
    await albumDir.create(recursive: true);
    final songFile = File('${albumDir.path}${Platform.pathSeparator}song.mp3');
    await songFile.writeAsBytes([0]);
    final coverFile = File('${albumDir.path}${Platform.pathSeparator}cover.jpg');
    await coverFile.writeAsBytes([1, 2, 3, 4]);

    final provider = LocalMusicProvider(
      metadataReader: (_) async => const Tag(
        title: 'Sidecar Song',
        trackArtist: 'Artist',
        album: 'Album With Cover',
        pictures: [],
      ),
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [albumDir.path]
      },
    ));

    final tracks = await provider.getTracks();
    expect(tracks.single.artworkUri, isNotNull);
    expect(tracks.single.artworkUri!.toFilePath(), coverFile.path);
  });

  test('groups multiple tracks with featuring artists from the same album together',
      () async {
    final albumDir = Directory('${root.path}${Platform.pathSeparator}Thriller');
    await albumDir.create(recursive: true);
    await File('${albumDir.path}${Platform.pathSeparator}01.mp3').writeAsBytes([0]);
    await File('${albumDir.path}${Platform.pathSeparator}02.mp3').writeAsBytes([0]);
    await File('${albumDir.path}${Platform.pathSeparator}03.mp3').writeAsBytes([0]);

    final provider = LocalMusicProvider(
      metadataReader: (filePath) async {
        if (filePath.endsWith('01.mp3')) {
          return const Tag(
            title: 'Wanna Be Startin Somethin',
            trackArtist: 'Michael Jackson',
            album: 'Thriller',
            pictures: [],
          );
        } else if (filePath.endsWith('02.mp3')) {
          return const Tag(
            title: 'The Girl Is Mine',
            trackArtist: 'Michael Jackson feat. Paul McCartney',
            album: 'Thriller',
            pictures: [],
          );
        } else {
          return const Tag(
            title: 'Beat It',
            trackArtist: 'Michael Jackson & Eddie Van Halen',
            album: 'Thriller',
            pictures: [],
          );
        }
      },
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [albumDir.path]
      },
    ));

    final albums = await provider.getAlbums();
    expect(albums.length, 1);
    expect(albums.single.title, 'Thriller');
    expect(albums.single.tracks.length, 3);
  });

  test('allows retry when automatic metadata match is missing artwork', () async {
    final metadataStore = _MemoryLocalSongMetadataStore();
    final provider = LocalMusicProvider(
      metadataReader: (_) async => const Tag(
        title: 'Song No Art',
        trackArtist: 'Artist',
        duration: 180000,
        pictures: [],
      ),
      metadataStore: metadataStore,
    );
    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [root.path]
      },
    ));
    final original = (await provider.getTracks()).single;

    // Simulate an automatic match that had no artwork
    final updated = await provider.applyAutomaticMetadata(
      original,
      const TrackMetadataCandidate(
        sourceId: 'itunes:123',
        title: 'Song No Art',
        artist: 'Artist',
        album: 'Album',
        artworkUri: null,
      ),
    );

    expect(updated.metadata['metadataSource'], 'automatic');
    expect(updated.artworkUri, isNull);

    // Immediately after match, cooldown is active (30s)
    expect(provider.shouldLookupMetadataAutomatically(updated), isFalse);

    // Once cooldown passes, missing artwork triggers retry
    final record = metadataStore.records[original.identity.sourceId]!;
    record['automaticLookupAt'] = DateTime.now()
        .toUtc()
        .subtract(const Duration(seconds: 35))
        .toIso8601String();
    await metadataStore.write(original.identity.sourceId, record);
    await provider.refresh();
    final reloaded = await provider.getTrack(original.identity.sourceId);
    expect(provider.shouldLookupMetadataAutomatically(reloaded!), isTrue);
  });

  test('does not pollute artwork across unrelated songs in the same download directory',
      () async {
    final downloadsDir = Directory('${root.path}${Platform.pathSeparator}Downloads');
    await downloadsDir.create(recursive: true);
    await File('${downloadsDir.path}${Platform.pathSeparator}8 AM.opus').writeAsBytes([0]);
    await File('${downloadsDir.path}${Platform.pathSeparator}1TRAGO.opus').writeAsBytes([0]);

    final provider = LocalMusicProvider(
      metadataReader: (filePath) async {
        if (filePath.contains('8 AM')) {
          return Tag(
            title: '8 AM',
            trackArtist: 'Nicki Nicole & Young Miko',
            pictures: [
              Picture(
                pictureType: PictureType.coverFront,
                mimeType: MimeType.png,
                bytes: Uint8List.fromList([8, 8, 8]),
              ),
            ],
          );
        } else {
          return const Tag(
            title: '1TRAGO',
            trackArtist: 'Danna',
            pictures: [],
          );
        }
      },
    );

    await provider.initialize(MusicProviderContext(
      profileId: 'local',
      settings: {
        'libraryRoots': [downloadsDir.path]
      },
    ));

    final tracks = await provider.getTracks();
    expect(tracks.length, 2);
    final song8am = tracks.firstWhere((t) => t.title == '8 AM');
    final song1trago = tracks.firstWhere((t) => t.title == '1TRAGO');

    expect(song8am.artworkUri, isNotNull);
    // 1TRAGO has no artwork and must NOT borrow 8 AM's artwork
    expect(song1trago.artworkUri, isNull);
  });
}

class _MemoryLocalSongMetadataStore implements LocalSongMetadataStore {
  final Map<String, Map<String, dynamic>> records = {};

  @override
  Future<void> initialize(String profileId) async {}

  @override
  Future<Map<String, dynamic>?> read(String sourceId) async =>
      records[sourceId] == null
          ? null
          : Map<String, dynamic>.from(records[sourceId]!);

  @override
  Future<void> write(
    String sourceId,
    Map<String, dynamic> metadata,
  ) async {
    records[sourceId] = Map<String, dynamic>.from(metadata);
  }
}
