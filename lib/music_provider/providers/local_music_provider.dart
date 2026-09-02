import 'dart:io';
import 'dart:typed_data';

import 'package:audiotags/audiotags.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:estrella_music/services/system/translation_service.dart';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_metadata_editor.dart';
import '../music_provider.dart';
import 'local_song_metadata_store.dart';

typedef AudioMetadataReader = Future<Tag?> Function(String filePath);

class LocalMusicProvider
    implements
        MusicProvider,
        MusicMetadataEditor,
        AutomaticMusicMetadataEditor {
  LocalMusicProvider({
    AudioMetadataReader? metadataReader,
    LocalSongMetadataStore? metadataStore,
    Dio? artworkClient,
  })  : _metadataReader = metadataReader ?? AudioTags.read,
        _metadataStore = metadataStore ?? HiveLocalSongMetadataStore(),
        _artworkClient = artworkClient ?? Dio();

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
  final LocalSongMetadataStore _metadataStore;
  final Dio _artworkClient;
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
    await _metadataStore.initialize(context.profileId);
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

    // Share album artwork across tracks in the same known album
    final albumArtworks = <String, Uri>{};
    for (final track in discovered) {
      if (track.artworkUri != null &&
          track.album != 'Unknown album' &&
          track.album.trim().isNotEmpty) {
        final key = _albumGroupKey(track);
        albumArtworks.putIfAbsent(key, () => track.artworkUri!);
      }
    }

    final enriched = discovered.map((track) {
      if (track.artworkUri == null &&
          track.album != 'Unknown album' &&
          track.album.trim().isNotEmpty) {
        final key = _albumGroupKey(track);
        final sharedArt = albumArtworks[key];
        if (sharedArt != null) {
          return track.copyWith(artworkUri: sharedArt);
        }
      }
      return track;
    }).toList();

    enriched
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _tracks = List.unmodifiable(enriched);
  }

  Future<ProviderTrack> _readTrack(File file) async {
    Tag? tag;
    try {
      tag = await _metadataReader(file.path);
    } catch (_) {
      tag = null;
    }
    final sourceId = _stableSourceId(file.path);
    final stored = await _metadataStore.read(sourceId);
    final storedSource = _recordString(stored, 'source');
    final hasStoredOverride =
        storedSource == 'manual' || storedSource == 'automatic';
    final filenameMetadata = LocalFilenameMetadata.parse(file.path);
    final embeddedTitle = _nonEmpty(tag?.title);
    final embeddedArtist = _nonEmpty(tag?.trackArtist);
    final useFilenameTitle = _shouldUseFilenameTitle(
      embeddedTitle,
      filenameMetadata,
      file.path,
    );
    final useFilenameArtist =
        _isUnknownArtist(embeddedArtist) && filenameMetadata.artist != null;
    final detectedTitle = useFilenameTitle
        ? filenameMetadata.title
        : embeddedTitle ?? filenameMetadata.title;
    final detectedArtist = useFilenameArtist
        ? filenameMetadata.artist!
        : embeddedArtist ?? 'Unknown artist';
    final detectedAlbum = _nonEmpty(tag?.album) ?? 'Unknown album';
    final title = hasStoredOverride
        ? _recordString(stored, 'title') ?? detectedTitle
        : detectedTitle;
    final artist = hasStoredOverride
        ? _recordString(stored, 'artist') ?? detectedArtist
        : detectedArtist;
    final album = hasStoredOverride
        ? _recordString(stored, 'album') ?? detectedAlbum
        : detectedAlbum;
    final year = hasStoredOverride ? _recordInt(stored, 'year') : tag?.year;
    final trackNumber = hasStoredOverride
        ? _recordInt(stored, 'trackNumber')
        : tag?.trackNumber;
    final genre = hasStoredOverride
        ? _recordString(stored, 'genre') ?? tag?.genre
        : tag?.genre;
    final artworkPath = '${path.withoutExtension(file.path)}.jpg';
    final pngArtworkPath = '${path.withoutExtension(file.path)}.png';
    Uri? artworkUri;

    final storedArtworkPath = _recordString(stored, 'artworkPath');
    if (hasStoredOverride && storedArtworkPath != null) {
      final storedArtwork = File(storedArtworkPath);
      if (await storedArtwork.exists()) artworkUri = storedArtwork.uri;
    }
    if (artworkUri == null) {
      if (tag != null && tag.pictures.isNotEmpty) {
        artworkUri = await _cacheArtwork(
          sourceId: sourceId,
          picture: tag.pictures.first,
          album: album,
          artist: artist,
        );
        artworkUri ??= Uri(
          scheme: 'data',
          path: 'audio-artwork/${Uri.encodeComponent(file.path)}',
        );
      } else if (await File(artworkPath).exists()) {
        artworkUri = File(artworkPath).uri;
      } else if (await File(pngArtworkPath).exists()) {
        artworkUri = File(pngArtworkPath).uri;
      } else {
        artworkUri = await _findDirectoryArtwork(file);
        artworkUri ??= await _findCachedAlbumArtwork(album, artist);
      }
    }

    if (!hasStoredOverride) {
      final detectedRecord = <String, dynamic>{
        'schemaVersion': 1,
        'source':
            useFilenameTitle || useFilenameArtist ? 'filename' : 'embedded',
        'filePath': file.path,
        'title': title,
        'artist': artist,
        'album': album,
        'albumArtist': tag?.albumArtist,
        'year': year,
        'trackNumber': trackNumber,
        'genre': genre,
        'artworkPath': _localArtworkPath(artworkUri),
        if (stored?['automaticLookupAt'] != null)
          'automaticLookupAt': stored!['automaticLookupAt'],
        if (stored?['automaticLookupStatus'] != null)
          'automaticLookupStatus': stored!['automaticLookupStatus'],
      };
      if (!_sameMetadataRecord(stored, detectedRecord)) {
        await _metadataStore.write(sourceId, detectedRecord);
      }
    }

    return ProviderTrack(
      identity: MusicIdentity(
        providerId: providerId,
        profileId: _requireProfileId,
        sourceId: sourceId,
      ),
      title: title,
      artist: artist,
      album: album,
      duration:
          tag?.duration == null ? null : Duration(milliseconds: tag!.duration!),
      artworkUri: artworkUri,
      filePath: file.path,
      metadata: {
        'filePath': file.path,
        'year': year,
        'trackNumber': trackNumber,
        'genre': genre,
        'metadataSource': hasStoredOverride
            ? storedSource
            : useFilenameTitle || useFilenameArtist
                ? 'filename'
                : 'embedded',
        'metadataStoredInHive': true,
        'automaticLookupAt': stored?['automaticLookupAt'],
        'automaticLookupStatus': stored?['automaticLookupStatus'],
        'needsMetadataReview': artist == 'Unknown artist' ||
            album == 'Unknown album' ||
            artworkUri == null ||
            year == null,
        'suggestedMetadataQuery': [
          if (!_isUnknownArtist(artist)) artist,
          title,
        ].join(' '),
      },
    );
  }

  bool _shouldUseFilenameTitle(
    String? embeddedTitle,
    LocalFilenameMetadata filenameMetadata,
    String filePath,
  ) {
    if (embeddedTitle != null &&
        _normalizedText(embeddedTitle) ==
            _normalizedText(filenameMetadata.title)) {
      return false;
    }
    if (_isLowQualityTitle(embeddedTitle)) return true;
    final rawFilename = path.basenameWithoutExtension(filePath);
    return filenameMetadata.title != rawFilename.trim() &&
        _normalizedText(embeddedTitle!) == _normalizedText(rawFilename);
  }

  bool _isLowQualityTitle(String? value) {
    final normalized = _normalizedText(value ?? '');
    if (normalized.isEmpty) return true;
    if (const {
      'track',
      'audio',
      'song',
      'untitled',
      'unknown track',
      'unknown song',
    }.contains(normalized)) {
      return true;
    }
    return RegExp(r'^(aud|ptt|audio|track)[\s_-]*\d+$').hasMatch(normalized) ||
        RegExp(r'^\d+$').hasMatch(normalized);
  }

  bool _isUnknownArtist(String? value) {
    final normalized = _normalizedText(value ?? '');
    return normalized.isEmpty ||
        const {
          'unknown',
          'unknown artist',
          '<unknown>',
          'artista desconocido',
        }.contains(normalized);
  }

  String _normalizedText(String value) => value
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9áéíóúüñ]+'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  String? _recordString(Map<String, dynamic>? record, String key) =>
      _nonEmpty(record?[key]?.toString());

  int? _recordInt(Map<String, dynamic>? record, String key) {
    final value = record?[key];
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  bool _sameMetadataRecord(
    Map<String, dynamic>? current,
    Map<String, dynamic> next,
  ) {
    if (current == null || current.length != next.length) return false;
    for (final entry in next.entries) {
      if (current[entry.key] != entry.value) return false;
    }
    return true;
  }

  String? _localArtworkPath(Uri? uri) {
    if (uri == null || !uri.isScheme('file')) return null;
    try {
      return uri.toFilePath();
    } catch (_) {
      return null;
    }
  }

  Future<Uri?> _cacheArtwork({
    required String sourceId,
    required Picture picture,
    required String album,
    required String artist,
    bool overwrite = false,
  }) async {
    try {
      final supportDir = (await getApplicationSupportDirectory()).path;
      if (supportDir.isEmpty) return null;
      final thumbDir = Directory('$supportDir/thumbnails');
      await thumbDir.create(recursive: true);
      final thumbFile = File('${thumbDir.path}/$sourceId.png');
      if (overwrite || !await thumbFile.exists()) {
        await thumbFile.writeAsBytes(picture.bytes, flush: true);
      }

      if (album != 'Unknown album' && album.trim().isNotEmpty) {
        final albumId = 'album-${_stableTextHash("$album\u0000$artist")}';
        final albumThumb = File('${thumbDir.path}/$albumId.png');
        if (overwrite || !await albumThumb.exists()) {
          await albumThumb.writeAsBytes(picture.bytes, flush: true);
        }
        final primaryArt = _primaryArtist(artist);
        if (primaryArt != artist && primaryArt != 'Unknown artist') {
          final primaryAlbumId =
              'album-${_stableTextHash("$album\u0000$primaryArt")}';
          final primaryAlbumThumb = File('${thumbDir.path}/$primaryAlbumId.png');
          if (overwrite || !await primaryAlbumThumb.exists()) {
            await primaryAlbumThumb.writeAsBytes(picture.bytes, flush: true);
          }
        }
      }
      if (artist != 'Unknown artist' && artist.trim().isNotEmpty) {
        final artistId = 'artist-${_stableTextHash(artist)}';
        final artistThumb = File('${thumbDir.path}/$artistId.png');
        if (overwrite || !await artistThumb.exists()) {
          await artistThumb.writeAsBytes(picture.bytes, flush: true);
        }
      }
      return thumbFile.uri;
    } catch (_) {
      return null;
    }
  }

  Future<Uri?> _findDirectoryArtwork(File file) async {
    try {
      final parentDir = file.parent;
      if (!await parentDir.exists()) return null;
      final normalizedParent =
          parentDir.path.replaceAll('\\', '/').toLowerCase();
      final isGenericDownloadOrRootDir =
          normalizedParent.endsWith('/download') ||
          normalizedParent.endsWith('/downloads') ||
          normalizedParent.endsWith('/storage/emulated/0') ||
          normalizedParent.endsWith('/telegram') ||
          normalizedParent.endsWith('/snaptube') ||
          normalizedParent == '/storage/emulated/0';
      if (isGenericDownloadOrRootDir) {
        return null;
      }
      const candidates = [
        'cover.jpg',
        'cover.png',
        'cover.jpeg',
        'folder.jpg',
        'folder.png',
        'folder.jpeg',
        'album.jpg',
        'album.png',
        'album.jpeg',
        'albumart.jpg',
        'albumart.png',
        'front.jpg',
        'front.png',
        'front.jpeg',
        'artwork.jpg',
        'artwork.png',
      ];
      for (final name in candidates) {
        final candidate = File(path.join(parentDir.path, name));
        if (await candidate.exists()) {
          return candidate.uri;
        }
      }
    } catch (_) {}
    return null;
  }

  Future<Uri?> _findCachedAlbumArtwork(String album, String artist) async {
    if (album == 'Unknown album' || album.trim().isEmpty) return null;
    try {
      final supportDir = (await getApplicationSupportDirectory()).path;
      if (supportDir.isEmpty) return null;
      final thumbDir = Directory('$supportDir/thumbnails');
      if (!await thumbDir.exists()) return null;

      final primaryArt = _primaryArtist(artist);
      final primaryAlbumId =
          'album-${_stableTextHash("$album\u0000$primaryArt")}';
      final primaryThumb = File('${thumbDir.path}/$primaryAlbumId.png');
      if (await primaryThumb.exists()) return primaryThumb.uri;

      final albumId = 'album-${_stableTextHash("$album\u0000$artist")}';
      final albumThumb = File('${thumbDir.path}/$albumId.png');
      if (await albumThumb.exists()) return albumThumb.uri;
    } catch (_) {}
    return null;
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

  String _albumGroupKey(ProviderTrack track) {
    final rawAlbum = track.album.trim();
    final normalizedAlbum = _normalizedText(rawAlbum);
    if (normalizedAlbum.isEmpty || normalizedAlbum == 'unknown album') {
      return 'track:${track.identity.sourceId}';
    }

    final rawArtist = track.artist.trim();
    final explicitAlbumArtist =
        _nonEmpty(track.metadata['albumArtist']?.toString());
    final effectiveArtist = explicitAlbumArtist ?? _primaryArtist(rawArtist);
    final normalizedArtist = _normalizedText(effectiveArtist);

    return 'album:$normalizedAlbum|artist:$normalizedArtist';
  }

  String _primaryArtist(String artist) {
    if (_isUnknownArtist(artist)) return 'Unknown artist';
    final match = RegExp(
      r'^(.*?)(?:\s+(?:feat\.?|ft\.?|featuring|with|&|\/|,)\s+.*)$',
      caseSensitive: false,
    ).firstMatch(artist.trim());
    if (match != null && match.group(1)!.trim().isNotEmpty) {
      return match.group(1)!.trim();
    }
    return artist.trim();
  }

  @override
  Future<List<ProviderAlbum>> getAlbums() async {
    final grouped = <String, List<ProviderTrack>>{};
    for (final track in _tracks) {
      grouped.putIfAbsent(_albumGroupKey(track), () => []).add(track);
    }
    return grouped.entries.map((entry) {
      final tracks = entry.value;
      final firstWithAlbum = tracks.firstWhere(
        (t) => t.album != 'Unknown album',
        orElse: () => tracks.first,
      );
      final title = firstWithAlbum.album;

      final explicitAlbumArtist = tracks
          .map((t) => _nonEmpty(t.metadata['albumArtist']?.toString()))
          .firstWhere((a) => a != null, orElse: () => null);

      final artist = explicitAlbumArtist ??
          (tracks.every((t) =>
                  _normalizedText(t.artist) ==
                  _normalizedText(tracks.first.artist))
              ? tracks.first.artist
              : _primaryArtist(firstWithAlbum.artist));

      final artworkUri = tracks
          .map((t) => t.artworkUri)
          .firstWhere((uri) => uri != null, orElse: () => null);

      return ProviderAlbum(
        identity: MusicIdentity(
          providerId: providerId,
          profileId: _requireProfileId,
          sourceId: 'album-${_stableTextHash(entry.key)}',
        ),
        title: title,
        artist: artist,
        artworkUri: artworkUri,
        tracks: List.unmodifiable(tracks),
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
  String suggestedMetadataQuery(ProviderTrack track) {
    final saved = track.metadata['suggestedMetadataQuery']?.toString().trim();
    if (saved != null && saved.isNotEmpty) return saved;
    final filePath = track.filePath;
    if (filePath != null && filePath.isNotEmpty) {
      final inferred = LocalFilenameMetadata.parse(filePath);
      return [
        if (inferred.artist != null) inferred.artist,
        inferred.title,
      ].join(' ');
    }
    return [
      if (!_isUnknownArtist(track.artist)) track.artist,
      track.title,
    ].join(' ');
  }

  @override
  Future<ProviderTrack> applyMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  ) =>
      _applyMetadata(track, candidate, source: 'manual');

  @override
  Future<ProviderTrack> applyAutomaticMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  ) =>
      _applyMetadata(track, candidate, source: 'automatic');

  Future<ProviderTrack> _applyMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate, {
    required String source,
  }) async {
    if (track.identity.providerId != providerId ||
        track.identity.profileId != _requireProfileId) {
      throw const MusicProviderException(
        'The selected track does not belong to the active local profile',
      );
    }
    final filePath = track.filePath;
    if (filePath == null || !await File(filePath).exists()) {
      throw MusicProviderException('Local file is unavailable: ${track.title}');
    }

    Tag? embedded;
    try {
      embedded = await _metadataReader(filePath);
    } catch (_) {}

    final current = await _metadataStore.read(track.identity.sourceId);
    final title = _nonEmpty(candidate.title) ?? track.title;
    final artist = _candidateValue(candidate.artist, 'Unknown artist') ??
        _recordString(current, 'artist') ??
        _nonEmpty(embedded?.trackArtist) ??
        _candidateValue(track.artist, 'Unknown artist') ??
        'Unknown artist';
    final album = _candidateValue(candidate.album, 'Unknown album') ??
        _recordString(current, 'album') ??
        _nonEmpty(embedded?.album) ??
        _candidateValue(track.album, 'Unknown album') ??
        'Unknown album';
    var downloadedPicture = await _downloadArtwork(candidate.artworkUri);
    downloadedPicture ??= await _searchAndDownloadFallbackArtwork(
      artist: artist,
      album: album,
      title: title,
    );
    var artworkPath = _recordString(current, 'artworkPath') ??
        _localArtworkPath(track.artworkUri);
    if (downloadedPicture != null) {
      final cached = await _cacheArtwork(
        sourceId: track.identity.sourceId,
        picture: downloadedPicture,
        album: album,
        artist: artist,
        overwrite: true,
      );
      artworkPath = _localArtworkPath(cached) ?? artworkPath;
    }

    await _metadataStore.write(track.identity.sourceId, <String, dynamic>{
      'schemaVersion': 1,
      'source': source,
      'filePath': filePath,
      'title': title,
      'artist': artist,
      'album': album,
      'albumArtist': _nonEmpty(candidate.albumArtist) ??
          _candidateValue(candidate.artist, 'Unknown artist') ??
          _recordString(current, 'albumArtist') ??
          embedded?.albumArtist,
      'year': candidate.year ?? _recordInt(current, 'year') ?? embedded?.year,
      'trackNumber': candidate.trackNumber ??
          _recordInt(current, 'trackNumber') ??
          embedded?.trackNumber,
      'genre': _nonEmpty(candidate.genre) ??
          _recordString(current, 'genre') ??
          embedded?.genre,
      'artworkPath': artworkPath,
      'matchedSourceId': candidate.sourceId,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
      if (source == 'automatic')
        'automaticLookupAt': DateTime.now().toUtc().toIso8601String(),
      if (source == 'automatic') 'automaticLookupStatus': 'matched',
    });

    final refreshed = await _readTrack(File(filePath));
    _replaceTrackInMemory(refreshed);
    return refreshed;
  }

  void _replaceTrackInMemory(ProviderTrack refreshed) {
    final values = _tracks.toList();
    final index = values.indexWhere(
      (item) => item.identity.sourceId == refreshed.identity.sourceId,
    );
    if (index == -1) {
      values.add(refreshed);
    } else {
      values[index] = refreshed;
    }

    // Share artwork with sibling tracks from the same known album if they lack artwork
    if (refreshed.artworkUri != null &&
        refreshed.album != 'Unknown album' &&
        refreshed.album.trim().isNotEmpty) {
      final key = _albumGroupKey(refreshed);
      for (var i = 0; i < values.length; i++) {
        if (values[i].artworkUri == null &&
            values[i].album != 'Unknown album' &&
            _albumGroupKey(values[i]) == key) {
          values[i] = values[i].copyWith(artworkUri: refreshed.artworkUri);
        }
      }
    }

    values
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _tracks = List.unmodifiable(values);
  }

  @override
  bool shouldLookupMetadataAutomatically(ProviderTrack track) {
    final source = track.metadata['metadataSource']?.toString();
    if (source == 'manual') return false;

    final hasNoArtwork = track.artworkUri == null;
    final needsReview =
        track.metadata['needsMetadataReview'] == true || hasNoArtwork;
    if (!needsReview) return false;
    if (source == 'automatic' && !hasNoArtwork) return false;

    final attemptedAt = DateTime.tryParse(
      track.metadata['automaticLookupAt']?.toString() ?? '',
    );
    if (attemptedAt == null) return true;
    final status = track.metadata['automaticLookupStatus']?.toString();
    final retryAfter = status == 'no_match'
        ? const Duration(minutes: 5)
        : const Duration(seconds: 30);
    return DateTime.now().toUtc().difference(attemptedAt.toUtc()) >= retryAfter;
  }

  Future<Picture?> _searchAndDownloadFallbackArtwork({
    required String artist,
    required String album,
    required String title,
  }) async {
    try {
      final terms = <String>[
        if (!_isUnknownArtist(artist) && album != 'Unknown album')
          '$artist $album',
        if (!_isUnknownArtist(artist)) '$artist $title',
        title,
      ];
      for (final term in terms) {
        final query = term.trim();
        if (query.isEmpty) continue;
        final response = await _artworkClient.get<dynamic>(
          'https://itunes.apple.com/search',
          queryParameters: {
            'term': query,
            'entity': 'song',
            'limit': 1,
          },
          options: Options(
            headers: const {
              'Accept': 'application/json',
              'User-Agent': 'EstrellaMusic/2.4.0',
            },
            sendTimeout: const Duration(seconds: 6),
            receiveTimeout: const Duration(seconds: 6),
          ),
        );
        final data = response.data;
        if (data is Map &&
            data['results'] is List &&
            (data['results'] as List).isNotEmpty) {
          final first = data['results'][0];
          final rawArt = first['artworkUrl100']?.toString() ??
              first['artworkUrl60']?.toString();
          if (rawArt != null && rawArt.isNotEmpty) {
            final highRes = rawArt
                .replaceAll('100x100bb.jpg', '600x600bb.jpg')
                .replaceAll('100x100bb.png', '600x600bb.png')
                .replaceAll('100x100', '600x600');
            final pic = await _downloadArtwork(Uri.tryParse(highRes));
            if (pic != null) return pic;
          }
        }
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<void> recordAutomaticMetadataLookup(
    ProviderTrack track,
    AutomaticMetadataLookupOutcome outcome,
  ) async {
    final current = await _metadataStore.read(track.identity.sourceId) ??
        <String, dynamic>{
          'schemaVersion': 1,
          'source': track.metadata['metadataSource'] ?? 'filename',
          'filePath': track.filePath,
          'title': track.title,
          'artist': track.artist,
          'album': track.album,
          'year': track.metadata['year'],
          'trackNumber': track.metadata['trackNumber'],
          'genre': track.metadata['genre'],
          'artworkPath': _localArtworkPath(track.artworkUri),
        };
    await _metadataStore.write(track.identity.sourceId, <String, dynamic>{
      ...current,
      'automaticLookupAt': DateTime.now().toUtc().toIso8601String(),
      'automaticLookupStatus': switch (outcome) {
        AutomaticMetadataLookupOutcome.noMatch => 'no_match',
        AutomaticMetadataLookupOutcome.error => 'error',
      },
    });
    final filePath = track.filePath;
    if (filePath != null && await File(filePath).exists()) {
      _replaceTrackInMemory(await _readTrack(File(filePath)));
    }
  }

  String? _candidateValue(String value, String placeholder) {
    final normalized = _nonEmpty(value);
    if (normalized == null ||
        _normalizedText(normalized) == _normalizedText(placeholder)) {
      return null;
    }
    return normalized;
  }

  Future<Picture?> _downloadArtwork(Uri? uri) async {
    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
      return null;
    }
    try {
      final response = await _artworkClient.get<List<int>>(
        uri.toString(),
        options: Options(responseType: ResponseType.bytes),
      );
      final data = response.data;
      if (data == null || data.isEmpty || data.length > 8 * 1024 * 1024) {
        return null;
      }
      final bytes = Uint8List.fromList(data);
      return Picture(
        pictureType: PictureType.coverFront,
        mimeType: _pictureMimeType(
          response.headers.value(Headers.contentTypeHeader),
          bytes,
        ),
        bytes: bytes,
      );
    } catch (_) {
      // The textual tags are still valuable when artwork is unavailable.
      return null;
    }
  }

  MimeType? _pictureMimeType(String? contentType, Uint8List bytes) {
    final type = contentType?.toLowerCase() ?? '';
    if (type.contains('png')) return MimeType.png;
    if (type.contains('jpeg') || type.contains('jpg')) return MimeType.jpeg;
    if (type.contains('gif')) return MimeType.gif;
    if (type.contains('bmp')) return MimeType.bmp;
    if (type.contains('tiff')) return MimeType.tiff;
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4e &&
        bytes[3] == 0x47) {
      return MimeType.png;
    }
    if (bytes.length >= 3 && bytes[0] == 0xff && bytes[1] == 0xd8) {
      return MimeType.jpeg;
    }
    return null;
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

class LocalFilenameMetadata {
  const LocalFilenameMetadata({required this.title, this.artist});

  final String title;
  final String? artist;

  static LocalFilenameMetadata parse(String filePath) {
    var value = path.basenameWithoutExtension(filePath).trim();
    value = value.replaceAll(RegExp(r'[_]+'), ' ');
    value = value.replaceFirst(
      RegExp(r'^\s*\d{1,3}\s*(?:[.\-–—)]\s*)+'),
      '',
    );
    value = _stripTechnicalSuffixes(value);
    value = value.replaceAll(RegExp(r'\s+'), ' ').trim();

    final parts = value
        .split(RegExp(r'\s+[-–—]\s+'))
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts.length >= 2) {
      return LocalFilenameMetadata(
        artist: parts.first,
        title: parts.skip(1).join(' - '),
      );
    }
    final parentheticalArtist =
        RegExp(r'^(.+?)\s+\(([^()]+)\)$').firstMatch(value);
    if (parentheticalArtist != null) {
      final title = parentheticalArtist.group(1)!.trim();
      final artist = parentheticalArtist.group(2)!.trim();
      if (title.isNotEmpty && !_looksLikeVersion(artist)) {
        return LocalFilenameMetadata(title: title, artist: artist);
      }
    }
    return LocalFilenameMetadata(
      title: value.isEmpty ? path.basenameWithoutExtension(filePath) : value,
    );
  }

  static bool _looksLikeVersion(String value) {
    final normalized = value.toLowerCase().trim();
    return RegExp(
          r'\b(?:live|remix|mix|version|edit|acoustic|instrumental|karaoke|remaster(?:ed)?|demo|radio|mono|stereo|sped\s*up|slowed|feat\.?|ft\.?)\b',
        ).hasMatch(normalized) ||
        RegExp(r'^\d{4}$').hasMatch(normalized);
  }

  static String _stripTechnicalSuffixes(String value) {
    const technical =
        r'(?:official\s*(?:music\s*)?(?:audio|video)|lyrics?|lyric\s*video|audio|video|visuali[sz]er|hq|hd|4k|320\s*kbps|128\s*kbps)';
    var result = value;
    String previous;
    do {
      previous = result;
      result = result
          .replaceFirst(
            RegExp('\\s*[\\[(]\\s*$technical\\s*[\\])]\\s*\$',
                caseSensitive: false),
            '',
          )
          .replaceFirst(
            RegExp('\\s*[-–—]\\s*$technical\\s*\$', caseSensitive: false),
            '',
          )
          .trim();
    } while (result != previous);
    return result;
  }
}
