import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

import 'package:harmonymusic/utils/helpers/house_keeping.dart';
import 'package:harmonymusic/ui/widgets/add_to_playlist.dart';
import '/ui/widgets/sort_widget.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/services/social/piped_service.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import '/models/album.dart';
import '/models/artist.dart';
import '/models/media_item_builder.dart';
import '/models/playlist.dart';
import 'package:harmonymusic/generated/l10n.dart';

enum LibrarySongCollection { favorites, downloads, recent, migrated }

enum LibraryAlbumCollection { tastes, saved, recommended }

enum LibraryArtistCollection { tastes, followed, recommended }

class LibrarySongsController extends GetxController {
  late RxList<MediaItem> librarySongsList = RxList();
  final isSongFetched = false.obs;
  final selectedCollection = LibrarySongCollection.downloads.obs;
  final hasMigratedLibrary = false.obs;
  List<MediaItem> tempListContainer = [];
  SortWidgetController? sortWidgetController;
  final additionalOperationMode = OperationMode.none.obs;
  final List<StreamSubscription<dynamic>> _collectionSubscriptions = [];
  int _collectionLoadRevision = 0;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    // Make sure that song cached in system or not cleared by system
    // if cleared then it will remove from database as well
    List<String> songsList = [];
    final cacheDir = (await getTemporaryDirectory()).path;
    if (Directory("$cacheDir/cachedSongs/").existsSync()) {
      final downloadedFiles = Directory("$cacheDir/cachedSongs")
          .listSync()
          .where((f) => !['mime', 'part']
              .contains(f.path.replaceAll(RegExp(r'^.*\.'), '')));
      songsList.addAll(downloadedFiles
          .map((e) {
            RegExpMatch? match =
                RegExp(".cachedSongs/([^#]*)?.mp3").firstMatch(e.path);
            if (match != null) {
              return match[1]!;
            }
          })
          .whereType<String>()
          .toList());
      //printINFO("all files: $downloadedFiles \n $songsList");
    }

    final box = SqliteStore.box("SongsCache");
    for (var element in box.keys) {
      if (!songsList.contains(element)) {
        box.delete(element);
      }
    }

    await SqliteStore.openBox('LEGACY_LIBRARY');
    hasMigratedLibrary.value =
        SqliteStore.box('LEGACY_LIBRARY').values.isNotEmpty;
    await _loadSelectedCollection();
    _watchCollections();
    isSongFetched.value = true;

    //Remove deleted songs and expired songUrl from database
    startHouseKeeping();
  }

  void _watchCollections() {
    if (_collectionSubscriptions.isNotEmpty) return;
    for (final boxName in const [
      'LIBFAV',
      'SongsCache',
      'SongDownloads',
      'LIBRP',
      'LEGACY_LIBRARY',
    ]) {
      _collectionSubscriptions.add(
        SqliteStore.box(boxName).watch().listen((_) {
          hasMigratedLibrary.value =
              SqliteStore.box('LEGACY_LIBRARY').values.isNotEmpty;
          _loadSelectedCollection();
        }),
      );
    }
  }

  Future<void> selectCollection(LibrarySongCollection collection) async {
    if (collection == LibrarySongCollection.migrated &&
        !hasMigratedLibrary.value) {
      return;
    }
    if (additionalOperationMode.value != OperationMode.none) return;
    if (Get.isRegistered<SortWidgetController>(tag: 'LibSongSort')) {
      final sortController = Get.find<SortWidgetController>(tag: 'LibSongSort');
      sortController.isSearchingEnabled.value = false;
      sortController.textEditingController.clear();
    }
    selectedCollection.value = collection;
    tempListContainer.clear();
    await _loadSelectedCollection();
  }

  Future<void> refreshCollections() async {
    await SqliteStore.openBox('LEGACY_LIBRARY');
    hasMigratedLibrary.value =
        SqliteStore.box('LEGACY_LIBRARY').values.isNotEmpty;
    await _loadSelectedCollection();
  }

  Future<void> _loadSelectedCollection() async {
    final collection = selectedCollection.value;
    final revision = ++_collectionLoadRevision;
    final boxNames = switch (collection) {
      LibrarySongCollection.favorites => const ['LIBFAV'],
      LibrarySongCollection.downloads => const ['SongsCache', 'SongDownloads'],
      LibrarySongCollection.recent => const ['LIBRP'],
      LibrarySongCollection.migrated => const ['LEGACY_LIBRARY'],
    };

    final songsById = <String, MediaItem>{};
    for (final boxName in boxNames) {
      final box = await SqliteStore.openBox(boxName);
      for (final value in box.values) {
        try {
          final song = MediaItemBuilder.fromJson(value);
          if (song.id.isNotEmpty) songsById[song.id] = song;
        } catch (error, stack) {
          debugPrint('Error parsing $boxName song: $error\n$stack');
        }
      }
    }
    if (revision == _collectionLoadRevision &&
        collection == selectedCollection.value) {
      librarySongsList.value = songsById.values.toList();
    }
  }

  String get selectedCollectionBoxId => switch (selectedCollection.value) {
        LibrarySongCollection.favorites => 'LIBFAV',
        LibrarySongCollection.downloads => 'SongDownloads',
        LibrarySongCollection.recent => 'LIBRP',
        LibrarySongCollection.migrated => 'LEGACY_LIBRARY',
      };

  void onSort(SortType sortType, bool isAscending) {
    final songlist = librarySongsList.toList();
    sortSongsNVideos(songlist, sortType, isAscending);
    librarySongsList.value = songlist;
  }

  void onSearchStart(String? tag) {
    tempListContainer = librarySongsList.toList();
  }

  void onSearch(String value, String? tag) {
    final songlist = tempListContainer
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    librarySongsList.value = songlist;
  }

  void onSearchClose(String? tag) {
    librarySongsList.value = tempListContainer.toList();
    tempListContainer.clear();
  }

  /// remove song from library list and from storage only, not from database
  Future<void> removeSong(MediaItem item, bool isDownloaded,
      {String? url}) async {
    if (tempListContainer.isNotEmpty) {
      tempListContainer.remove(item);
    }
    librarySongsList.remove(item);
    String filePath = "";
    if (isDownloaded) {
      filePath = item.extras!['url'] ?? url;
    } else {
      final cacheDir = (await getTemporaryDirectory()).path;
      filePath = "$cacheDir/cachedSongs/${item.id}.mp3";
    }

    if (await (File(filePath)).exists()) {
      await (File(filePath)).delete();
    }

    final thumbFile = File(
        "${Get.find<SettingsScreenController>().supportDirPath}/thumbnails/${item.id}.png");
    if (await thumbFile.exists()) {
      await thumbFile.delete();
    }
  }

//Additional operations
  final additionalOperationTempList = [].obs;
  final additionalOperationTempMap = <int, bool>{}.obs;

  void startAdditionalOperation(
      SortWidgetController sortWidgetController_, OperationMode mode) {
    sortWidgetController = sortWidgetController_;
    additionalOperationTempList.value = librarySongsList.toList();
    if (mode == OperationMode.addToPlaylist || mode == OperationMode.delete) {
      for (int i = 0; i < additionalOperationTempList.length; i++) {
        additionalOperationTempMap[i] = false;
      }
    }
    additionalOperationMode.value = mode;
  }

  void checkIfAllSelected() {
    sortWidgetController!.isAllSelected.value =
        !additionalOperationTempMap.containsValue(false);
  }

  void selectAll(bool selected) {
    for (int i = 0; i < additionalOperationTempList.length; i++) {
      additionalOperationTempMap[i] = selected;
    }
  }

  void performAdditionalOperation() {
    final currMode = additionalOperationMode.value;
    if (currMode == OperationMode.delete) {
      deleteMultipleSongs(selectedSongs()).then((value) {
        sortWidgetController?.setActiveMode(OperationMode.none);
        cancelAdditionalOperation();
      });
    } else if (currMode == OperationMode.addToPlaylist) {
      showDialog(
        context: Get.context!,
        builder: (context) => AddToPlaylist(selectedSongs()),
      ).whenComplete(() {
        Get.delete<AddToPlaylistController>();
        sortWidgetController?.setActiveMode(OperationMode.none);
        cancelAdditionalOperation();
      });
    }
  }

  Future<void> deleteMultipleSongs(List<MediaItem> songs) async {
    final downloadsBox = await SqliteStore.openBox("SongDownloads");
    final cacheBox = await SqliteStore.openBox("SongsCache");
    for (MediaItem element in songs) {
      if (downloadsBox.containsKey(element.id)) {
        await downloadsBox.delete(element.id);
        removeSong(element, true);
      } else {
        await cacheBox.delete(element.id);
        removeSong(element, false);
      }
    }
  }

  List<MediaItem> selectedSongs() {
    return additionalOperationTempMap.entries
        .map((item) {
          if (item.value) {
            return additionalOperationTempList[item.key];
          }
        })
        .whereType<MediaItem>()
        .toList();
  }

  void cancelAdditionalOperation() {
    sortWidgetController!.isAllSelected.value = false;
    sortWidgetController = null;
    additionalOperationMode.value = OperationMode.none;
    additionalOperationTempList.clear();
    additionalOperationTempMap.clear();
  }

  @override
  void onClose() {
    for (final subscription in _collectionSubscriptions) {
      subscription.cancel();
    }
    super.onClose();
  }
}

class LibraryPlaylistsController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController controller;

  final playlistCreationMode = "local".obs;
  static const reservedCollectionIds = {
    'LIBRP',
    'LIBFAV',
    'SongsCache',
    'SongDownloads',
    'LEGACY_LIBRARY',
  };
  late RxList<Playlist> libraryPlaylists = RxList();
  final isContentFetched = false.obs;
  final creationInProgress = false.obs;
  final textInputController = TextEditingController();
  List<Playlist> tempListContainer = [];

  // Add these RxBool to track import progress
  final isImporting = false.obs;
  final importProgress = 0.0.obs;

  @override
  void onInit() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    refreshLib();
    super.onInit();
  }

  void refreshLib() async {
    final box = await SqliteStore.openBox("LibraryPlaylists");
    final List<Playlist> loaded = [];
    for (var item in box.values) {
      try {
        if (item is Map) {
          final playlist = Playlist.fromJson(Map<dynamic, dynamic>.from(item));
          if (!reservedCollectionIds.contains(playlist.playlistId)) {
            loaded.add(playlist);
          }
        }
      } catch (e, stack) {
        debugPrint("Error parsing playlist in refreshLib: $e\n$stack");
      }
    }

    libraryPlaylists.value = loaded;

    final appPrefsBox = SqliteStore.box("AppPrefs");
    if (appPrefsBox.containsKey("piped")) {
      if (appPrefsBox.get("piped")['isLoggedIn']) await syncPipedPlaylist();
    }

    isContentFetched.value = true;
  }

  void updatePlaylistIntoDb(Playlist playlist) async {
    final box = await SqliteStore.openBox("LibraryPlaylists");
    box.put(playlist.playlistId, playlist.toJson());
    refreshLib();
  }

  void removePipedPlaylists() {
    for (Playlist plst in libraryPlaylists.toList()) {
      if (plst.isPipedPlaylist) {
        libraryPlaylists.remove(plst);
      }
    }
  }

  Future<void> syncPipedPlaylist() async {
    final res = await Get.find<PipedServices>().getAllPlaylists();
    final box = await SqliteStore.openBox('blacklistedPlaylist');
    final blacklistedPlaylist = box.values.whereType<String>().toList();
    final libPipedPlaylistsId = libraryPlaylists
            .toList()
            .map((e) {
              if (e.isPipedPlaylist) {
                return e.playlistId;
              }
            })
            .whereType<String>()
            .toList() +
        blacklistedPlaylist;

    if (res.code == 1) {
      final cloudpipedPlaylistsId = res.response
          .map((e) {
            return e['id'];
          })
          .whereType<String>()
          .toList();
      //add new playlist from cloud
      for (dynamic playlist in res.response) {
        if (!libPipedPlaylistsId.contains(playlist['id'])) {
          final plst = Playlist(
            title: playlist['name'],
            playlistId: playlist['id'],
            description: S.current.pipedPlaylistDescription,
            thumbnailUrl: playlist['thumbnail'],
            isPipedPlaylist: true,
          );
          libraryPlaylists.add(plst);
        }
      }

      //remove playist if removed from cloud
      for (Playlist playlist in libraryPlaylists.toList()) {
        if (!cloudpipedPlaylistsId.contains(playlist.playlistId) &&
            playlist.isPipedPlaylist) {
          libraryPlaylists.removeWhere(
              (element) => element.playlistId == playlist.playlistId);
        }
      }
    }
  }

  Future<bool> renamePlaylist(Playlist playlist) async {
    String title = textInputController.text;
    if (title.trim().isNotEmpty) {
      if (playlist.isPipedPlaylist) {
        final res = await Get.find<PipedServices>()
            .renamePlaylist(playlist.playlistId, title);
        if (res.code == 0) return false;
        playlist.newTitle = title;
      } else {
        final box = await SqliteStore.openBox("LibraryPlaylists");
        title = "${title[0].toUpperCase()}${title.substring(1).toLowerCase()}";
        playlist.newTitle = title;
        box.put(playlist.playlistId, playlist.toJson());
      }
      refreshLib();
      return true;
    }
    return false;
  }

  void changeCreationMode(String? val) {
    playlistCreationMode.value = val!;
  }

  Future<bool> createNewPlaylist({
    bool createPlaylistNaddSong = false,
    List<MediaItem>? songItems,
    bool isCollaborative = false,
    List<dynamic> collaborators = const [],
  }) async {
    String title = textInputController.text;
    if (title.trim().isNotEmpty) {
      dynamic newplst;

      if (playlistCreationMode.value == "piped") {
        creationInProgress.value = true;
        final res = await Get.find<PipedServices>().createPlaylist(title);
        if (res.code == 1) {
          newplst = Playlist(
              title: title,
              playlistId: "${res.response['playlistId']}",
              thumbnailUrl: songItems != null
                  ? songItems[0].artUri.toString()
                  : Playlist.thumbPlaceholderUrl,
              description: S.current.pipedPlaylistDescription,
              isCloudPlaylist: true,
              isPipedPlaylist: true);
        } else {
          creationInProgress.value = false;
          return false;
        }
      } else {
        final isCloudMode = Get.find<SyncService>().isCloudMode;
        newplst = Playlist(
            title: title,
            playlistId: "LIB${DateTime.now().millisecondsSinceEpoch}",
            thumbnailUrl: songItems != null
                ? songItems[0].artUri.toString()
                : Playlist.thumbPlaceholderUrl,
            description: isCollaborative
                ? S.current.collaborativePlaylistDescription
                : S.current.libraryPlaylistDescription,
            isCloudPlaylist: isCloudMode,
            isCollaborative: isCollaborative,
            collaborators: collaborators);
        final box = await SqliteStore.openBox("LibraryPlaylists");
        box.put(newplst.playlistId, newplst.toJson());
        await box.close();
      }

      libraryPlaylists.add(newplst);

      if (createPlaylistNaddSong && playlistCreationMode.value == "local") {
        final plastbox =
            await SqliteStore.openBox(sanitizeBoxName(newplst.playlistId));
        for (MediaItem item in songItems!) {
          plastbox.add(MediaItemBuilder.toJson(item));
        }
      } else if ((createPlaylistNaddSong &&
          playlistCreationMode.value == "piped")) {
        final songIds = songItems!.map((e) => e.id).toList();
        await Get.find<PipedServices>()
            .addToPlaylist(newplst.playlistId, songIds);
      }
      if (playlistCreationMode.value == "local") {
        if (isCollaborative) {
          await Get.find<SyncService>().pushCollaborative(newplst);
        } else {
          await Get.find<SyncService>()
              .recordPlaylistChange(newplst.playlistId);
        }
      }
      creationInProgress.value = false;
      return true;
    }
    return false;
  }

  Future<void> blacklistPipedPlaylist(Playlist playlist) async {
    final box = await SqliteStore.openBox('blacklistedPlaylist');
    box.add(playlist.playlistId);
    libraryPlaylists.remove(playlist);
  }

  Future<void> resetBlacklistedPlaylist() async {
    final box = await SqliteStore.openBox('blacklistedPlaylist');
    box.clear();
    syncPipedPlaylist();
  }

  void onSort(SortType sortType, bool isAscending) {
    final playlists = libraryPlaylists.toList();
    sortPlayLists(playlists, sortType, isAscending);
    libraryPlaylists.value = playlists;
  }

  void onSearchStart(String? tag) {
    tempListContainer = libraryPlaylists.toList();
  }

  void onSearch(String value, String? tag) {
    final songlist = tempListContainer
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    libraryPlaylists.value = songlist;
  }

  void onSearchClose(String? tag) {
    libraryPlaylists.value = tempListContainer.toList();
    tempListContainer.clear();
  }

  @override
  void dispose() {
    textInputController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> importPlaylistFromJson(BuildContext context) async {
    try {
      isImporting.value = true;
      importProgress.value = 0.1;

      // Show progress dialog
      if (context.mounted) {
        _showImportProgressDialog(context);
      }

      // Use file_picker to select JSON file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: S.current.importPlaylist,
      );

      if (result == null || result.files.isEmpty) {
        // User cancelled the picker
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        isImporting.value = false;
        importProgress.value = 0.0;
        return;
      }

      importProgress.value = 0.2;

      final file = File(result.files.single.path!);
      if (!await file.exists()) {
        throw FileSystemException(S.current.fileNotFound);
      }

      final jsonString = await file.readAsString();
      importProgress.value = 0.3;

      final jsonData = jsonDecode(jsonString);
      importProgress.value = 0.4;

      // Validate JSON structure
      if (!jsonData.containsKey('playlistInfo') ||
          !jsonData.containsKey('songs')) {
        throw FormatException(S.current.invalidPlaylistFile);
      }

      // Create new playlist ID
      final playlistInfo = jsonData['playlistInfo'];
      final newPlaylistId = "LIB${DateTime.now().millisecondsSinceEpoch}";
      importProgress.value = 0.5;

      // Create playlist object
      final newPlaylist = Playlist(
        title: "${playlistInfo['title']} (${S.current.imported})",
        playlistId: newPlaylistId,
        thumbnailUrl: playlistInfo['thumbnailUrl'] ??
            (playlistInfo['thumbnails'] != null &&
                    playlistInfo['thumbnails'].isNotEmpty
                ? playlistInfo['thumbnails'][0]['url']
                : Playlist.thumbPlaceholderUrl),
        description: playlistInfo['description'] ?? S.current.importedPlaylist,
        isCloudPlaylist: false,
      );
      importProgress.value = 0.6;

      // Save playlist to database
      final box = await SqliteStore.openBox("LibraryPlaylists");
      box.put(newPlaylistId, newPlaylist.toJson());
      importProgress.value = 0.7;

      // Save songs to playlist
      final songsBox =
          await SqliteStore.openBox(sanitizeBoxName(newPlaylistId));
      final songsList = jsonData['songs'] as List;

      // Update progress as songs are added
      final totalSongs = songsList.length;
      for (int i = 0; i < totalSongs; i++) {
        await songsBox.put(i, songsList[i]);
        // Update progress from 70% to 95% based on song import progress
        importProgress.value = 0.7 + (0.25 * (i + 1) / totalSongs);
      }

      importProgress.value = 1.0;

      // Close progress dialog if it's still open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Refresh library to show the new playlist
      refreshLib();
      await Get.find<SyncService>().recordPlaylistChange(newPlaylistId);

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar(
            context,
            "${S.current.playlistImportedMsg}: ${newPlaylist.title}",
            size: SanckBarSize.MEDIUM,
          ),
        );
      }
    } catch (e) {
      // Close progress dialog if it's still open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      printERROR("Error importing playlist: $e");

      String errorMsg = S.current.importError;
      if (e is FileSystemException) {
        errorMsg = S.current.importErrorFileAccess;
      } else if (e is FormatException) {
        errorMsg = S.current.importErrorFormat;
      } else if (e.toString().contains("invalidPlaylistFile")) {
        errorMsg = S.current.invalidPlaylistFile;
      } else if (e is SqliteStoreException) {
        errorMsg = S.current.importErrorDatabase;
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackbar(context, errorMsg, size: SanckBarSize.MEDIUM));
      }
    } finally {
      isImporting.value = false;
      importProgress.value = 0.0;
    }
  }

  // Helper method to show import progress dialog
  void _showImportProgressDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          S.current.importingPlaylist,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(
                  value: Get.isRegistered<LibraryPlaylistsController>()
                      ? importProgress.value
                      : 0,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "${(Get.isRegistered<LibraryPlaylistsController>() ? importProgress.value * 100 : 0).toInt()}%",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )),
      ),
      barrierDismissible: false,
    );
  }
}

class LibraryAlbumsController extends GetxController {
  final MusicServices _musicServices = Get.find<MusicServices>();
  final libraryAlbums = <Album>[].obs;
  final selectedCollection = LibraryAlbumCollection.tastes.obs;
  final isContentFetched = false.obs;
  final isLoadingRecommended = false.obs;
  final List<Album> _tasteAlbums = [];
  final List<Album> _savedAlbums = [];
  final List<Album> _recommendedAlbums = [];
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  List<Album> tempListContainer = [];
  Timer? _recommendationRefreshDebounce;
  int _recommendationRevision = 0;

  @override
  void onInit() {
    super.onInit();
    refreshLib();
    _watchSources();
  }

  Future<void> refreshLib() async {
    await Future.wait([_loadSavedAlbums(), _loadTasteAlbums()]);
    _applySelectedCollection();
    isContentFetched.value = true;
  }

  void _watchSources() {
    _subscriptions.add(
      SqliteStore.box('LibraryAlbums').watch().listen((_) {
        _loadSavedAlbums().then((_) => _applySelectedCollection());
      }),
    );
    _subscriptions.add(
      SqliteStore.box('LIBFAV').watch().listen((_) {
        _loadTasteAlbums().then((_) {
          _recommendedAlbums.clear();
          _applySelectedCollection();
          if (selectedCollection.value == LibraryAlbumCollection.recommended) {
            _recommendationRefreshDebounce?.cancel();
            _recommendationRefreshDebounce = Timer(
              const Duration(milliseconds: 500),
              () => _loadRecommendedAlbums(force: true),
            );
          }
        });
      }),
    );
  }

  Future<void> _loadSavedAlbums() async {
    final box = await SqliteStore.openBox('LibraryAlbums');
    final loaded = <Album>[];
    for (final item in box.values) {
      try {
        if (item is Map) {
          loaded.add(Album.fromJson(Map<dynamic, dynamic>.from(item)));
        }
      } catch (error, stack) {
        debugPrint('Error parsing saved album: $error\n$stack');
      }
    }
    _savedAlbums
      ..clear()
      ..addAll(loaded);
  }

  Future<void> _loadTasteAlbums() async {
    final box = await SqliteStore.openBox('LIBFAV');
    final albumsByKey = <String, Album>{};
    for (final value in box.values) {
      if (value is! Map) continue;
      final song = Map<dynamic, dynamic>.from(value);
      final rawAlbum = song['album'];
      if (rawAlbum is! Map) continue;
      final albumMap = Map<dynamic, dynamic>.from(rawAlbum);
      final title = (albumMap['name'] ?? albumMap['title'])?.toString().trim();
      if (title == null || title.isEmpty) continue;
      final sourceId =
          (albumMap['id'] ?? albumMap['browseId'])?.toString().trim();
      final browseId = sourceId == null || sourceId.isEmpty
          ? 'LOCAL_ALBUM_${sanitizeBoxName(title.toLowerCase())}'
          : sourceId;
      final rawArtists = song['artists'];
      final artists = rawArtists is List
          ? rawArtists
              .whereType<Map>()
              .map((artist) => Map<dynamic, dynamic>.from(artist))
              .toList()
          : <Map<dynamic, dynamic>>[];
      albumsByKey.putIfAbsent(
        sourceId == null || sourceId.isEmpty ? title.toLowerCase() : sourceId,
        () => Album(
          title: title,
          browseId: browseId,
          artists: artists,
          thumbnailUrl: _songThumbnail(song),
        ),
      );
    }
    _tasteAlbums
      ..clear()
      ..addAll(albumsByKey.values);
  }

  String _songThumbnail(Map<dynamic, dynamic> song) {
    final thumbnails = song['thumbnails'];
    if (thumbnails is List && thumbnails.isNotEmpty) {
      final first = thumbnails.first;
      if (first is Map) return first['url']?.toString() ?? '';
    }
    return song['thumbnailUrl']?.toString() ?? song['artUri']?.toString() ?? '';
  }

  Future<void> selectCollection(LibraryAlbumCollection collection) async {
    if (Get.isRegistered<SortWidgetController>(tag: 'LibAlbumSort')) {
      final sortController =
          Get.find<SortWidgetController>(tag: 'LibAlbumSort');
      sortController.isSearchingEnabled.value = false;
      sortController.textEditingController.clear();
    }
    selectedCollection.value = collection;
    tempListContainer.clear();
    if (collection == LibraryAlbumCollection.recommended &&
        _recommendedAlbums.isEmpty) {
      await _loadRecommendedAlbums();
      return;
    }
    _applySelectedCollection();
  }

  Future<void> _loadRecommendedAlbums({bool force = false}) async {
    if (isLoadingRecommended.isTrue) return;
    if (!force && _recommendedAlbums.isNotEmpty) {
      _applySelectedCollection();
      return;
    }
    final revision = ++_recommendationRevision;
    isLoadingRecommended.value = true;
    if (selectedCollection.value == LibraryAlbumCollection.recommended) {
      libraryAlbums.clear();
    }
    try {
      final recommendations = <String, Album>{};
      final excludedIds = {
        ..._tasteAlbums.map((album) => album.browseId),
        ..._savedAlbums.map((album) => album.browseId),
      };
      final excludedTitles = {
        ..._tasteAlbums.map((album) => album.title.toLowerCase()),
        ..._savedAlbums.map((album) => album.title.toLowerCase()),
      };
      final lang = _contentLanguageCode();
      final favorites = SqliteStore.box('LIBFAV').values.whereType<Map>();
      for (final rawSong in favorites.take(4)) {
        final song = Map<dynamic, dynamic>.from(rawSong);
        final songId = (song['videoId'] ?? song['id'])?.toString();
        if (songId == null || songId.isEmpty) continue;
        final sections =
            await _musicServices.getContentRelatedToSong(songId, lang);
        for (final section in sections) {
          final contents = section['contents'];
          if (contents is! List) continue;
          for (final album in contents.whereType<Album>()) {
            if (album.browseId.isEmpty ||
                excludedIds.contains(album.browseId) ||
                excludedTitles.contains(album.title.toLowerCase())) {
              continue;
            }
            recommendations[album.browseId] = album;
          }
        }
      }
      if (recommendations.isEmpty) {
        for (final seed in _tasteAlbums.take(3)) {
          final results =
              await _musicServices.search(seed.title, filter: 'albums');
          for (final value in results.values) {
            if (value is! List) continue;
            for (final album in value.whereType<Album>()) {
              if (album.browseId.isEmpty ||
                  excludedIds.contains(album.browseId) ||
                  excludedTitles.contains(album.title.toLowerCase())) {
                continue;
              }
              recommendations[album.browseId] = album;
            }
          }
        }
      }
      if (revision == _recommendationRevision) {
        _recommendedAlbums
          ..clear()
          ..addAll(recommendations.values.take(30));
      }
    } catch (error, stack) {
      debugPrint('Error loading recommended albums: $error\n$stack');
    } finally {
      if (revision == _recommendationRevision) {
        isLoadingRecommended.value = false;
        _applySelectedCollection();
      }
    }
  }

  String _contentLanguageCode() {
    const unsupported = {'ia', 'ga', 'fj', 'eo'};
    final language =
        Get.find<SettingsScreenController>().currentAppLanguageCode.value;
    return unsupported.contains(language) ? 'en' : language;
  }

  void _applySelectedCollection() {
    if (tempListContainer.isNotEmpty) return;
    libraryAlbums.assignAll(switch (selectedCollection.value) {
      LibraryAlbumCollection.tastes => _tasteAlbums,
      LibraryAlbumCollection.saved => _savedAlbums,
      LibraryAlbumCollection.recommended => _recommendedAlbums,
    });
  }

  void onSort(SortType sortType, bool isAscending) {
    final albumList = libraryAlbums.toList();
    sortAlbumNSingles(albumList, sortType, isAscending);
    libraryAlbums.value = albumList;
  }

  void onSearchStart(String? tag) {
    tempListContainer = libraryAlbums.toList();
  }

  void onSearch(String value, String? tag) {
    final songlist = tempListContainer
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    libraryAlbums.value = songlist;
  }

  void onSearchClose(String? tag) {
    libraryAlbums.value = tempListContainer.toList();
    tempListContainer.clear();
  }

  @override
  void onClose() {
    _recommendationRefreshDebounce?.cancel();
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.onClose();
  }
}

class LibraryArtistsController extends GetxController {
  final MusicServices _musicServices = Get.find<MusicServices>();
  final libraryArtists = <Artist>[].obs;
  final selectedCollection = LibraryArtistCollection.tastes.obs;
  final isContentFetched = false.obs;
  final isLoadingRecommended = false.obs;
  final List<Artist> _tasteArtists = [];
  final List<Artist> _followedArtists = [];
  final List<Artist> _recommendedArtists = [];
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  List<Artist> tempListContainer = [];
  Timer? _recommendationRefreshDebounce;
  int _recommendationRevision = 0;
  int _tastePhotoRevision = 0;

  @override
  void onInit() {
    super.onInit();
    refreshLib();
    _watchSources();
  }

  Future<void> refreshLib() async {
    await Future.wait([
      _loadFollowedArtists(),
      _loadTasteArtists(),
    ]);
    _applySelectedCollection();
    isContentFetched.value = true;
  }

  void _watchSources() {
    _subscriptions.add(
      SqliteStore.box('LibraryArtists').watch().listen((_) {
        _loadFollowedArtists().then((_) => _applySelectedCollection());
      }),
    );
    _subscriptions.add(
      SqliteStore.box('LIBFAV').watch().listen((_) {
        _loadTasteArtists().then((_) {
          _recommendedArtists.clear();
          _applySelectedCollection();
          if (selectedCollection.value == LibraryArtistCollection.recommended) {
            _recommendationRefreshDebounce?.cancel();
            _recommendationRefreshDebounce = Timer(
              const Duration(milliseconds: 500),
              () => _loadRecommendedArtists(force: true),
            );
          }
        });
      }),
    );
  }

  Future<void> _loadFollowedArtists() async {
    final box = await SqliteStore.openBox('LibraryArtists');
    final loaded = <Artist>[];
    for (final item in box.values) {
      try {
        if (item is Map) {
          loaded.add(Artist.fromJson(Map<dynamic, dynamic>.from(item)));
        }
      } catch (error, stack) {
        debugPrint('Error parsing followed artist: $error\n$stack');
      }
    }
    _followedArtists
      ..clear()
      ..addAll(loaded);
  }

  Future<void> _loadTasteArtists() async {
    final box = await SqliteStore.openBox('LIBFAV');
    final artistsByKey = <String, Artist>{};
    for (final value in box.values) {
      if (value is! Map) continue;
      final song = Map<dynamic, dynamic>.from(value);
      final rawArtists = song['artists'] ??
          (song['extras'] is Map ? song['extras']['artists'] : null);
      if (rawArtists is! List) continue;
      for (final rawArtist in rawArtists) {
        if (rawArtist is! Map) continue;
        final artistMap = Map<dynamic, dynamic>.from(rawArtist);
        final name =
            (artistMap['name'] ?? artistMap['artist'])?.toString().trim() ?? '';
        if (name.isEmpty) continue;
        final sourceId =
            (artistMap['id'] ?? artistMap['browseId'] ?? artistMap['channelId'])
                ?.toString()
                .trim();
        final browseId = sourceId == null || sourceId.isEmpty
            ? 'LOCAL_ARTIST_${sanitizeBoxName(name.toLowerCase())}'
            : sourceId;
        final key = sourceId == null || sourceId.isEmpty
            ? name.toLowerCase()
            : sourceId;
        artistsByKey.putIfAbsent(
          key,
          () => Artist(
            name: name,
            browseId: browseId,
            thumbnailUrl: '',
          ),
        );
      }
    }
    _tasteArtists
      ..clear()
      ..addAll(artistsByKey.values);
    final revision = ++_tastePhotoRevision;
    unawaited(_hydrateTasteArtistPhotos(revision));
  }

  Future<void> _hydrateTasteArtistPhotos(int revision) async {
    final cache = await SqliteStore.openBox('ArtistProfileCache');
    for (var index = 0; index < _tasteArtists.length; index++) {
      if (revision != _tastePhotoRevision) return;
      final artist = _tasteArtists[index];
      final cacheKey = artist.browseId.startsWith('LOCAL_ARTIST_')
          ? artist.name.toLowerCase()
          : artist.browseId;
      Artist? resolved;
      final cached = cache.get(cacheKey);
      if (cached is Map) {
        try {
          resolved = Artist.fromJson(Map<dynamic, dynamic>.from(cached));
        } catch (_) {}
      }
      if (resolved == null || resolved.thumbnailUrl.isEmpty) {
        resolved = await _fetchArtistProfile(artist);
        if (resolved != null && resolved.thumbnailUrl.isNotEmpty) {
          await cache.put(cacheKey, resolved.toJson());
        }
      }
      if (resolved != null && resolved.thumbnailUrl.isNotEmpty) {
        _tasteArtists[index] = resolved;
        if (selectedCollection.value == LibraryArtistCollection.tastes &&
            tempListContainer.isEmpty) {
          libraryArtists.assignAll(_tasteArtists);
        }
      }
    }
  }

  Future<Artist?> _fetchArtistProfile(Artist artist) async {
    if (!artist.browseId.startsWith('LOCAL_ARTIST_')) {
      try {
        final data = await _musicServices.getArtist(artist.browseId);
        final json = Map<String, dynamic>.from(data)
          ..['artist'] = data['name'] ?? artist.name
          ..['browseId'] = artist.browseId;
        final resolved = Artist.fromJson(json);
        if (resolved.thumbnailUrl.isNotEmpty) return resolved;
      } catch (error) {
        debugPrint(
            'Artist ID ${artist.browseId} is no longer valid for ${artist.name}: $error');
      }
    }
    try {
      final results =
          await _musicServices.search(artist.name, filter: 'artists', limit: 8);
      final candidates = results.values
          .whereType<List>()
          .expand((items) => items)
          .whereType<Artist>()
          .toList();
      final normalizedName = artist.name.trim().toLowerCase();
      for (final candidate in candidates) {
        if (candidate.name.trim().toLowerCase() == normalizedName) {
          return candidate;
        }
      }
      return candidates.firstOrNull;
    } catch (error) {
      debugPrint('Error searching profile photo for ${artist.name}: $error');
      return null;
    }
  }

  Future<void> selectCollection(LibraryArtistCollection collection) async {
    if (Get.isRegistered<SortWidgetController>(tag: 'LibArtistSort')) {
      final sortController =
          Get.find<SortWidgetController>(tag: 'LibArtistSort');
      sortController.isSearchingEnabled.value = false;
      sortController.textEditingController.clear();
    }
    selectedCollection.value = collection;
    tempListContainer.clear();
    if (collection == LibraryArtistCollection.recommended &&
        _recommendedArtists.isEmpty) {
      await _loadRecommendedArtists();
      return;
    }
    _applySelectedCollection();
  }

  Future<void> _loadRecommendedArtists({bool force = false}) async {
    if (isLoadingRecommended.isTrue) return;
    if (!force && _recommendedArtists.isNotEmpty) {
      _applySelectedCollection();
      return;
    }

    final revision = ++_recommendationRevision;
    isLoadingRecommended.value = true;
    if (selectedCollection.value == LibraryArtistCollection.recommended) {
      libraryArtists.clear();
    }
    try {
      final favorites = SqliteStore.box('LIBFAV').values.whereType<Map>();
      final recommendations = <String, Artist>{};
      final excludedIds = {
        ..._tasteArtists.map((artist) => artist.browseId),
        ..._followedArtists.map((artist) => artist.browseId),
      };
      final excludedNames = {
        ..._tasteArtists.map((artist) => artist.name.toLowerCase()),
        ..._followedArtists.map((artist) => artist.name.toLowerCase()),
      };
      const unsupported = {'ia', 'ga', 'fj', 'eo'};
      final currentLanguage =
          Get.find<SettingsScreenController>().currentAppLanguageCode.value;
      final lang =
          unsupported.contains(currentLanguage) ? 'en' : currentLanguage;

      for (final rawSong in favorites.take(4)) {
        final song = Map<dynamic, dynamic>.from(rawSong);
        final songId = (song['videoId'] ?? song['id'])?.toString();
        if (songId == null || songId.isEmpty) continue;
        final sections =
            await _musicServices.getContentRelatedToSong(songId, lang);
        for (final section in sections) {
          final contents = section['contents'];
          if (contents is! List) continue;
          for (final artist in contents.whereType<Artist>()) {
            if (artist.browseId.isEmpty ||
                excludedIds.contains(artist.browseId) ||
                excludedNames.contains(artist.name.toLowerCase())) {
              continue;
            }
            recommendations[artist.browseId] = artist;
          }
        }
      }

      if (recommendations.isEmpty) {
        for (final seed in _tasteArtists.take(3)) {
          final results =
              await _musicServices.search(seed.name, filter: 'artists');
          for (final value in results.values) {
            if (value is! List) continue;
            for (final artist in value.whereType<Artist>()) {
              if (artist.browseId.isEmpty ||
                  excludedIds.contains(artist.browseId) ||
                  excludedNames.contains(artist.name.toLowerCase())) {
                continue;
              }
              recommendations[artist.browseId] = artist;
            }
          }
        }
      }

      if (revision == _recommendationRevision) {
        _recommendedArtists
          ..clear()
          ..addAll(recommendations.values.take(30));
      }
    } catch (error, stack) {
      debugPrint('Error loading recommended artists: $error\n$stack');
    } finally {
      if (revision == _recommendationRevision) {
        isLoadingRecommended.value = false;
        _applySelectedCollection();
      }
    }
  }

  void _applySelectedCollection() {
    if (tempListContainer.isNotEmpty) return;
    libraryArtists.assignAll(switch (selectedCollection.value) {
      LibraryArtistCollection.tastes => _tasteArtists,
      LibraryArtistCollection.followed => _followedArtists,
      LibraryArtistCollection.recommended => _recommendedArtists,
    });
  }

  void onSort(SortType sortType, bool isAscending) {
    final artistList = libraryArtists.toList();
    sortArtist(artistList, sortType, isAscending);
    libraryArtists.value = artistList;
  }

  void onSearchStart(String? tag) {
    tempListContainer = libraryArtists.toList();
  }

  void onSearch(String value, String? tag) {
    libraryArtists.value = tempListContainer
        .where(
            (artist) => artist.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  void onSearchClose(String? tag) {
    libraryArtists.value = tempListContainer.toList();
    tempListContainer.clear();
  }

  @override
  void onClose() {
    _recommendationRefreshDebounce?.cancel();
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.onClose();
  }
}
