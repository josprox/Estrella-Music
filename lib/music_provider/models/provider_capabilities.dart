import 'package:flutter/foundation.dart';

@immutable
class ProviderCapabilities {
  const ProviderCapabilities({
    this.search = false,
    this.playback = false,
    this.tracks = false,
    this.artists = false,
    this.albums = false,
    this.artwork = false,
    this.lyrics = false,
    this.playlists = false,
    this.favorites = false,
    this.history = false,
    this.sync = false,
    this.home = false,
    this.recognition = false,
  });

  final bool search;
  final bool playback;
  final bool tracks;
  final bool artists;
  final bool albums;
  final bool artwork;
  final bool lyrics;
  final bool playlists;
  final bool favorites;
  final bool history;
  final bool sync;
  final bool home;
  final bool recognition;

  Map<String, dynamic> toJson() => {
        'search': search,
        'playback': playback,
        'tracks': tracks,
        'artists': artists,
        'albums': albums,
        'artwork': artwork,
        'lyrics': lyrics,
        'playlists': playlists,
        'favorites': favorites,
        'history': history,
        'sync': sync,
        'home': home,
        'recognition': recognition,
      };

  factory ProviderCapabilities.fromJson(Map<String, dynamic> json) {
    bool value(String key) => json[key] == true;
    return ProviderCapabilities(
      search: value('search'),
      playback: value('playback'),
      tracks: value('tracks'),
      artists: value('artists'),
      albums: value('albums'),
      artwork: value('artwork'),
      lyrics: value('lyrics'),
      playlists: value('playlists'),
      favorites: value('favorites'),
      history: value('history'),
      sync: value('sync'),
      home: value('home'),
      recognition: value('recognition'),
    );
  }
}
