import 'package:audio_service/audio_service.dart' show MediaItem;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/base_class/playlist_album_screen_con_base.dart';
import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/music/music_service.dart' show NetworkError;
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

import 'package:harmonymusic/mixins/additional_opeartion_mixin.dart';
import 'package:harmonymusic/models/media_item_builder.dart';
import 'package:harmonymusic/ui/screens/Home/home_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';

///AlbumScreenController handles album screen
///
///Album title,image,songs
class AlbumScreenController extends PlaylistAlbumScreenControllerBase
    with AdditionalOpeartionMixin, GetSingleTickerProviderStateMixin {
  final catalogRecoveryService = Get.find<CatalogRecoveryService>();
  final album =
      Album(title: "", browseId: "", thumbnailUrl: "", artists: []).obs;
  final isOfflineAlbum = false.obs;
  // isOffline is inherited from PlaylistAlbumScreenControllerBase

  // Title animation
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heightAnimation;

  AnimationController get animationController => _animationController;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get heightAnimation => _heightAnimation;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(animationController);

    _heightAnimation = Tween<double>(begin: 10.0, end: 90.0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.easeOutBack));

    final args = Get.arguments as (Album?, String);
    fetchAlbumDetails(args.$1, args.$2);
    Future.delayed(const Duration(milliseconds: 200),
        () => Get.find<HomeScreenController>().whenHomeScreenOnTop());
  }

  @override
  void fetchAlbumDetails(Album? album_, String albumId) async {
    final wasInLibrary = await checkIfAddedToLibrary(albumId);
    try {
      if (album_ != null) {
        album.value = album_;
        animationController.forward();
      }
      if (wasInLibrary) {
        // Load cached tracks immediately for instant visual load
        final box = await SqliteStore.openBox(sanitizeBoxName(albumId));
        final sortedKeys = box.keys.toList()..sort((a, b) => int.parse(a.toString()).compareTo(int.parse(b.toString())));
        songList.value = sortedKeys
            .map((key) => MediaItemBuilder.fromJson(box.get(key)))
            .whereType<MediaItem>()
            .toList();
        _cacheAlbumThumbnail(albumId, album.value.thumbnailUrl);
      }

      // Fetch the most updated tracklist from the network
      final isPodcast =
          album_?.isPodcast == true || albumId.startsWith('MPSP');
      final content = isPodcast
          ? await musicServices.podcast(albumId)
          : await musicServices.getPlaylistOrAlbumSongs(albumId: albumId);
      content['browseId'] = albumId;
      album.value = Album.fromJson(content);
      animationController.forward();
      
      // Update with the latest network songs
      songList.value = List<MediaItem>.from(content['tracks'] ?? []);
      _cacheAlbumThumbnail(albumId, album.value.thumbnailUrl);

      if (wasInLibrary) {
        updateSongsIntoDb();
      }
      checkDownloadStatus();
    } on NetworkError catch (error) {
      printERROR("Error fetching album details (offline): $error");
      await _loadOfflineMode(albumId);
    } catch (e) {
      printERROR("Error fetching album details: $e");
    } finally {
      isContentFetched.value = true;
    }
  }

  String _albumTitleHint() {
    return album.value.title.trim();
  }


  /// Saves album thumbnail URL to SqliteStore for offline access
  Future<void> _cacheAlbumThumbnail(String albumId, String url) async {
    if (url.isEmpty) return;
    try {
      final box = await SqliteStore.openBox('AlbumThumbnails');
      box.put(albumId, url);
    } catch (_) {}
  }

  /// Loads offline mode: fills songList from cached library box or downloaded files
  Future<void> _loadOfflineMode(String albumId) async {
    isOffline.value = true;

    // Restore thumbnail from SqliteStore cache
    try {
      final box = await SqliteStore.openBox('AlbumThumbnails');
      final cachedUrl = box.get(albumId, defaultValue: '') as String;
      if (cachedUrl.isNotEmpty && album.value.thumbnailUrl.isEmpty) {
        album.value = Album(
          browseId: album.value.browseId,
          title: album.value.title,
          thumbnailUrl: cachedUrl,
          artists: album.value.artists ?? [],
        );
      }
    } catch (_) {}

    // 1. Load from library cached songs box if available
    try {
      final box = await SqliteStore.openBox(sanitizeBoxName(albumId));
      if (box.isNotEmpty) {
        final sortedKeys = box.keys.toList()..sort((a, b) => int.parse(a.toString()).compareTo(int.parse(b.toString())));
        songList.value = sortedKeys
            .map((key) => MediaItemBuilder.fromJson(box.get(key)))
            .whereType<MediaItem>()
            .toList();
        checkDownloadStatus();
        return;
      }
    } catch (_) {}

    // 2. Fallback: Load downloaded songs matching this album title
    try {
      final dlBox = SqliteStore.box('SongDownloads');
      final albumTitle = _albumTitleHint().toLowerCase();
      final List<MediaItem> downloaded = [];
      for (final value in dlBox.values) {
        if (value is! Map) continue;
        final songAlbum = (value['album'] as String?)?.toLowerCase() ?? '';
        if (albumTitle.isEmpty || songAlbum.contains(albumTitle)) {
          final item = MediaItemBuilder.fromJson(value);
          downloaded.add(item);
        }
      }
      if (downloaded.isNotEmpty) {
        songList.value = downloaded;
      }
    } catch (e) {
      printERROR('Error loading offline album songs: $e');
    }

    checkDownloadStatus();
  }

  @override
  Future<bool> checkIfAddedToLibrary(String id) async {
    final box = await SqliteStore.openBox("LibraryAlbums");
    isAddedToLibrary.value = box.containsKey(id);
    if (isAddedToLibrary.value) album.value = Album.fromJson(box.get(id));
    return isAddedToLibrary.value;
  }

  @override
  Future<bool> addNremoveFromLibrary(content, {bool add = true}) async {
    try {
      final box = await SqliteStore.openBox("LibraryAlbums");
      final id = content.browseId;
      if (add) {
        box.put(id, content.toJson());
        updateSongsIntoDb();
      } else {
        box.delete(id);
        final songsBox = await SqliteStore.openBox(sanitizeBoxName(id));
        songsBox.deleteFromDisk();
      }
      isAddedToLibrary.value = add;

      //Update frontend
      Get.find<LibraryAlbumsController>().refreshLib();
      Get.find<SyncService>().triggerPush();

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> updateSongsIntoDb() async {
    final songsBox = await SqliteStore.openBox(sanitizeBoxName(album.value.browseId));
    await songsBox.clear();
    final songListCopy = songList.toList();
    for (int i = 0; i < songListCopy.length; i++) {
      await songsBox.put(i, MediaItemBuilder.toJson(songListCopy[i]));
    }
  }

  @override
  void onClose() {
    tempListContainer.clear();
    _animationController.dispose();
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    super.onClose();
  }

  @override
  Future<void> deleteMultipleSongs(List<MediaItem> songs) async {}

  @override
  void fetchPlaylistDetails(Playlist? playlist_, String playlistId) {}

  @override
  void syncPlaylistSongs() {}
}
