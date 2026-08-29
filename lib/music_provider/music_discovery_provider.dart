/// Optional catalog/discovery surface for providers that expose a rich online
/// music catalog. The UI consumes this contract through MusicCatalogService;
/// it never selects a concrete provider.
abstract interface class MusicDiscoveryProvider {
  Future<List<String>> getSearchSuggestion(String query);

  Future<Map<String, dynamic>> searchCatalog(
    String query, {
    String? filter,
    String? scope,
    int limit,
    bool ignoreSpelling,
    String? filterParams,
  });

  Future<Map<String, dynamic>> getSearchContinuation(
    Map<dynamic, dynamic> params,
  );

  Future<List<dynamic>> getHome({int limit});
  Future<List<dynamic>> getCharts(String category, {String? countryCode});
  Future<List<dynamic>> explore({int limit});
  Future<List<dynamic>> podcastDiscover({int limit});
  Future<Map<String, dynamic>> podcast(String sourceId);

  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs({
    String? playlistId,
    String? albumId,
    int limit,
    bool related,
    int suggestionsLimit,
  });

  Future<Map<String, dynamic>> getArtistDetails(String sourceId);
  Future<Map<String, dynamic>> getArtistRelatedContent(
    Map<String, dynamic> endpoint,
    String category, {
    String additionalParams,
  });
  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
    String sourceId,
    String languageCode,
  );
  Future<Map<String, dynamic>> getWatchPlaylist({
    String videoId,
    String? playlistId,
    int limit,
    bool radio,
    bool shuffle,
    String? additionalParamsNext,
    bool onlyRelated,
  });
  Future<List<dynamic>> getSongWithId(String sourceId);
}
