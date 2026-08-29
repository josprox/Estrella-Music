import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/artist.dart';
import 'package:estrella_music/music_provider/models/music_identity.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/models/provider_capabilities.dart';
import 'package:estrella_music/music_provider/models/provider_entities.dart';
import 'package:estrella_music/profiles/profile_manager.dart';

import 'music_provider.dart';
import 'music_download_provider.dart';
import 'music_discovery_provider.dart';
import 'music_provider_manager.dart';

/// Provider-neutral application facade used by controllers and playback.
class MusicCatalogService extends GetxService {
  MusicCatalogService({
    required MusicProviderManager providerManager,
    required ProfileManager profileManager,
  })  : _providerManager = providerManager,
        _profileManager = profileManager;

  final MusicProviderManager _providerManager;
  final ProfileManager _profileManager;

  MusicProvider get provider {
    final profile = _profileManager.activeProfile.value;
    if (profile == null) {
      throw const MusicProviderException('No active music profile');
    }
    final instance = _providerManager.instanceForProfile(profile.id);
    if (instance == null) {
      throw const MusicProviderException('Active provider is unavailable');
    }
    return instance.provider;
  }

  ProviderCapabilities get capabilities => provider.capabilities;
  MusicDiscoveryProvider? get _discoveryProvider {
    final active = provider;
    return active is MusicDiscoveryProvider
        ? active as MusicDiscoveryProvider
        : null;
  }

  String get activeProviderId => provider.id;
  String get activeProfileId => _profileManager.activeProfile.value!.id;

  Future<void> init() async {}

  Future<List<ProviderTrack>> tracks() => provider.getTracks();
  Future<List<ProviderAlbum>> albums() => provider.getAlbums();
  Future<List<ProviderArtist>> artists() => provider.getArtists();
  Future<ProviderSearchResults> searchTyped(String query) =>
      provider.search(query);

  MediaItem mediaItemFromTrack(ProviderTrack track) => MediaItem(
        id: track.identity.sourceId,
        title: track.title,
        artist: track.artist,
        album: track.album,
        duration: track.duration,
        artUri: track.artworkUri?.scheme == 'data' ? null : track.artworkUri,
        extras: {
          'providerId': track.identity.providerId,
          'profileId': track.identity.profileId,
          'sourceId': track.identity.sourceId,
          'url': track.filePath,
          'album': {'name': track.album},
          'artists': [
            {'name': track.artist}
          ],
          'length':
              track.duration == null ? null : _durationLabel(track.duration!),
          ...track.metadata,
        },
      );

  Future<PlaybackSource> resolvePlayback(MediaItem item) async {
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final track = ProviderTrack(
      identity: identity,
      title: item.title,
      artist: item.artist ?? 'Unknown artist',
      album: item.album ?? 'Unknown album',
      duration: item.duration,
      artworkUri: item.artUri,
      filePath: item.extras?['url']?.toString(),
      metadata: item.extras ?? const {},
    );
    return provider.getPlayback(track);
  }

  Future<PlaybackSource> resolveDownload(
    MediaItem item, {
    required String format,
  }) async {
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final activeProvider = provider;
    if (activeProvider is! MusicDownloadProvider) {
      throw const MusicProviderException(
        'The active provider does not expose downloadable media',
      );
    }
    final track = ProviderTrack(
      identity: identity,
      title: item.title,
      artist: item.artist ?? 'Unknown artist',
      album: item.album ?? 'Unknown album',
      duration: item.duration,
      artworkUri: item.artUri,
      filePath: item.extras?['url']?.toString(),
      metadata: item.extras ?? const {},
    );
    return (activeProvider as MusicDownloadProvider).getDownload(
      track,
      format: format,
    );
  }

  Future<ProviderLyrics?> lyricsFor(MediaItem item) async {
    if (!capabilities.lyrics) return null;
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final track = await provider.getTrack(identity.sourceId) ??
        ProviderTrack(
          identity: identity,
          title: item.title,
          artist: item.artist ?? 'Unknown artist',
          album: item.album ?? 'Unknown album',
          duration: item.duration,
          artworkUri: item.artUri,
          filePath: item.extras?['url']?.toString(),
          metadata: item.extras ?? const {},
        );
    return provider.getLyrics(track);
  }

  MusicIdentity identityFromMediaItem(MediaItem item) => MusicIdentity(
        providerId: item.extras?['providerId']?.toString() ?? activeProviderId,
        profileId: item.extras?['profileId']?.toString() ?? activeProfileId,
        sourceId: item.extras?['sourceId']?.toString() ?? item.id,
      );

  void _assertActiveIdentity(MusicIdentity identity) {
    if (identity.providerId != activeProviderId ||
        identity.profileId != activeProfileId) {
      throw MusicProviderException(
        'Track belongs to ${identity.providerId}/${identity.profileId}, '
        'but $activeProviderId/$activeProfileId is active',
      );
    }
  }

  // Compatibility shapes for the existing view models. The data source is
  // still the active MusicProvider; widgets never select a concrete provider.
  Future<List<String>> getSearchSuggestion(String query) async {
    if (!capabilities.search) return const [];
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getSearchSuggestion(query);
    }
    final result = await provider.search(query);
    return result.tracks
        .map((track) => track.title)
        .take(10)
        .toList(growable: false);
  }

  Future<Map<String, dynamic>> search(
    String query, {
    String? filter,
    String? scope,
    int limit = 30,
    bool ignoreSpelling = false,
    String? filterParams,
  }) async {
    if (!capabilities.search) return const {};
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.searchCatalog(
        query,
        filter: filter,
        scope: scope,
        limit: limit,
        ignoreSpelling: ignoreSpelling,
        filterParams: filterParams,
      );
    }
    final result = await provider.search(query);
    final data = <String, dynamic>{};
    if (filter == null || filter == 'songs') {
      data['Songs'] =
          result.tracks.take(limit).map(mediaItemFromTrack).toList();
    }
    if (filter == null || filter == 'albums') {
      data['Albums'] = result.albums.take(limit).map(_legacyAlbum).toList();
    }
    if (filter == null || filter == 'artists') {
      data['Artists'] = result.artists.take(limit).map(_legacyArtist).toList();
    }
    data['searchEndpoint'] = {
      if (result.tracks.isNotEmpty) 'Songs': null,
      if (result.albums.isNotEmpty) 'Albums': null,
      if (result.artists.isNotEmpty) 'Artists': null,
    };
    return data;
  }

  Future<Map<String, dynamic>> getSearchContinuation(
      Map<dynamic, dynamic> params) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const {};
    return discovery.getSearchContinuation(params);
  }

  Future<List<dynamic>> getHome({int limit = 4}) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getHome(limit: limit);
    }
    final result = <dynamic>[];
    if (capabilities.tracks) {
      final values =
          (await provider.getTracks()).map(mediaItemFromTrack).toList();
      if (values.isNotEmpty) {
        result.add({
          'title': '${provider.displayName} library',
          'contents': values,
        });
      }
    }
    if (capabilities.albums) {
      final values = (await provider.getAlbums()).map(_legacyAlbum).toList();
      if (values.isNotEmpty) {
        result.add({'title': 'Albums', 'contents': values});
      }
    }
    if (capabilities.artists) {
      final values = (await provider.getArtists()).map(_legacyArtist).toList();
      if (values.isNotEmpty) {
        result.add({'title': 'Artists', 'contents': values});
      }
    }
    return result.take(limit).toList();
  }

  Future<List<dynamic>> getCharts(String category,
      {String? countryCode}) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.getCharts(category, countryCode: countryCode);
  }

  Future<List<dynamic>> explore({int limit = 4}) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.explore(limit: limit);
  }

  Future<List<dynamic>> podcastDiscover({int limit = 4}) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.podcastDiscover(limit: limit);
  }

  Future<Map<String, dynamic>> podcast(String sourceId) {
    final discovery = _discoveryProvider;
    return discovery != null
        ? discovery.podcast(sourceId)
        : getPlaylistOrAlbumSongs(albumId: sourceId);
  }

  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs({
    String? playlistId,
    String? albumId,
    int limit = 3000,
    bool related = false,
    int suggestionsLimit = 0,
  }) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getPlaylistOrAlbumSongs(
        playlistId: playlistId,
        albumId: albumId,
        limit: limit,
        related: related,
        suggestionsLimit: suggestionsLimit,
      );
    }
    final sourceId = albumId ?? playlistId;
    if (sourceId == null || !capabilities.albums) {
      return {'playlistId': playlistId ?? '', 'tracks': <MediaItem>[]};
    }
    final album = await provider.getAlbum(sourceId);
    if (album == null) {
      throw MusicProviderException('Album not found: $sourceId');
    }
    return {
      'browseId': album.identity.sourceId,
      'playlistId': playlistId,
      'title': album.title,
      'artists': [
        {'name': album.artist}
      ],
      'thumbnails': [
        {'url': album.artworkUri?.toString() ?? ''}
      ],
      'tracks': album.tracks.map(mediaItemFromTrack).toList(growable: false),
      'trackCount': album.tracks.length,
    };
  }

  Future<Map<String, dynamic>> getArtist(String sourceId) async {
    if (!capabilities.artists) {
      throw const MusicProviderException('Artists are unsupported');
    }
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getArtistDetails(sourceId);
    }
    final artist = await provider.getArtist(sourceId);
    if (artist == null) {
      throw MusicProviderException('Artist not found: $sourceId');
    }
    return {
      'name': artist.name,
      'channelId': artist.identity.sourceId,
      'thumbnails': [
        {'url': artist.artworkUri?.toString() ?? ''}
      ],
      'Songs': {
        'title': 'Songs',
        'content':
            artist.tracks.map(mediaItemFromTrack).toList(growable: false),
      },
      'Albums': {
        'title': 'Albums',
        'content': artist.albums.map(_legacyAlbum).toList(growable: false),
      },
    };
  }

  Future<Map<String, dynamic>> getArtistRealtedContent(
    Map<String, dynamic> endpoint,
    String category, {
    String additionalParams = '',
  }) async {
    final discovery = _discoveryProvider;
    if (discovery == null) {
      return {'results': endpoint['content'] ?? const []};
    }
    return discovery.getArtistRelatedContent(endpoint, category,
        additionalParams: additionalParams);
  }

  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
      String sourceId, String languageCode) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.getContentRelatedToSong(sourceId, languageCode);
  }

  Future<Map<String, dynamic>> getWatchPlaylist({
    String videoId = '',
    String? playlistId,
    int limit = 25,
    bool radio = false,
    bool shuffle = false,
    String? additionalParamsNext,
    bool onlyRelated = false,
  }) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getWatchPlaylist(
        videoId: videoId,
        playlistId: playlistId,
        limit: limit,
        radio: radio,
        shuffle: shuffle,
        additionalParamsNext: additionalParamsNext,
        onlyRelated: onlyRelated,
      );
    }
    if (onlyRelated) return const {'lyrics': null, 'related': null};
    final track = await provider.getTrack(videoId);
    return {
      'tracks': track == null ? <MediaItem>[] : [mediaItemFromTrack(track)],
      'playlistId': playlistId,
    };
  }

  Future<List<dynamic>> getSongWithId(String sourceId) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getSongWithId(sourceId);
    }
    final track = await provider.getTrack(sourceId);
    return [
      track != null,
      track == null ? null : [mediaItemFromTrack(track)]
    ];
  }

  Future<void> setContentLanguage(String languageCode) async {
    // Provider-specific locale changes belong in profile settings. Providers
    // that need it receive the value during their next initialization.
  }

  Future<String?> getLyrics(String sourceId) async {
    final track = await provider.getTrack(sourceId);
    if (track == null || !capabilities.lyrics) return null;
    return (await provider.getLyrics(track))?.plain;
  }

  Album _legacyAlbum(ProviderAlbum album) => Album(
        title: album.title,
        browseId: album.identity.sourceId,
        providerId: album.identity.providerId,
        profileId: album.identity.profileId,
        sourceId: album.identity.sourceId,
        artists: [
          {'name': album.artist}
        ],
        thumbnailUrl: album.artworkUri?.toString() ?? '',
      );

  Artist _legacyArtist(ProviderArtist artist) => Artist(
        name: artist.name,
        browseId: artist.identity.sourceId,
        providerId: artist.identity.providerId,
        profileId: artist.identity.profileId,
        sourceId: artist.identity.sourceId,
        thumbnailUrl: artist.artworkUri?.toString() ?? '',
      );

  String _durationLabel(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
