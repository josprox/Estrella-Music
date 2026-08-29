import 'package:harmonymusic/generated/l10n.dart';

extension StringL10n on String {
  String get t {
    final cleanKey = toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('&', 'and')
        .replaceAll('-', '_');
    switch (cleanKey) {
      case 'home':
        return S.current.home;
      case 'songs':
        return S.current.songs;
      case 'playlists':
        return S.current.playlists;
      case 'albums':
        return S.current.albums;
      case 'album':
        return S.current.album;
      case 'singles':
        return S.current.singles;
      case 'artists':
        return S.current.artists;
      case 'settings':
        return S.current.settings;
      case 'library':
        return S.current.library;
      case 'libsongs':
        return S.current.libSongs;
      case 'libplaylists':
        return S.current.libPlaylists;
      case 'libalbums':
        return S.current.libAlbums;
      case 'libartists':
        return S.current.libArtists;
      case 'communityplaylists':
        return S.current.communityplaylists;
      case 'featuredplaylists':
        return S.current.featuredplaylists;
      case 'quickpicks':
        return S.current.quickpicks;
      case 'discover':
        return S.current.discover;
      case 'trending':
        return S.current.trending;
      case 'topmusicvideos':
        return S.current.topmusicvideos;
      case 'recentlyplayed':
        return S.current.recentlyPlayed;
      case 'favorites':
        return S.current.favorites;
      case 'cachedoroffline':
        return S.current.cachedOrOffline;
      case 'downloads':
        return S.current.downloads;
      case 'viewall':
        return S.current.viewAll;
      case 'results':
        return S.current.results;
      case 'about':
        return S.current.about;
      case 'synced':
        return S.current.synced;
      case 'plain':
        return S.current.plain;
      case 'songinfo':
        return S.current.songInfo;
      case 'local':
        return S.current.local;
      case 'piped':
        return S.current.Piped;
      case 'link':
        return S.current.link;
      case 'unlink':
        return S.current.unLink;
      case 'customins':
        return S.current.customIns;
      case 'username':
        return S.current.username;
      case 'password':
        return S.current.password;
      case 'reset':
        return S.current.reset;
      case 'backup':
        return S.current.backup;
      case 'restore':
        return S.current.restore;
      case 'podcasts':
        return S.current.podcasts;
      case 'episodes':
        return S.current.episodes;
      case 'profiles':
        return S.current.profiles;
      case 'networkerror':
        return S.current.networkError;
      default:
        return this;
    }
  }
}
