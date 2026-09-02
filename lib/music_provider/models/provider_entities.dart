import 'package:flutter/foundation.dart';

import 'music_identity.dart';

@immutable
class ProviderTrack {
  const ProviderTrack({
    required this.identity,
    required this.title,
    this.artist = 'Unknown artist',
    this.album = 'Unknown album',
    this.duration,
    this.artworkUri,
    this.filePath,
    this.metadata = const {},
  });

  final MusicIdentity identity;
  final String title;
  final String artist;
  final String album;
  final Duration? duration;
  final Uri? artworkUri;
  final String? filePath;
  final Map<String, dynamic> metadata;

  ProviderTrack copyWith({
    MusicIdentity? identity,
    String? title,
    String? artist,
    String? album,
    Duration? duration,
    Uri? artworkUri,
    String? filePath,
    Map<String, dynamic>? metadata,
  }) =>
      ProviderTrack(
        identity: identity ?? this.identity,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        duration: duration ?? this.duration,
        artworkUri: artworkUri ?? this.artworkUri,
        filePath: filePath ?? this.filePath,
        metadata: metadata ?? this.metadata,
      );

  Map<String, dynamic> toJson() => {
        'providerId': identity.providerId,
        'profileId': identity.profileId,
        'sourceId': identity.sourceId,
        'videoId': identity.sourceId,
        'title': title,
        'artists': [
          {'name': artist}
        ],
        'album': {'name': album},
        'duration': duration?.inSeconds,
        'thumbnails': [
          {'url': artworkUri?.toString() ?? ''}
        ],
        'url': filePath,
        ...metadata,
      };
}

@immutable
class ProviderAlbum {
  const ProviderAlbum({
    required this.identity,
    required this.title,
    this.artist = 'Unknown artist',
    this.artworkUri,
    this.tracks = const [],
  });

  final MusicIdentity identity;
  final String title;
  final String artist;
  final Uri? artworkUri;
  final List<ProviderTrack> tracks;
}

@immutable
class ProviderArtist {
  const ProviderArtist({
    required this.identity,
    required this.name,
    this.artworkUri,
    this.tracks = const [],
    this.albums = const [],
  });

  final MusicIdentity identity;
  final String name;
  final Uri? artworkUri;
  final List<ProviderTrack> tracks;
  final List<ProviderAlbum> albums;
}

@immutable
class ProviderArtwork {
  const ProviderArtwork({this.uri, this.bytes, this.mimeType});

  final Uri? uri;
  final Uint8List? bytes;
  final String? mimeType;
}

@immutable
class ProviderLyrics {
  const ProviderLyrics({this.plain, this.synced});

  final String? plain;
  final String? synced;

  bool get isEmpty =>
      (plain == null || plain!.trim().isEmpty) &&
      (synced == null || synced!.trim().isEmpty);
}

@immutable
class ProviderSearchResults {
  const ProviderSearchResults({
    this.tracks = const [],
    this.albums = const [],
    this.artists = const [],
  });

  final List<ProviderTrack> tracks;
  final List<ProviderAlbum> albums;
  final List<ProviderArtist> artists;
}
