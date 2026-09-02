import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:audio_service/audio_service.dart';
import '/ui/screens/Artists/artist_screen_controller.dart';
import '/ui/widgets/loader.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import '/ui/navigator.dart';
import '/models/media_item_builder.dart';
import 'package:estrella_music/ui/widgets/songinfo_bottom_sheet.dart';
import '/models/album.dart';
import '/models/playlist.dart';
import '/ui/widgets/image_widget.dart';
import 'package:estrella_music/utils/helpers/music_share_manager.dart';
import 'package:estrella_music/generated/l10n.dart';
import '/ui/widgets/song_status_badges.dart';
import '/ui/widgets/song_download_btn.dart';
import 'package:estrella_music/services/download/downloader.dart';
import 'package:estrella_music/services/sync/sync_service.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();
    final tag = key.hashCode.toString();
    final ArtistScreenController artistScreenController =
        Get.isRegistered<ArtistScreenController>(tag: tag)
            ? Get.find<ArtistScreenController>(tag: tag)
            : Get.put(ArtistScreenController(), tag: tag);

    // Always use the new Spotify-style screen
    return _SpotifyArtistScreen(
      ctrl: artistScreenController,
      tag: tag,
      playerController: playerController,
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Spotify-style Artist Screen
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _SpotifyArtistScreen extends StatelessWidget {
  final ArtistScreenController ctrl;
  final String tag;
  final PlayerController playerController;

  const _SpotifyArtistScreen({
    required this.ctrl,
    required this.tag,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.45;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() {
        if (ctrl.isArtistContentFetced.isFalse) {
          return const Center(child: LoadingIndicator());
        }

        // â”€â”€ Offline mode â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        if (ctrl.isOffline.isTrue) {
          return _OfflineArtistView(
            ctrl: ctrl,
            playerController: playerController,
            heroHeight: heroHeight,
          );
        }

        final data = ctrl.artistData;
        final artist = ctrl.artist_;
        final thumbnails = data['thumbnails'] as List?;
        final heroUrl = thumbnails != null && thumbnails.isNotEmpty
            ? thumbnails.last['url'] as String
            : '';
        final description = data['description'] as String?;
        final subscribers = artist.subscribers ?? '';

        if (size.width > 900) {
          return _buildDesktopLayout(
            context,
            size,
            data,
            artist,
            thumbnails,
            heroUrl,
            description,
            subscribers,
          );
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // â”€â”€ Hero image + gradient overlay â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  // Hero image
                  SizedBox(
                    height: heroHeight,
                    width: double.infinity,
                    child: heroUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: heroUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(26),
                              child: const Center(child: LoadingIndicator()),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(26),
                              child: Icon(Icons.person_rounded,
                                  size: 80,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(97)),
                            ),
                          )
                        : Container(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(26),
                            child: Icon(Icons.person_rounded,
                                size: 80,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(97)),
                          ),
                  ),

                  // Gradient fade to dark
                  Container(
                    height: heroHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.4, 0.75, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Theme.of(context).colorScheme.surface.withAlpha(150),
                          Theme.of(context).colorScheme.surface,
                        ],
                      ),
                    ),
                  ),

                  // Back button
                  SafeArea(
                    child: IconButton(
                      onPressed: () => Get.nestedKey(ScreenNavigationSetup.id)!
                          .currentState!
                          .pop(),
                      icon: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withAlpha(120),
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 18),
                      ),
                    ),
                  ),

                  // Artist Name and Meta
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          artist.name,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                            height: 1.1,
                          ),
                        ),
                        if (subscribers.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            '$subscribers ${S.current.subscribers}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(180),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        // Monthly listeners (Metrolist parity)
                        Obx(() {
                          final ml = ctrl.monthlyListeners.value;
                          if (ml == null || ml.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              ml,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(140),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // â”€â”€ Floating Action Row â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    // Play Button
                    FloatingActionButton(
                      elevation: 4,
                      shape: const CircleBorder(),
                      onPressed: () {
                        final songs = ctrl.artistData['Songs'];
                        if (songs != null) {
                          final allItems = (songs['content'] as List?) ?? [];
                          if (allItems.isNotEmpty) {
                            playerController.playPlayListSong(
                                List.from(allItems), 0);
                          }
                        }
                      },
                      child: const Icon(Icons.play_arrow_rounded, size: 32),
                    ),
                    const SizedBox(width: 12),
                    // Shuffle Button (Metrolist parity)
                    Obx(() {
                      final sId = ctrl.shuffleId.value;
                      if (sId == null) return const SizedBox.shrink();
                      return IconButton.filledTonal(
                        onPressed: () {
                          final songs = ctrl.artistData['Songs'];
                          final allItems = songs != null
                              ? (songs['content'] as List?) ?? []
                              : <dynamic>[];
                          if (allItems.isNotEmpty) {
                            final shuffled = List.from(allItems)..shuffle();
                            playerController.playPlayListSong(
                                List.from(shuffled), 0);
                          }
                        },
                        icon: const Icon(Icons.shuffle_rounded, size: 22),
                      );
                    }),
                    const SizedBox(width: 8),
                    // Follow Button
                    Obx(() {
                      final isAdded = ctrl.isAddedToLibrary.isTrue;
                      if (isAdded) {
                        return FilledButton.tonal(
                          onPressed: () =>
                              ctrl.addNremoveFromLibrary(add: false),
                          child: Text(
                            S.current.following.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5),
                          ),
                        );
                      }
                      return OutlinedButton(
                        onPressed: () => ctrl.addNremoveFromLibrary(add: true),
                        child: Text(
                          S.current.follow.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, letterSpacing: 0.5),
                        ),
                      );
                    }),
                    const Spacer(),
                    // Share
                    IconButton.filledTonal(
                      onPressed: () => MusicShareManager.shareArtist(
                          ctrl.artist_.browseId,
                          artistName: ctrl.artist_.name),
                      icon: const Icon(Icons.share_rounded, size: 20),
                    ),
                  ],
                ),
              ),
            ),

            // â”€â”€ About section â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            if (description != null && description.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          description,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(180),
                            fontSize: 14,
                            height: 1.5,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

            // â”€â”€ Liked Songs section â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Obx(() {
              if (ctrl.likedSongsOfArtist.isEmpty) {
                return const SliverToBoxAdapter();
              }
              final items = ctrl.likedSongsOfArtist.take(5).toList();
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.favorites,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.download_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(138),
                                    size: 20,
                                  ),
                                  tooltip: "Descargar todas las favoritas",
                                  onPressed: () {
                                    final downloader = Get.find<Downloader>();
                                    final songs = ctrl.likedSongsOfArtist
                                        .where((song) =>
                                            !SqliteStore.box("SongDownloads")
                                                .containsKey(song.id))
                                        .toList();
                                    final count = songs.length;
                                    if (songs.isNotEmpty) {
                                      downloader.download(null,
                                          songList: songs);
                                    }
                                    if (count > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Descargando $count canciones favoritas")),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Todas las favoritas ya están descargadas")),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => _showAllLikedSongs(context),
                                  child: Text(
                                    S.current.viewAll,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(138),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...items.asMap().entries.map((entry) {
                        return _TrackRow(
                          index: entry.key + 1,
                          item: entry.value,
                          ctrl: ctrl,
                          playerController: playerController,
                          isFromFavs: true,
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),

            // â”€â”€ Popular Tracks header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.popularTracks,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showAllPopularTracks(context),
                      child: Text(
                        S.current.viewAll,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(138),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // â”€â”€ Popular Tracks List â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Obx(() {
              final songs = ctrl.artistData['Songs'];
              if (songs == null) return const SliverToBoxAdapter();
              final items = (songs['content'] as List?)?.take(5).toList() ?? [];
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _TrackRow(
                    index: index + 1,
                    item: items[index],
                    ctrl: ctrl,
                    playerController: playerController,
                    isFromFavs: false,
                    customPlayList: (songs['content'] as List?) ?? [],
                  ),
                  childCount: items.length,
                ),
              );
            }),

            // â”€â”€ Albums â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Obx(() {
              final albums = ctrl.artistData['Albums'];
              if (albums == null) return const SliverToBoxAdapter();
              final items =
                  (albums['content'] as List?)?.take(10).toList() ?? [];
              if (items.isEmpty) return const SliverToBoxAdapter();

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.albums,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(240),
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showAllAlbums(context),
                              child: Text(
                                S.current.viewAll,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(138),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: _AlbumCard(item: items[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // â”€â”€ Singles â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            _buildHorizontalSection(context, ctrl, 'Singles'),

            // â”€â”€ Videos â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            _buildHorizontalSection(context, ctrl, 'Videos', isVideo: true),

            // â”€â”€ Podcasts â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            _buildHorizontalSection(context, ctrl, 'Podcasts'),

            // â”€â”€ Episodes â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Obx(() {
              final episodes = ctrl.artistData['Episodes'];
              if (episodes == null) return const SliverToBoxAdapter();
              final items =
                  (episodes['content'] as List?)?.take(5).toList() ?? [];
              if (items.isEmpty) return const SliverToBoxAdapter();

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Episodes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // View all episodes logic
                            },
                            child: Text(
                              S.current.viewAll,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(138),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...items.asMap().entries.map((entry) {
                        return _TrackRow(
                          index: entry.key + 1,
                          item: entry.value,
                          ctrl: ctrl,
                          playerController: playerController,
                          customPlayList: (episodes['content'] as List?) ?? [],
                        );
                      }),
                    ],
                  ),
                ),
              );
            }),

            // â”€â”€ Playlists â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            _buildHorizontalSection(context, ctrl, 'Playlists',
                isPlaylist: true),

            const SliverToBoxAdapter(child: SizedBox(height: 200)),
          ],
        );
      }),
    );
  }

  Widget _buildHorizontalSection(
      BuildContext context, ArtistScreenController ctrl, String sectionKey,
      {bool isVideo = false, bool isPlaylist = false}) {
    return Obx(() {
      final section = ctrl.artistData[sectionKey];
      if (section == null) return const SliverToBoxAdapter();
      final content = section['content'] as List?;
      if (content == null || content.isEmpty) {
        return const SliverToBoxAdapter();
      }
      final items = content.take(15).toList();
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sectionKey == 'Singles'
                          ? S.current.singles
                          : sectionKey == 'Videos'
                              ? S.current.videos
                              : sectionKey == 'Playlists'
                                  ? S.current.playlists
                                  : sectionKey == 'Albums'
                                      ? S.current.albums
                                      : sectionKey,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(240),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (sectionKey == 'Singles') {
                          _showAllSingles(context);
                        } else if (sectionKey == 'Videos') {
                          _showAllVideos(context);
                        } else {
                          // Fallback to list screen for other unknown sections
                          Get.toNamed(
                            ScreenNavigationSetup.artistContentListScreen,
                            id: ScreenNavigationSetup.id,
                            arguments: {
                              'browseEndpoint':
                                  Map<String, dynamic>.from(section as Map),
                              'title': (sectionKey == 'Singles'
                                  ? S.current.singles
                                  : sectionKey == 'Videos'
                                      ? S.current.videos
                                      : sectionKey == 'Playlists'
                                          ? S.current.playlists
                                          : sectionKey == 'Albums'
                                              ? S.current.albums
                                              : sectionKey),
                            },
                          );
                        }
                      },
                      child: Text(
                        S.current.viewAll,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(138),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _AlbumCard(
                          item: items[index],
                          isVideo: isVideo,
                          isPlaylist: isPlaylist),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showAllLikedSongs(BuildContext context) {
    _showAllContent(
      context,
      title: S.current.favorites,
      initialItems: List.from(ctrl.likedSongsOfArtist),
      isFromFavs: true,
    );
  }

  void _showAllPopularTracks(BuildContext context) {
    final songs = ctrl.artistData['Songs'];
    if (songs == null) return;
    final items = (songs['content'] as List?) ?? [];
    _showAllContent(
      context,
      title: S.current.popularTracks,
      initialItems: items,
      isFromFavs: false,
      category: 'Songs',
    );
  }

  void _showAllAlbums(BuildContext context) {
    final albums = ctrl.artistData['Albums'];
    if (albums == null) return;
    final items = (albums['content'] as List?) ?? [];
    _showAllContent(
      context,
      title: S.current.albums,
      initialItems: items,
      isFromFavs: false,
      category: 'Albums',
    );
  }

  void _showAllSingles(BuildContext context) {
    final singles = ctrl.artistData['Singles'];
    if (singles == null) return;
    final items = (singles['content'] as List?) ?? [];
    _showAllContent(
      context,
      title: S.current.singles,
      initialItems: items,
      isFromFavs: false,
      category: 'Singles',
    );
  }

  void _showAllVideos(BuildContext context) {
    final videos = ctrl.artistData['Videos'];
    if (videos == null) return;
    final items = (videos['content'] as List?) ?? [];
    _showAllContent(
      context,
      title: S.current.videos,
      initialItems: items,
      isFromFavs: false,
      category: 'Videos',
    );
  }

  void _showAllContent(BuildContext context,
      {required String title,
      required List initialItems,
      required bool isFromFavs,
      String? category}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ContentModal(
        title: title,
        initialItems: initialItems,
        ctrl: ctrl,
        playerController: playerController,
        isFromFavs: isFromFavs,
        category: category,
      ),
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context,
      Size size,
      Map<String, dynamic> data,
      dynamic artist,
      List? thumbnails,
      String heroUrl,
      String? description,
      String subscribers) {
    final accentColor = Theme.of(context).colorScheme.primary;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // â”€â”€ Desktop Header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        SliverToBoxAdapter(
          child: Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  accentColor.withAlpha(50),
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Stack(
              children: [
                // Back button
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () => Get.nestedKey(ScreenNavigationSetup.id)!
                        .currentState!
                        .pop(),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withAlpha(150),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 18),
                    ),
                  ),
                ),
                // Header Content
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Artist Avatar
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(80),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: heroUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: heroUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(26),
                                    child:
                                        const Center(child: LoadingIndicator()),
                                  ),
                                  errorWidget: (_, __, ___) => Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(26),
                                    child: const Icon(Icons.person_rounded,
                                        size: 60),
                                  ),
                                )
                              : Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(26),
                                  child: const Icon(Icons.person_rounded,
                                      size: 60),
                                ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      // Info on the right
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.verified_rounded,
                                    color: Colors.blue, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  "ARTISTA VERIFICADO",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withAlpha(180),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              artist.name,
                              style: const TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -2.0,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                if (subscribers.isNotEmpty) ...[
                                  Text(
                                    '$subscribers ${S.current.subscribers}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(120),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                                Obx(() {
                                  final ml = ctrl.monthlyListeners.value;
                                  if (ml == null || ml.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return Text(
                                    ml,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(180),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Action Row
                            Row(
                              children: [
                                // Play Button
                                GestureDetector(
                                  onTap: () {
                                    final songs = ctrl.artistData['Songs'];
                                    if (songs != null) {
                                      final allItems =
                                          (songs['content'] as List?) ?? [];
                                      if (allItems.isNotEmpty) {
                                        playerController.playPlayListSong(
                                            List.from(allItems), 0);
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.play_arrow_rounded,
                                            size: 24, color: Colors.white),
                                        const SizedBox(width: 8),
                                        Text(
                                          S.current.play,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Shuffle Button
                                Obx(() {
                                  final sId = ctrl.shuffleId.value;
                                  if (sId == null) {
                                    return const SizedBox.shrink();
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      final songs = ctrl.artistData['Songs'];
                                      final allItems = songs != null
                                          ? (songs['content'] as List?) ?? []
                                          : <dynamic>[];
                                      if (allItems.isNotEmpty) {
                                        final shuffled = List.from(allItems)
                                          ..shuffle();
                                        playerController.playPlayListSong(
                                            List.from(shuffled), 0);
                                      }
                                    },
                                    child: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withAlpha(20),
                                      ),
                                      child: Icon(
                                        Icons.shuffle_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 20,
                                      ),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 16),
                                // Subscribe/Library button
                                Obx(() {
                                  final isAdded = ctrl.isAddedToLibrary.value;
                                  return GestureDetector(
                                    onTap: () => ctrl.addNremoveFromLibrary(
                                        add: !isAdded),
                                    child: Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(60),
                                          width: 1.5,
                                        ),
                                        color: isAdded
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withAlpha(12)
                                            : Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isAdded
                                                ? Icons
                                                    .library_add_check_rounded
                                                : Icons.library_add_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            isAdded
                                                ? S.current.following
                                                : S.current.follow,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                                const SizedBox(width: 16),
                                // Share Button
                                GestureDetector(
                                  onTap: () {
                                    MusicShareManager.shareArtist(
                                      artist.browseId,
                                      artistName: artist.name,
                                    );
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(20),
                                    ),
                                    child: Icon(Icons.share_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withAlpha(153),
                                        size: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // â”€â”€ Main Content Grid/Columns â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          sliver: SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Popular Tracks (60% width)
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Popular Tracks Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.popularTracks,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _showAllPopularTracks(context),
                            child: Text(
                              S.current.viewAll,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(138),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Popular Tracks List
                      Obx(() {
                        final songs = ctrl.artistData['Songs'];
                        if (songs == null) return const SizedBox.shrink();
                        final items =
                            (songs['content'] as List?)?.take(8).toList() ??
                                []; // Show 8 on PC
                        return Column(
                          children: List.generate(items.length, (index) {
                            return _TrackRow(
                              index: index + 1,
                              item: items[index],
                              ctrl: ctrl,
                              playerController: playerController,
                              isFromFavs: false,
                              customPlayList: (songs['content'] as List?) ?? [],
                            );
                          }),
                        );
                      }),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
                // Right Column: Favorites + Biography (40% width)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Liked Songs Section
                      Obx(() {
                        if (ctrl.likedSongsOfArtist.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        final items = ctrl.likedSongsOfArtist.take(5).toList();
                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.current.favorites,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // Download All Favorites Button
                                      IconButton(
                                        icon:
                                            const Icon(Icons.download_rounded),
                                        tooltip: "Descargar favoritas",
                                        onPressed: () {
                                          final downloader =
                                              Get.find<Downloader>();
                                          final songs = ctrl.likedSongsOfArtist
                                              .where((song) => !SqliteStore.box(
                                                      "SongDownloads")
                                                  .containsKey(song.id))
                                              .toList();
                                          final count = songs.length;
                                          if (songs.isNotEmpty) {
                                            downloader.download(null,
                                                songList: songs);
                                          }
                                          if (count > 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Descargando $count canciones favoritas")),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Todas las favoritas ya están descargadas")),
                                            );
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () =>
                                            _showAllLikedSongs(context),
                                        child: Text(
                                          S.current.viewAll,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withAlpha(138),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: List.generate(items.length, (index) {
                                  return _TrackRow(
                                    index: index + 1,
                                    item: items[index],
                                    ctrl: ctrl,
                                    playerController: playerController,
                                    isFromFavs: true,
                                    customPlayList: ctrl.likedSongsOfArtist,
                                  );
                                }),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 32),
                      // Biography Section
                      if (description != null && description.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.about,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                description,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withAlpha(180),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // â”€â”€ Horizontal sections for Albums, Singles, Videos, Playlists, etc. â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Albums
              Obx(() {
                final albums = ctrl.artistData['Albums'];
                if (albums == null) return const SizedBox.shrink();
                final items =
                    (albums['content'] as List?)?.take(12).toList() ?? [];
                if (items.isEmpty) return const SizedBox.shrink();
                return _buildDesktopHorizontalSection(
                    context, ctrl, S.current.albums, items, 'Albums');
              }),
              // Singles
              Obx(() {
                final singles = ctrl.artistData['Singles'];
                if (singles == null) return const SizedBox.shrink();
                final items =
                    (singles['content'] as List?)?.take(12).toList() ?? [];
                if (items.isEmpty) return const SizedBox.shrink();
                return _buildDesktopHorizontalSection(
                    context, ctrl, S.current.singles, items, 'Singles');
              }),
              // Videos
              Obx(() {
                final videos = ctrl.artistData['Videos'];
                if (videos == null) return const SizedBox.shrink();
                final items =
                    (videos['content'] as List?)?.take(12).toList() ?? [];
                if (items.isEmpty) return const SizedBox.shrink();
                return _buildDesktopHorizontalSection(
                    context, ctrl, S.current.videos, items, 'Videos',
                    isVideo: true);
              }),
              // Playlists
              Obx(() {
                final playlists = ctrl.artistData['Playlists'];
                if (playlists == null) return const SizedBox.shrink();
                final items =
                    (playlists['content'] as List?)?.take(12).toList() ?? [];
                if (items.isEmpty) return const SizedBox.shrink();
                return _buildDesktopHorizontalSection(
                    context, ctrl, S.current.playlists, items, 'Playlists',
                    isPlaylist: true);
              }),
              const SizedBox(height: 120),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHorizontalSection(BuildContext context,
      ArtistScreenController ctrl, String title, List items, String sectionKey,
      {bool isVideo = false, bool isPlaylist = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (sectionKey == 'Singles') {
                    _showAllSingles(context);
                  } else if (sectionKey == 'Videos') {
                    _showAllVideos(context);
                  } else {
                    Get.toNamed(
                      ScreenNavigationSetup.artistContentListScreen,
                      id: ScreenNavigationSetup.id,
                      arguments: {
                        'browseEndpoint': Map<String, dynamic>.from(
                            ctrl.artistData[sectionKey] as Map),
                        'title': title,
                      },
                    );
                  }
                },
                child: Text(
                  S.current.viewAll,
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(138),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: _AlbumCard(
                    item: items[index],
                    isVideo: isVideo,
                    isPlaylist: isPlaylist,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Track row widget
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _TrackRow extends StatelessWidget {
  final int index;
  final dynamic item;
  final ArtistScreenController ctrl;
  final PlayerController playerController;
  final bool isFromFavs;
  final List? customPlayList;

  const _TrackRow({
    required this.index,
    required this.item,
    required this.ctrl,
    required this.playerController,
    this.isFromFavs = false,
    this.customPlayList,
  });

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

  @override
  Widget build(BuildContext context) {
    final song = (item is MediaItem) ? item : MediaItemBuilder.fromJson(item);
    final title = song.title;
    final artist = song.artist ?? ctrl.artist_.name;
    final songId = song.id;

    return InkWell(
      onTap: () {
        if (customPlayList != null) {
          final playlist = customPlayList!.map((e) {
            if (e is MediaItem) return e;
            return MediaItemBuilder.fromJson(e);
          }).toList();
          if (index - 1 >= 0 && index - 1 < playlist.length) {
            playerController.playPlayListSong(playlist, index - 1);
          }
        } else if (isFromFavs) {
          final playlist = List<MediaItem>.from(ctrl.likedSongsOfArtist);
          if (index - 1 >= 0 && index - 1 < playlist.length) {
            playerController.playPlayListSong(playlist, index - 1);
          }
        } else {
          final songs = ctrl.artistData['Songs'];
          if (songs == null) return;
          final allItems = (songs['content'] as List?) ?? [];
          final playlist = allItems.map((e) {
            if (e is MediaItem) return e;
            return MediaItemBuilder.fromJson(e);
          }).toList();
          if (index - 1 >= 0 && index - 1 < playlist.length) {
            playerController.playPlayListSong(playlist, index - 1);
          }
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Obx(() {
        final isPlaying = playerController.currentSong.value?.id == songId;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isPlaying
                ? Theme.of(context).colorScheme.primary.withAlpha(25)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: isPlaying
                    ? Icon(
                        Icons.equalizer_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 18,
                      )
                    : Text(
                        '$index',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(97),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(width: 12),
              SongStatusBadges(
                songId: songId,
                child: ImageWidget(
                  song: song,
                  size: 48,
                ),
              ),
              const SizedBox(width: 12),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(138),
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
                  final isLiked = box.containsKey(songId);
                  return IconButton(
                    onPressed: () => toggleLike(item),
                    icon: Icon(
                      isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isLiked
                          ? Colors.red
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(97),
                      size: 20,
                    ),
                  );
                },
              ),
              // Download button / status icon
              SongDownloadButton(song_: song),
              // More icon
              IconButton(
                onPressed: () {
                  final song = (item is MediaItem)
                      ? item
                      : MediaItemBuilder.fromJson(item);
                  Get.bottomSheet(
                    SongInfoBottomSheet(song),
                    isScrollControlled: true,
                  );
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(97),
                  size: 20,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Content Modal for "Show All"
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _ContentModal extends StatefulWidget {
  final String title;
  final List initialItems;
  final ArtistScreenController ctrl;
  final PlayerController playerController;
  final bool isFromFavs;
  final String? category;

  const _ContentModal({
    required this.title,
    required this.initialItems,
    required this.ctrl,
    required this.playerController,
    required this.isFromFavs,
    this.category,
  });

  @override
  State<_ContentModal> createState() => _ContentModalState();
}

class _ContentModalState extends State<_ContentModal> {
  final TextEditingController _searchController = TextEditingController();
  List _allItems = [];
  List _filteredItems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _allItems = widget.initialItems;
    _filteredItems = widget.initialItems;

    // If not from favs and we have a category, try to fetch full content
    if (!widget.isFromFavs && widget.category != null) {
      _fetchFullContent();
    }
  }

  Future<void> _fetchFullContent() async {
    setState(() => _isLoading = true);
    try {
      final fullList = await widget.ctrl.fetchCategoryContent(widget.category!);
      if (fullList.isNotEmpty) {
        setState(() {
          _allItems = fullList;
          _filter(_searchController.text);
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _filter(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems.where((item) {
          final title = (item is MediaItem)
              ? item.title
              : (item is Album)
                  ? item.title
                  : (item['title'] as String? ?? '');
          return title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(32),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Title & Loading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: S.current.search,
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List
          Expanded(
            child: _filteredItems.isEmpty && !_isLoading
                ? const Center(child: Text("No se encontraron resultados"))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      if (item is MediaItem ||
                          (item is Map && item.containsKey('videoId'))) {
                        return _TrackRow(
                          index: index + 1,
                          item: item,
                          ctrl: widget.ctrl,
                          playerController: widget.playerController,
                          isFromFavs: widget.isFromFavs,
                          customPlayList: _filteredItems,
                        );
                      } else {
                        // For Albums/Videos in the modal
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 4),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ImageWidget(
                              song: (item is MediaItem) ? item : null,
                              album: (item is Album) ? item : null,
                              size: 50,
                            ),
                          ),
                          title: Text(
                            (item is Album)
                                ? item.title
                                : (item['title'] as String? ?? ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            (item is Album)
                                ? (item.year ?? '')
                                : (item['year'] as String? ?? ''),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(138),
                                fontSize: 12),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            if (item is Map && item.containsKey('videoId')) {
                              // It's a video
                              widget.playerController.startRadio(null,
                                  playlistid: 'RDAMVM${item['videoId']}');
                            } else {
                              final browseId = (item is Album)
                                  ? item.browseId
                                  : (item['browseId'] as String? ?? '');
                              Get.toNamed(
                                ScreenNavigationSetup.albumScreen,
                                id: ScreenNavigationSetup.id,
                                arguments: (
                                  item is Album ? item : null,
                                  browseId
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Album card
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _AlbumCard extends StatelessWidget {
  final dynamic item;
  final bool isVideo;
  final bool isPlaylist;
  const _AlbumCard(
      {required this.item, this.isVideo = false, this.isPlaylist = false});

  @override
  Widget build(BuildContext context) {
    final title = item is MediaItem
        ? item.title
        : item is Album
            ? item.title
            : item is Playlist
                ? item.title
                : (item is Map ? item['title'] as String? : null) ?? '';
    final year = item is MediaItem
        ? (item.extras?['year']?.toString() ?? '')
        : item is Album
            ? (item.year ?? '')
            : '';
    final type = item is MediaItem
        ? (item.extras?['description']?.toString() ??
            (isVideo
                ? S.current.video
                : isPlaylist
                    ? S.current.playlist
                    : S.current.album))
        : item is Album
            ? (item.description ??
                (item.isPodcast ? 'Podcast' : S.current.album))
            : item is Playlist
                ? (item.description ?? S.current.playlist)
                : (isVideo
                    ? S.current.video
                    : isPlaylist
                        ? S.current.playlist
                        : S.current.album);

    return InkWell(
      onTap: () {
        if (isVideo) {
          final pCtrl = Get.find<PlayerController>();
          final videoId = item is MediaItem
              ? item.id
              : item is Map
                  ? item['videoId'] as String?
                  : null;
          if (videoId != null) {
            pCtrl.startRadio(null, playlistid: 'RDAMVM$videoId');
          }
        } else if (isPlaylist) {
          final playlist = item is Playlist
              ? item
              : item is Map
                  ? Playlist.fromJson(item)
                  : Playlist(
                      title: title,
                      playlistId: item?.playlistId ?? item?.browseId ?? '',
                      thumbnailUrl: item?.thumbnailUrl ?? '');
          Get.toNamed(
            ScreenNavigationSetup.playlistScreen,
            id: ScreenNavigationSetup.id,
            arguments: [playlist, playlist.playlistId],
          );
        } else {
          final album = item is Album
              ? item
              : item is Map
                  ? Album.fromJson(item)
                  : Album(
                      title: title,
                      browseId: item?.browseId ?? '',
                      artists: item?.artists ?? const [],
                      thumbnailUrl: item?.thumbnailUrl ?? '');
          Get.toNamed(
            ScreenNavigationSetup.albumScreen,
            id: ScreenNavigationSetup.id,
            arguments: (album, album.browseId),
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140, // Fixed width for horizontal list items
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(15)),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ImageWidget(
                song: (item is MediaItem)
                    ? item
                    : (isVideo ? MediaItemBuilder.fromJson(item) : null),
                album: (item is Album)
                    ? item
                    : (!isVideo && !isPlaylist && item is! MediaItem
                        ? (item is Map
                            ? Album.fromJson(item)
                            : Album(
                                title: item.title ?? '',
                                browseId: item.browseId ?? '',
                                artists: item.artists ?? const [],
                                thumbnailUrl: item.thumbnailUrl ?? ''))
                        : null),
                playlist: (isPlaylist && item is! MediaItem)
                    ? (item is Map
                        ? Playlist.fromJson(item)
                        : Playlist(
                            title: item.title ?? '',
                            playlistId: item.playlistId ?? item.browseId ?? '',
                            thumbnailUrl: item.thumbnailUrl ?? ''))
                    : null,
                size: 140,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '$type${year.isNotEmpty ? ' · $year' : ''}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(138),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// AboutArtist â€” kept for backward compatibility (used in ArtistScreenBN)
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class AboutArtist extends StatelessWidget {
  const AboutArtist({
    super.key,
    required this.artistScreenController,
    this.padding = const EdgeInsets.only(bottom: 90, top: 70),
  });
  final EdgeInsetsGeometry padding;
  final ArtistScreenController artistScreenController;

  @override
  Widget build(BuildContext context) {
    final artistData = artistScreenController.artistData;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: padding,
          child: artistScreenController.isArtistContentFetced.value
              ? Column(
                  children: [
                    ImageWidget(
                      size: 200,
                      artist: artistScreenController.artist_,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      artistScreenController.artist_.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (artistData['description'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          '"${artistData["description"]}"',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Offline Artist View
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _OfflineArtistView extends StatelessWidget {
  final ArtistScreenController ctrl;
  final PlayerController playerController;
  final double heroHeight;

  const _OfflineArtistView({
    required this.ctrl,
    required this.playerController,
    required this.heroHeight,
  });

  @override
  Widget build(BuildContext context) {
    final artist = ctrl.artist_;
    final thumbnailUrl = artist.thumbnailUrl;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // â”€â”€ Hero image â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        SliverToBoxAdapter(
          child: Stack(
            children: [
              SizedBox(
                height: heroHeight,
                width: double.infinity,
                child: thumbnailUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: thumbnailUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(26),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(26),
                          child: Icon(Icons.person_rounded,
                              size: 80,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(97)),
                        ),
                      )
                    : Container(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(26),
                        child: Icon(Icons.person_rounded,
                            size: 80,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(97)),
                      ),
              ),
              // Gradient fade
              Container(
                height: heroHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.4, 0.75, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).colorScheme.surface.withAlpha(150),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
              ),
              // Back button
              SafeArea(
                child: IconButton(
                  onPressed: () => Get.nestedKey(ScreenNavigationSetup.id)!
                      .currentState!
                      .pop(),
                  icon: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Theme.of(context).colorScheme.surface.withAlpha(120),
                    ),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 18),
                  ),
                ),
              ),
              // Artist name + offline chip
              Positioned(
                bottom: 24,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist.name,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Chip(
                      label: Text(
                        'Sin conexión',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      avatar: Icon(Icons.wifi_off_rounded, size: 14),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // â”€â”€ Downloaded songs header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              'Canciones descargadas',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        // â”€â”€ Downloaded songs list â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        Obx(() {
          if (ctrl.offlineDownloadedSongs.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.music_off_rounded,
                        size: 56,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(60),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No hay canciones descargadas de este artista',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(120),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final song = ctrl.offlineDownloadedSongs[index];
                return _TrackRow(
                  index: index + 1,
                  item: song,
                  ctrl: ctrl,
                  playerController: playerController,
                  isFromFavs: false,
                  customPlayList: ctrl.offlineDownloadedSongs,
                );
              },
              childCount: ctrl.offlineDownloadedSongs.length,
            ),
          );
        }),

        const SliverToBoxAdapter(child: SizedBox(height: 200)),
      ],
    );
  }
}
