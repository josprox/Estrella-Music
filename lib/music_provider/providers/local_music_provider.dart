import 'dart:io';
import 'dart:typed_data';

import 'package:audiotags/audiotags.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:estrella_music/services/system/translation_service.dart';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_provider.dart';

typedef AudioMetadataReader = Future<Tag?> Function(String filePath);

class LocalMusicProvider implements MusicProvider {
  LocalMusicProvider({AudioMetadataReader? metadataReader})
      : _metadataReader = metadataReader ?? AudioTags.read;

  static const providerId = 'estrella.local';
  static const _extensions = {
    '.mp3',
    '.m4a',
    '.aac',
    '.flac',
    '.ogg',
    '.opus',
    '.wav',
    '.webm',
  };

  final AudioMetadataReader _metadataReader;
  String? _profileId;
  List<String> _roots = const [];
  List<ProviderTrack> _tracks = const [];

  @override
  String get id => providerId;

  @override
  String get displayName => 'Local';

  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(
        search: true,
        playback: true,
        tracks: true,
        artists: true,
        albums: true,
        artwork: true,
        lyrics: true,
        playlists: true,
        favorites: true,
        history: true,
        recognition: false,
      );

  @override
  Future<void> initialize(MusicProviderContext context) async {
    _profileId = context.profileId;
    final configuredRoots = context.settings['libraryRoots'];
    if (configuredRoots is List && configuredRoots.isNotEmpty) {
      _roots = configuredRoots
          .map((value) => value.toString())
          .where((value) => value.trim().isNotEmpty)
          .toList(growable: false);
    } else {
      _roots = await defaultLibraryRoots();
    }
    await refresh();
  }

  static Future<List<String>> defaultLibraryRoots() async {
    final candidateDirs = <String>{};

    if (Platform.isAndroid) {
      final standardPaths = [
        '/storage/emulated/0/Music',
        '/storage/emulated/0/Download',
        '/storage/emulated/0/Downloads',
        '/storage/emulated/0/Audiobooks',
        '/storage/emulated/0/Podcasts',
        '/storage/emulated/0/Media',
        '/storage/emulated/0/Snaptube/download/Audio',
        '/storage/emulated/0/Snaptube/download/Snaptube Audio',
        '/storage/emulated/0/SnapTube/Audio',
        '/storage/emulated/0/Songily',
        '/storage/emulated/0/Telegram',
        '/storage/emulated/0',
      ];
      for (final p in standardPaths) {
        if (Directory(p).existsSync()) {
          candidateDirs.add(p);
        }
      }
      if (candidateDirs.isEmpty) {
        candidateDirs.add('/storage/emulated/0');
      }
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final home =
          Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
      if (home != null && home.isNotEmpty) {
        final musicDir = path.join(home, 'Music');
        final downloadsDir = path.join(home, 'Downloads');
        if (Directory(musicDir).existsSync()) candidateDirs.add(musicDir);
        if (Directory(downloadsDir).existsSync()) {
          candidateDirs.add(downloadsDir);
        }
      }
    }

    return candidateDirs.toList(growable: false);
  }

  static bool isIgnoredPath(String filePath) {
    final normalized = filePath.replaceAll('\\', '/').toLowerCase();
    final ignoredSegments = [
      '/whatsapp/',
      'whatsapp audio',
      'whatsapp voice notes',
      'whatsapp animated gifs',
      'whatsapp video',
      'whatsapp media',
      '/com.whatsapp/',
      '/com.whatsapp.w4b/',
      '/telegram/telegram audio/',
      '/telegram/telegram voice/',
      '/.thumbnails/',
      '/android/data/',
      '/android/obb/',
      '/recordings/call_rec',
      '/voicerecorder/',
      '/.trashed',
    ];

    for (final segment in ignoredSegments) {
      if (normalized.contains(segment)) {
        return true;
      }
    }

    final filename = path.basename(normalized);
    if (filename.startsWith('.') ||
        filename.startsWith('ptt-') ||
        filename.startsWith('aud-')) {
      if (normalized.contains('whatsapp')) return true;
    }

    return false;
  }

  @override
  Future<void> refresh() async {
    final discovered = <ProviderTrack>[];
    for (final rootPath in _roots) {
      final root = Directory(rootPath);
      if (!await root.exists()) continue;
      try {
        await for (final entity
            in root.list(recursive: true, followLinks: false)) {
          if (entity is! File ||
              !_extensions
                  .contains(path.extension(entity.path).toLowerCase())) {
            continue;
          }
          if (isIgnoredPath(entity.path)) {
            continue;
          }
          discovered.add(await _readTrack(entity));
        }
      } catch (_) {}
    }
    discovered
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _tracks = List.unmodifiable(discovered);
  }

  Future<ProviderTrack> _readTrack(File file) async {
    Tag? tag;
    try {
      tag = await _metadataReader(file.path);
    } catch (_) {
      tag = null;
    }
    final title =
        _nonEmpty(tag?.title) ?? path.basenameWithoutExtension(file.path);
    final sourceId = _stableSourceId(file.path);
    final artworkPath = '${path.withoutExtension(file.path)}.jpg';
    final pngArtworkPath = '${path.withoutExtension(file.path)}.png';
    Uri? artworkUri;

    // Check embedded pictures and cache thumbnail locally for offline/instant display
    if (tag != null && tag.pictures.isNotEmpty) {
      try {
        final supportDir = (await getApplicationSupportDirectory()).path;
        if (supportDir.isNotEmpty) {
          final thumbDir = Directory('$supportDir/thumbnails');
          if (!thumbDir.existsSync()) {
            thumbDir.createSync(recursive: true);
          }
          final thumbFile = File('$supportDir/thumbnails/$sourceId.png');
          if (!thumbFile.existsSync()) {
            await thumbFile.writeAsBytes(tag.pictures.first.bytes);
          }
          artworkUri = thumbFile.uri;

          // Also cache album and artist thumbnails if available
          final albumName = _nonEmpty(tag.album);
          if (albumName != null) {
            final albumId =
                'album-${_stableTextHash("$albumName\u0000${_nonEmpty(tag.trackArtist) ?? 'Unknown artist'}")}';
            final albumThumb = File('$supportDir/thumbnails/$albumId.png');
            if (!albumThumb.existsSync()) {
              await albumThumb.writeAsBytes(tag.pictures.first.bytes);
            }
          }
          final artistName = _nonEmpty(tag.trackArtist);
          if (artistName != null) {
            final artistId = 'artist-${_stableTextHash(artistName)}';
            final artistThumb = File('$supportDir/thumbnails/$artistId.png');
            if (!artistThumb.existsSync()) {
              await artistThumb.writeAsBytes(tag.pictures.first.bytes);
            }
          }
        }
      } catch (_) {}

      artworkUri ??= Uri(
        scheme: 'data',
        path: 'audio-artwork/${Uri.encodeComponent(file.path)}',
      );
    } else if (await File(artworkPath).exists()) {
      artworkUri = File(artworkPath).uri;
    } else if (await File(pngArtworkPath).exists()) {
      artworkUri = File(pngArtworkPath).uri;
    }

    return ProviderTrack(
      identity: MusicIdentity(
        providerId: providerId,
        profileId: _requireProfileId,
        sourceId: sourceId,
      ),
      title: title,
      artist: _nonEmpty(tag?.trackArtist) ?? 'Unknown artist',
      album: _nonEmpty(tag?.album) ?? 'Unknown album',
      duration:
          tag?.duration == null ? null : Duration(milliseconds: tag!.duration!),
      artworkUri: artworkUri,
      filePath: file.path,
      metadata: {
        'filePath': file.path,
        'year': tag?.year,
        'trackNumber': tag?.trackNumber,
        'genre': tag?.genre,
      },
    );
  }

  String get _requireProfileId {
    final value = _profileId;
    if (value == null) {
      throw const MusicProviderException('Local provider is not initialized');
    }
    return value;
  }

  String _stableSourceId(String filePath) {
    final normalized =
        path.normalize(File(filePath).absolute.path).toLowerCase();
    var hash = 0x811c9dc5;
    for (final codeUnit in normalized.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return 'file-$hash';
  }

  String? _nonEmpty(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  @override
  Future<List<ProviderTrack>> getTracks() async => _tracks;

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async {
    for (final track in _tracks) {
      if (track.identity.sourceId == sourceId) return track;
    }
    return null;
  }

  @override
  Future<ProviderSearchResults> search(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return const ProviderSearchResults();
    bool matches(String value) => value.toLowerCase().contains(normalized);
    final tracks = _tracks
        .where((track) =>
            matches(track.title) ||
            matches(track.artist) ||
            matches(track.album))
        .toList(growable: false);
    return ProviderSearchResults(
      tracks: tracks,
      albums: (await getAlbums())
          .where((album) => matches(album.title) || matches(album.artist))
          .toList(growable: false),
      artists: (await getArtists())
          .where((artist) => matches(artist.name))
          .toList(growable: false),
    );
  }

  @override
  Future<List<ProviderAlbum>> getAlbums() async {
    final grouped = <String, List<ProviderTrack>>{};
    for (final track in _tracks) {
      grouped
          .putIfAbsent('${track.album}\u0000${track.artist}', () => [])
          .add(track);
    }
    return grouped.entries.map((entry) {
      final parts = entry.key.split('\u0000');
      final first = entry.value.first;
      return ProviderAlbum(
        identity: MusicIdentity(
          providerId: providerId,
          profileId: _requireProfileId,
          sourceId: 'album-${_stableTextHash(entry.key)}',
        ),
        title: parts.first,
        artist: parts.last,
        artworkUri: first.artworkUri,
        tracks: List.unmodifiable(entry.value),
      );
    }).toList(growable: false);
  }

  @override
  Future<ProviderAlbum?> getAlbum(String sourceId) async {
    for (final album in await getAlbums()) {
      if (album.identity.sourceId == sourceId) return album;
    }
    return null;
  }

  @override
  Future<List<ProviderArtist>> getArtists() async {
    final grouped = <String, List<ProviderTrack>>{};
    for (final track in _tracks) {
      grouped.putIfAbsent(track.artist, () => []).add(track);
    }
    final albums = await getAlbums();
    return grouped.entries
        .map((entry) => ProviderArtist(
              identity: MusicIdentity(
                providerId: providerId,
                profileId: _requireProfileId,
                sourceId: 'artist-${_stableTextHash(entry.key)}',
              ),
              name: entry.key,
              artworkUri: entry.value.first.artworkUri,
              tracks: List.unmodifiable(entry.value),
              albums: albums
                  .where((album) => album.artist == entry.key)
                  .toList(growable: false),
            ))
        .toList(growable: false);
  }

  @override
  Future<ProviderArtist?> getArtist(String sourceId) async {
    for (final artist in await getArtists()) {
      if (artist.identity.sourceId == sourceId) return artist;
    }
    return null;
  }

  int _stableTextHash(String value) {
    var hash = 0x811c9dc5;
    for (final codeUnit in value.toLowerCase().codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return hash;
  }

  @override
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity) async {
    final track = await getTrack(identity.sourceId);
    if (track == null) return null;
    final embedded = await _embeddedArtwork(track.filePath!);
    if (embedded != null) return ProviderArtwork(bytes: embedded);
    return track.artworkUri == null
        ? null
        : ProviderArtwork(uri: track.artworkUri);
  }

  Future<Uint8List?> _embeddedArtwork(String filePath) async {
    try {
      final tag = await _metadataReader(filePath);
      return tag == null || tag.pictures.isEmpty
          ? null
          : tag.pictures.first.bytes;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ProviderLyrics?> getLyrics(ProviderTrack track) async {
    final filePath = track.filePath;
    if (filePath == null) return null;

    // 1. Check for external .lrc or .txt sidecar files next to the track
    for (final extension in const ['.lrc', '.txt']) {
      final lyricsFile = File('${path.withoutExtension(filePath)}$extension');
      if (!await lyricsFile.exists()) continue;
      final contents = await lyricsFile.readAsString();
      return extension == '.lrc'
          ? ProviderLyrics(synced: contents)
          : ProviderLyrics(plain: contents);
    }

    // 2. Check for matching lyric file in standard lyrics folder
    try {
      final baseName = path.basenameWithoutExtension(filePath);
      final parentDir = File(filePath).parent.path;
      for (final candidate in [
        '$parentDir/$baseName.lrc',
        '$parentDir/$baseName.txt',
        '$parentDir/lyrics/$baseName.lrc',
        '$parentDir/Lyrics/$baseName.lrc',
      ]) {
        final f = File(candidate);
        if (await f.exists()) {
          final contents = await f.readAsString();
          return candidate.endsWith('.lrc')
              ? ProviderLyrics(synced: contents)
              : ProviderLyrics(plain: contents);
        }
      }
    } catch (_) {}

    // 3. Shared online lookup. It is intentionally provider-neutral so the
    // same result is available from local and cloud profiles.
    final onlineLyrics = await TranslationService.fetchOnlineLyrics(
      title: track.title,
      artist: track.artist == 'Unknown artist' ? '' : track.artist,
      album: track.album == 'Unknown album' ? null : track.album,
      duration: track.duration,
    );
    if (onlineLyrics != null) {
      return ProviderLyrics(
        synced: onlineLyrics['synced'],
        plain: onlineLyrics['plain'],
      );
    }

    return null;
  }

  @override
  Future<PlaybackSource> getPlayback(ProviderTrack track) async {
    final filePath = track.filePath;
    if (filePath == null || !await File(filePath).exists()) {
      throw MusicProviderException('Local file is unavailable: ${track.title}');
    }
    return PlaybackSource(
      type: PlaybackSourceType.localFile,
      uri: File(filePath).uri,
    );
  }

  @override
  Future<void> dispose() async {
    _tracks = const [];
    _roots = const [];
    _profileId = null;
  }
}
