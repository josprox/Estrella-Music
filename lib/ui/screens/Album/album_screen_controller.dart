import 'package:audio_service/audio_service.dart' show MediaItem;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/base_class/playlist_album_screen_con_base.dart';
import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/services/catalog_recovery_service.dart';
import 'package:harmonymusic/services/music_service.dart' show NetworkError;
import 'package:harmonymusic/utils/helper.dart';
import 'package:hive/hive.dart';

import '../../../mixins/additional_opeartion_mixin.dart';
import '../../../models/media_Item_builder.dart';
import '../Home/home_screen_controller.dart';
import '../Library/library_controller.dart';
import '../../../services/sync_service.dart';

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
      if (!wasInLibrary) {
        final isPodcast =
            album_?.isPodcast == true || albumId.startsWith('MPSP');
        final content = isPodcast
            ? await musicServices.podcast(albumId)
            : await musicServices.getPlaylistOrAlbumSongs(albumId: albumId);
        content['browseId'] = albumId;
        album.value = Album.fromJson(content);
        animationController.forward();
        songList.value = List<MediaItem>.from(content['tracks'] ?? []);
        // Cache the thumbnail URL for offline
        _cacheAlbumThumbnail(albumId, album.value.thumbnailUrl);
      } else {
        // Album details already loaded via checkIfAddedToLibrary
        final box = await Hive.openBox(albumId);
        songList.value = box.values
            .map<MediaItem?>((item) => MediaItemBuilder.fromJson(item))
            .whereType<MediaItem>()
            .toList();
        _cacheAlbumThumbnail(albumId, album.value.thumbnailUrl);
      }
      checkDownloadStatus();
    } on NetworkError catch (error) {
      printERROR("Error fetching album details: $error");
      if (wasInLibrary) {
        // Library songs loaded — try catalog recovery
        final recoveredAlbum = await catalogRecoveryService.findSimilarAlbum(
          title: _albumTitleHint(),
          artistName: _albumArtistHint(),
        );
        if (recoveredAlbum != null && recoveredAlbum.browseId != albumId) {
          try {
            final content = await musicServices.getPlaylistOrAlbumSongs(
              albumId: recoveredAlbum.browseId,
            );
            content['browseId'] = recoveredAlbum.browseId;
            album.value = Album.fromJson(content);
            animationController.forward();
            songList.value = List<MediaItem>.from(content['tracks']);
            await catalogRecoveryService.persistRecoveredAlbum(
              oldBrowseId: albumId,
              album: album.value,
              tracks: songList.toList(),
            );
            checkDownloadStatus();
            return;
          } catch (_) {}
        }
        // Fall through to offline mode using library songs
        await _loadOfflineMode(albumId);
      } else {
        await _loadOfflineMode(albumId);
      }
    } catch (e) {
      printERROR("Error fetching album details: $e");
    } finally {
      isContentFetched.value = true;
    }
  }

  String _albumTitleHint() {
    return album.value.title.trim();
  }

  String _albumArtistHint() {
    final artistName = album.value.artists?.firstOrNull?['name']?.toString();
    return artistName?.trim() ?? '';
  }

  /// Saves album thumbnail URL to Hive for offline access
  Future<void> _cacheAlbumThumbnail(String albumId, String url) async {
    if (url.isEmpty) return;
    try {
      final box = await Hive.openBox('AlbumThumbnails');
      box.put(albumId, url);
    } catch (_) {}
  }

  /// Loads offline mode: fills songList from SongDownloads filtered by album
  Future<void> _loadOfflineMode(String albumId) async {
    isOffline.value = true;

    // Restore thumbnail from Hive cache
    try {
      final box = await Hive.openBox('AlbumThumbnails');
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

    // Load downloaded songs matching this album
    try {
      final dlBox = Hive.box('SongDownloads');
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
    final box = await Hive.openBox("LibraryAlbums");
    isAddedToLibrary.value = box.containsKey(id);
    if (isAddedToLibrary.value) album.value = Album.fromJson(box.get(id));
    return isAddedToLibrary.value;
  }

  @override
  Future<bool> addNremoveFromLibrary(content, {bool add = true}) async {
    try {
      final box = await Hive.openBox("LibraryAlbums");
      final id = content.browseId;
      if (add) {
        box.put(id, content.toJson());
        updateSongsIntoDb();
      } else {
        box.delete(id);
        final songsBox = await Hive.openBox(id);
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
    final songsBox = await Hive.openBox(album.value.browseId);
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
