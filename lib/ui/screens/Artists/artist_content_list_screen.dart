import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import '/models/album.dart';
import '/models/media_item_builder.dart';
import '/models/playlist.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import '/ui/widgets/loader.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import '/ui/navigator.dart';

class ArtistContentListController extends GetxController {
  final musicServices = Get.find<MusicServices>();
  final items = <dynamic>[].obs;
  final isLoading = true.obs;
  final isMoreLoading = false.obs;
  String? additionalParams;
  late Map<String, dynamic> browseEndpoint;
  late String categoryTitle;
  late String categoryRaw;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    final dynamic args = Get.arguments;
    if (args is Map<String, dynamic>) {
      browseEndpoint = args['browseEndpoint'] ?? {};
      categoryTitle = args['title'] ?? '';
      categoryRaw = args['category'] ?? categoryTitle;
    } else {
      // Fallback or error handling if needed
      browseEndpoint = {};
      categoryTitle = '';
      categoryRaw = '';
    }

    _fetchInitialContent();
    
    scrollController.addListener(() {
      if (scrollController.hasClients && scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.8) {
        _fetchMoreContent();
      }
    });
    super.onInit();
  }

  Future<void> _fetchInitialContent() async {
    isLoading.value = true;
    try {
      final result = await musicServices.getArtistRealtedContent(browseEndpoint, categoryRaw);
      items.assignAll(result['results'] ?? []);
      additionalParams = result['additionalParams'];
    } catch (e) {
      debugPrint("Error fetching artist content: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchMoreContent() async {
    if (isMoreLoading.value || additionalParams == null || additionalParams == '&ctoken=null&continuation=null') return;
    
    isMoreLoading.value = true;
    try {
      final result = await musicServices.getArtistRealtedContent(
        browseEndpoint, 
        categoryRaw,
        additionalParams: additionalParams ?? ""
      );
      items.addAll(result['results'] ?? []);
      additionalParams = result['additionalParams'];
    } catch (e) {
      debugPrint("Error fetching more artist content: $e");
    } finally {
      isMoreLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class ArtistContentListScreen extends StatelessWidget {
  const ArtistContentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Map<String, dynamic>) {
      return const Scaffold(body: Center(child: Text("Error: Missing arguments")));
    }
    final tag = (args['category'] ?? args['title']) as String;

    final controller = Get.isRegistered<ArtistContentListController>(tag: tag)
        ? Get.find<ArtistContentListController>(tag: tag)
        : Get.put(ArtistContentListController(), tag: tag);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(controller.categoryTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface)),

        elevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            // Delete the tagged controller on pop so a new push re-fetches
            Get.delete<ArtistContentListController>(tag: tag);
            Get.nestedKey(ScreenNavigationSetup.id)!.currentState!.pop();
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }

        return ListView.builder(
          controller: controller.scrollController,
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: controller.items.length + (controller.isMoreLoading.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.items.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: LoadingIndicator()),
              );
            }

            final item = controller.items[index];
            return _getContentTile(context, item, index, controller.items);
          },
        );
      }),
    );
  }

  Widget _getContentTile(BuildContext context, dynamic item, int index, List<dynamic> allItems) {
    final playerController = Get.find<PlayerController>();
    final videoId = (item is MediaItem) ? item.id : (item?['videoId'] as String? ?? '');
    
    return Obx(() {
      final isPlaying = playerController.currentSong.value?.id == videoId;
      
      if (item is MediaItem || (item is Map && item.containsKey('videoId'))) {
        final title = (item is MediaItem) ? item.title : (item['title'] as String? ?? '');
        final artist = (item is MediaItem) ? item.artist : (item['artists']?.map((e) => e['name']).join(', ') ?? '');
        final thumbUrl = (item is MediaItem) ? item.artUri.toString() : (item['thumbnails']?[0]?['url'] ?? '');

        return InkWell(
          onTap: () {
            final mediaItems = allItems.where((e) => e is MediaItem || (e is Map && e.containsKey('videoId'))).map((e) {
              if (e is MediaItem) return e;
              return MediaItemBuilder.fromJson(e);
            }).toList();
            
            final targetIndex = mediaItems.indexWhere((m) => m.id == videoId);
            if (targetIndex != -1) {
              playerController.playPlayListSong(mediaItems, targetIndex);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isPlaying 
                  ? Theme.of(context).colorScheme.primary.withAlpha(25)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: isPlaying
                      ? Icon(Icons.equalizer_rounded, color: Theme.of(context).colorScheme.primary, size: 20)
                      : Text("${index + 1}", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(97))),
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: thumbUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(12),
                      child: const Icon(Icons.music_note_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        artist ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(138),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Like icon
                ValueListenableBuilder(
                  valueListenable: SqliteStore.box("LIBFAV").listenable(),
                  builder: (context, SqliteBox box, _) {
                    final isLiked = box.containsKey(videoId);
                    return IconButton(
                      onPressed: () => toggleLike(item),
                      icon: Icon(
                        isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isLiked ? Colors.red : Theme.of(context).colorScheme.onSurface.withAlpha(97),
                        size: 20,
                      ),
                    );
                  },
                ),
                // Download icon
                ValueListenableBuilder(
                  valueListenable: SqliteStore.box("SongDownloads").listenable(),
                  builder: (context, SqliteBox box, _) {
                    final isDownloaded = box.containsKey(videoId);
                    if (!isDownloaded) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      } else if (item is Playlist ||
          (item is Map && item.containsKey('playlistId'))) {
        final title = (item is Playlist)
            ? item.title
            : (item['title'] as String? ?? '');
        final subtitle = (item is Playlist)
            ? item.description
            : (item['description'] as String? ?? '');
        final thumbUrl = (item is Playlist)
            ? item.thumbnailUrl
            : (item['thumbnails']?[0]?['url'] ?? '');
        final playlistId = (item is Playlist)
            ? item.playlistId
            : ((item['playlistId'] as String?) ??
                (item['browseId'] as String?) ??
                '');

        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: thumbUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(subtitle ?? '', style: const TextStyle(fontSize: 12)),
          onTap: () {
            Get.toNamed(
              ScreenNavigationSetup.playlistScreen,
              id: ScreenNavigationSetup.id,
              arguments: [item is Playlist ? item : null, playlistId],
            );
          },
        );
      } else if (item is Album || (item is Map && item.containsKey('browseId'))) {
        final title = (item is Album) ? item.title : (item['title'] as String? ?? '');
        final year = (item is Album) ? item.year : (item['year'] as String? ?? '');
        final thumbUrl = (item is Album) ? item.thumbnailUrl : (item['thumbnails']?[0]?['url'] ?? '');
        final browseId = (item is Album) ? item.browseId : (item['browseId'] as String? ?? '');

        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: thumbUrl ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(year ?? '', style: const TextStyle(fontSize: 12)),
          onTap: () {
            Get.toNamed(
              ScreenNavigationSetup.albumScreen,
              id: ScreenNavigationSetup.id,
              arguments: (item is Album ? item : null, browseId),
            );
          },
        );
      }
      return const SizedBox.shrink();
    });
  }

  void toggleLike(dynamic item) async {
    final song = (item is MediaItem) ? item : MediaItemBuilder.fromJson(item);
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final box = await SqliteStore.openBox("LIBFAV");
      final wasFavorite = box.containsKey(song.id);
      final track = MediaItemBuilder.toJson(song);
      await syncService.recordFavoriteChange(
        song.id,
        deleted: wasFavorite,
        track: track,
      );
      if (wasFavorite) {
        await box.delete(song.id);
      } else {
        await box.put(song.id, track);
      }
    });
  }
}
