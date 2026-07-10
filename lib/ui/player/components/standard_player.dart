import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/utils/helpers/ionicons.dart';
import 'package:harmonymusic/ui/widgets/custom_marquee.dart';
import 'package:audio_service/audio_service.dart';
import 'package:harmonymusic/utils/helpers/youtube_share_manager.dart';
import 'package:harmonymusic/ui/widgets/up_next_queue.dart';

import '/ui/player/components/animated_play_button.dart';
import '/ui/player/components/backgroud_image.dart';
import '/ui/player/components/lyrics_widget.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/services/social/colistening_service.dart';
import 'full_lyrics_page.dart';
import '/ui/widgets/image_widget.dart';
import 'package:harmonymusic/ui/widgets/songinfo_bottom_sheet.dart';
import '/ui/navigator.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';

class StandardPlayer extends StatelessWidget {
  final ScrollController? mainScrollController;
  const StandardPlayer({super.key, this.mainScrollController});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PlayerController>();

    return Obx(() {
      final song = ctrl.currentSong.value;
      if (song == null) return const SizedBox.shrink();
      return _StandardPlayerContent(
        song: song,
        ctrl: ctrl,
        mainScrollController: mainScrollController,
      );
    });
  }
}

// ── Stateless content widget — receives explicit song & ctrl ─────────────────
class _StandardPlayerContent extends StatelessWidget {
  final MediaItem song;
  final PlayerController ctrl;
  final ScrollController? mainScrollController;

  const _StandardPlayerContent({
    required this.song,
    required this.ctrl,
    this.mainScrollController,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final botPad = MediaQuery.of(context).padding.bottom;
    final artSize = (size.width * 0.82).clamp(240.0, 400.0);
    final isWide = size.width > 800;

    return Obx(
      () => Opacity(
        opacity: ctrl.panelPosition.value.clamp(0.0, 1.0),
        child: Stack(
          children: [
            // ── Background: blurred album art ──────────────────────────────
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: BackgroudImage(
                  key: ValueKey('${song.id}_bg'),
                  cacheHeight: 600,
                ),
              ),
            ),
            // ── Gradient overlay ───────────────────────────────────────────
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.4, 1.0],
                      colors: [
                        colorScheme.surface.withValues(alpha: 0.25),
                        colorScheme.surface.withValues(alpha: 0.70),
                        colorScheme.surface.withValues(alpha: 0.97),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Main Content ─────────────────────────────────────────
            SafeArea(
              child: isWide
                  ? _buildWideLayout(context, size, colorScheme, textTheme)
                  : _buildMobileLayout(
                      context, size, colorScheme, textTheme, botPad, artSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context,
      Size size,
      ColorScheme colorScheme,
      TextTheme textTheme,
      double botPad,
      double artSize) {
    return CustomScrollView(
      controller: mainScrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                _TopBar(
                    ctrl: ctrl, textTheme: textTheme, colorScheme: colorScheme),
                const SizedBox(height: 24),

                // Album art — centered
                Center(child: _AlbumArt(song: song, artSize: artSize)),
                const SizedBox(height: 36),

                // Song info + fav
                _SongInfo(
                    song: song,
                    ctrl: ctrl,
                    colorScheme: colorScheme,
                    textTheme: textTheme),
                const SizedBox(height: 28),

                // Progress bar
                _ProgressBar(
                    ctrl: ctrl, colorScheme: colorScheme, textTheme: textTheme),
                const SizedBox(height: 20),

                // Transport controls
                _TransportControls(ctrl: ctrl, colorScheme: colorScheme),
                const SizedBox(height: 36),

                // Secondary actions row
                _SecondaryActions(ctrl: ctrl, colorScheme: colorScheme),
                const SizedBox(height: 32),

                // Lyrics card
                _LyricsCard(
                    ctrl: ctrl, colorScheme: colorScheme, textTheme: textTheme),
                SizedBox(height: botPad + 64),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWideLayout(BuildContext context, Size size,
      ColorScheme colorScheme, TextTheme textTheme) {
    final double artSize = (size.height * 0.45).clamp(240.0, 360.0);
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left column: Album Art and details
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: _AlbumArt(song: song, artSize: artSize)),
                  const SizedBox(height: 24),
                  _SongInfo(
                      song: song,
                      ctrl: ctrl,
                      colorScheme: colorScheme,
                      textTheme: textTheme),
                  const SizedBox(height: 24),
                  _SecondaryActions(ctrl: ctrl, colorScheme: colorScheme),
                ],
              ),
            ),
            const SizedBox(width: 48),
            // Right column: Tabbed section for Lyrics / Queue, and Controls
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TabBar + Close Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        indicatorColor: colorScheme.primary,
                        labelColor: colorScheme.onSurface,
                        unselectedLabelColor: colorScheme.onSurfaceVariant,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(text: S.current.upNext),
                          Tab(text: S.current.lyrics),
                        ],
                      ),
                      // Collapse button
                      IconButton(
                        onPressed: ctrl.playerPanelController.close,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 30),
                        tooltip: S.current.back,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Tab content container
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        color: colorScheme.surfaceContainerHigh
                            .withValues(alpha: 0.4),
                        child: const TabBarView(
                          children: [
                            // Tab 1: Play Queue
                            UpNextQueue(
                              isQueueInSlidePanel: false,
                            ),
                            // Tab 2: Synced Lyrics
                            LyricsWidget(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              isFull: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Progress Bar
                  _ProgressBar(
                      ctrl: ctrl,
                      colorScheme: colorScheme,
                      textTheme: textTheme),
                  const SizedBox(height: 16),
                  // Transport controls
                  _TransportControls(ctrl: ctrl, colorScheme: colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final PlayerController ctrl;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  const _TopBar(
      {required this.ctrl, required this.textTheme, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Collapse handle
          _GlassIconButton(
            icon: Icons.keyboard_arrow_down_rounded,
            size: 28,
            onTap: ctrl.playerPanelController.close,
            colorScheme: colorScheme,
          ),
          const SizedBox(width: 12),

          // Playing-from info
          Expanded(
            child: Column(
              children: [
                Obx(() => Text(
                      ctrl.playinfrom.value.typeString.toUpperCase(),
                      style: textTheme.labelSmall?.copyWith(
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                        color:
                            colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                    )),
                const SizedBox(height: 2),
                Obx(() => Text(
                      ctrl.playinfrom.value.nameString,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    )),
              ],
            ),
          ),

          const SizedBox(width: 12),
          // Co-listening button
          _GlassIconButton(
            icon: Icons.group_rounded,
            size: 22,
            onTap: () => _openCoListeningLobby(context),
            colorScheme: colorScheme,
          ),
          const SizedBox(width: 12),
          // More options
          _GlassIconButton(
            icon: Icons.more_horiz_rounded,
            size: 24,
            onTap: () => _openSheet(context),
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  void _openCoListeningLobby(BuildContext context) {
    final colistening = Get.find<ColisteningService>();
    colistening.connect(); // Ensure connected

    final roomController = TextEditingController();

    Get.dialog(
      Obx(() => AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.group_rounded),
                SizedBox(width: 8),
                Text("Escuchar en grupo"),
              ],
            ),
            content: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (colistening.currentRoomCode.isEmpty) ...[
                    const Text(
                      "Comparte un código de sala para escuchar la misma canción al mismo tiempo con amigos.",
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_box_rounded),
                      label: const Text("Crear Sala"),
                      onPressed: () {
                        colistening.createRoom();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("O UNIRSE A UNA EXISTENTE",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: roomController,
                      decoration: const InputDecoration(
                        hintText: "Código de 6 dígitos",
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.login_rounded),
                      label: const Text("Unirse"),
                      onPressed: () {
                        final code = roomController.text.trim();
                        if (code.length == 6) {
                          colistening.joinRoom(code);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ] else ...[
                    Text(
                      colistening.isHost.isTrue
                          ? "Eres el HOST de la sala"
                          : "Te has unido a la sala",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        colistening.currentRoomCode.value,
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (colistening.isHost.isTrue)
                      Text(
                        "Miembros conectados: ${colistening.guests.length}",
                        style: const TextStyle(fontSize: 14),
                      )
                    else
                      const Text("Sincronizando música...",
                          style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.exit_to_app_rounded,
                          color: Colors.red),
                      label: const Text("Salir de la Sala",
                          style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        colistening.disconnect();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: Colors.red.withValues(alpha: 0.1),
                        elevation: 0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Cerrar"),
              ),
            ],
          )),
    );
  }

  void _openSheet(BuildContext context) {
    if (ctrl.currentSong.value == null) return;
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 500),
      isScrollControlled: true,
      context: context,
      builder: (_) =>
          SongInfoBottomSheet(ctrl.currentSong.value!, calledFromPlayer: true),
    ).whenComplete(() => Get.delete<SongInfoController>());
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _GlassIconButton({
    required this.icon,
    required this.size,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Icon(icon, size: size, color: colorScheme.onSurface),
      ),
    );
  }
}

class _AlbumArt extends StatelessWidget {
  final MediaItem song;
  final double artSize;
  const _AlbumArt({required this.song, required this.artSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: artSize,
      height: artSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 48,
            offset: const Offset(0, 24),
            spreadRadius: -8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: Hero(
          tag: 'player_art_${song.id}',
          child: ImageWidget(
            size: artSize,
            song: song,
            isPlayerArtImage: true,
          ),
        ),
      ),
    );
  }
}

class _SongInfo extends StatelessWidget {
  final MediaItem song;
  final PlayerController ctrl;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  const _SongInfo({
    required this.song,
    required this.ctrl,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    // Extract album browseId from extras (stored by MusicServices as 'album' map)
    final albumMap = song.extras?['album'] as Map?;
    final albumId = albumMap?['id'] as String?;
    // Artist ID: extras['artists'] is a list of {id, name} maps
    final artistsList = song.extras?['artists'] as List?;
    final firstArtist = artistsList != null && artistsList.isNotEmpty
        ? artistsList.first as Map?
        : null;
    final artistId = firstArtist?['id'] as String?;
    final artistName = song.artist ?? '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Song title â†’ navigate to album ──────────────────────
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: albumId != null && albumId.isNotEmpty
                    ? () {
                        ctrl.playerPanelController.close();
                        Get.toNamed(
                          ScreenNavigationSetup.albumScreen,
                          id: ScreenNavigationSetup.id,
                          arguments: (null, albumId),
                        );
                      }
                    : null,
                child: Marquee(
                  id: 'player_title_${song.id}',
                  child: Text(
                    song.title,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      color: colorScheme.onSurface,
                      decoration: albumId != null && albumId.isNotEmpty
                          ? TextDecoration.underline
                          : null,
                      decorationColor:
                          colorScheme.onSurface.withValues(alpha: 0.3),
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // ── Artist name â†’ navigate to artist ───────────────────
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: artistId != null && artistId.isNotEmpty
                    ? () {
                        ctrl.playerPanelController.close();
                        Get.toNamed(
                          ScreenNavigationSetup.artistScreen,
                          id: ScreenNavigationSetup.id,
                          arguments: [true, artistId],
                        );
                      }
                    : artistName.isNotEmpty
                        ? () {
                            ctrl.playerPanelController.close();
                            Get.toNamed(
                              ScreenNavigationSetup.artistScreen,
                              id: ScreenNavigationSetup.id,
                              arguments: [false, artistName],
                            );
                          }
                        : null,
                child: Text(
                  artistName.isEmpty ? 'Unknown Artist' : artistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    decoration:
                        artistName.isNotEmpty ? TextDecoration.underline : null,
                    decorationColor: colorScheme.primary.withValues(alpha: 0.4),
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => _GlassIconButton(
            icon: ctrl.isCurrentSongFav.isTrue
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: 22,
            onTap: ctrl.toggleFavourite,
            colorScheme: ctrl.isCurrentSongFav.isTrue
                ? colorScheme.copyWith(
                    onSurface: Colors.redAccent,
                    surfaceContainerHigh:
                        Colors.redAccent.withValues(alpha: 0.15),
                  )
                : colorScheme,
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final PlayerController ctrl;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  const _ProgressBar(
      {required this.ctrl, required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return GetX<PlayerController>(
      builder: (c) => ProgressBar(
        progress: c.progressBarStatus.value.current,
        total: c.progressBarStatus.value.total,
        buffered: c.progressBarStatus.value.buffered,
        onSeek: c.seek,
        barHeight: 5,
        baseBarColor: colorScheme.onSurface.withValues(alpha: 0.1),
        bufferedBarColor: colorScheme.onSurface.withValues(alpha: 0.2),
        progressBarColor: colorScheme.primary,
        thumbColor: colorScheme.primary,
        thumbRadius: 7,
        thumbGlowRadius: 18,
        thumbGlowColor: colorScheme.primary.withValues(alpha: 0.25),
        timeLabelTextStyle: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
        timeLabelPadding: 12,
      ),
    );
  }
}

class _TransportControls extends StatelessWidget {
  final PlayerController ctrl;
  final ColorScheme colorScheme;
  const _TransportControls({required this.ctrl, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Shuffle
          Obx(() => IconButton(
                onPressed: ctrl.toggleShuffleMode,
                icon: Icon(
                  Ionicons.shuffle,
                  color: ctrl.isShuffleModeEnabled.isTrue
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  size: 22,
                ),
              )),

          // Prev
          IconButton(
            onPressed: ctrl.prev,
            icon: Icon(
              Icons.skip_previous_rounded,
              color: colorScheme.onSurface,
              size: 40,
            ),
          ),

          // Play / Pause — prominent M3 filled circle
          _PlayButton(ctrl: ctrl, colorScheme: colorScheme),

          // Next
          IconButton(
            onPressed: ctrl.next,
            icon: Icon(
              Icons.skip_next_rounded,
              color: colorScheme.onSurface,
              size: 40,
            ),
          ),

          // Loop
          Obx(() => IconButton(
                onPressed: ctrl.toggleLoopMode,
                icon: Icon(
                  Icons.repeat_rounded,
                  color: ctrl.isLoopModeEnabled.isTrue
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  size: 22,
                ),
              )),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final PlayerController ctrl;
  final ColorScheme colorScheme;
  const _PlayButton({required this.ctrl, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.45),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: AnimatedPlayButton(
        iconSize: 38,
        iconColor: colorScheme.onPrimary,
      ),
    );
  }
}

class _SecondaryActions extends StatelessWidget {
  final PlayerController ctrl;
  final ColorScheme colorScheme;
  const _SecondaryActions({required this.ctrl, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Add to playlist
        _SecondaryButton(
          icon: Icons.playlist_add_rounded,
          label: S.current.upNext,
          colorScheme: colorScheme,
          onTap: () => ctrl.queuePanelController.open(),
        ),
        // Cast / Share
        _SecondaryButton(
          icon: Icons.share_rounded,
          label: S.current.shareSong,
          colorScheme: colorScheme,
          onTap: () {
            final currentSong = ctrl.currentSong.value;
            if (currentSong != null) {
              YoutubeShareManager.shareSong(
                currentSong.id,
                title: currentSong.title,
                artist: currentSong.artist,
              );
            }
          },
        ),
        // Equalizer
        _SecondaryButton(
          icon: Icons.equalizer_rounded,
          label: S.current.equalizer,
          colorScheme: colorScheme,
          onTap: () {
            ctrl.openEqualizer();
          },
        ),
        // Speed & Pitch
        _SecondaryButton(
          icon: Icons.speed_rounded,
          label: S.current.playbackSpeed.split(' ').first,
          colorScheme: colorScheme,
          onTap: () {
            _openSpeedPitchDialog(context, colorScheme);
          },
        ),
      ],
    );
  }

  void _openSpeedPitchDialog(BuildContext context, ColorScheme colorScheme) {
    final settingsCtrl = Get.find<SettingsScreenController>();
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.85),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pull handle
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color:
                            colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Header Row with Reset Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        settingsCtrl.supportsPlaybackPitch
                            ? S.current.speedAndPitch
                            : S.current.playbackSpeed,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          settingsCtrl.setPlaybackSpeed(1.0);
                          if (settingsCtrl.supportsPlaybackPitch) {
                            settingsCtrl.setPlaybackPitch(1.0);
                          }
                        },
                        icon: Icon(Icons.refresh_rounded,
                            size: 18, color: colorScheme.primary),
                        label: Text(
                          S.current.reset,
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Playback Speed Slider
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.speed_rounded,
                                      color: colorScheme.primary, size: 22),
                                  const SizedBox(width: 12),
                                  Text(
                                    S.current.playbackSpeed,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${settingsCtrl.playbackSpeed.value.toStringAsFixed(2)}x',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 6,
                              activeTrackColor: colorScheme.primary,
                              inactiveTrackColor:
                                  colorScheme.primary.withValues(alpha: 0.15),
                              thumbColor: colorScheme.primary,
                              overlayColor:
                                  colorScheme.primary.withValues(alpha: 0.12),
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8),
                            ),
                            child: Slider(
                              value: settingsCtrl.playbackSpeed.value,
                              min: 0.5,
                              max: 2.0,
                              divisions: 30,
                              onChanged: settingsCtrl.setPlaybackSpeed,
                            ),
                          ),

                          // Quick speed presets
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children:
                                  [0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
                                final isSelected =
                                    (settingsCtrl.playbackSpeed.value - speed)
                                            .abs() <
                                        0.01;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text('${speed.toStringAsFixed(2)}x'),
                                    selected: isSelected,
                                    onSelected: (_) =>
                                        settingsCtrl.setPlaybackSpeed(speed),
                                    selectedColor: colorScheme.primary,
                                    labelStyle: textTheme.labelMedium?.copyWith(
                                      color: isSelected
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )),

                  if (settingsCtrl.supportsPlaybackPitch) ...[
                    const SizedBox(height: 28),
                    const Divider(height: 1),
                    const SizedBox(height: 28),

                    // Song Pitch Slider
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.music_note_rounded,
                                        color: colorScheme.primary, size: 22),
                                    const SizedBox(width: 12),
                                    Text(
                                      S.current.songPitch,
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  settingsCtrl.playbackPitch.value
                                      .toStringAsFixed(2),
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 6,
                                activeTrackColor: colorScheme.primary,
                                inactiveTrackColor:
                                    colorScheme.primary.withValues(alpha: 0.15),
                                thumbColor: colorScheme.primary,
                                overlayColor:
                                    colorScheme.primary.withValues(alpha: 0.12),
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: settingsCtrl.playbackPitch.value,
                                min: 0.5,
                                max: 2.0,
                                divisions: 30,
                                onChanged: settingsCtrl.setPlaybackPitch,
                              ),
                            ),

                            // Quick pitch presets
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children:
                                    [0.75, 1.0, 1.25, 1.5, 2.0].map((pitch) {
                                  final isSelected =
                                      (settingsCtrl.playbackPitch.value - pitch)
                                              .abs() <
                                          0.01;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ChoiceChip(
                                      label: Text(pitch.toStringAsFixed(2)),
                                      selected: isSelected,
                                      onSelected: (_) =>
                                          settingsCtrl.setPlaybackPitch(pitch),
                                      selectedColor: colorScheme.primary,
                                      labelStyle:
                                          textTheme.labelMedium?.copyWith(
                                        color: isSelected
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(icon, color: colorScheme.onSurface, size: 24),
        ),
      ),
    );
  }
}

class _LyricsCard extends StatelessWidget {
  final PlayerController ctrl;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  const _LyricsCard(
      {required this.ctrl, required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasLyrics = ctrl.lyrics['plainLyrics'] != null &&
          ctrl.lyrics['plainLyrics'] != 'NA';
      final hasSynced = ctrl.lyrics['synced'] != null;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.lyrics.toUpperCase(),
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                if (hasLyrics || hasSynced)
                  GestureDetector(
                    onTap: () => Get.to(
                      () => const FullLyricsPage(),
                      transition: Transition.downToUp,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.open_in_full_rounded,
                              size: 14, color: colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(
                            'Ver todo',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Content
            if (ctrl.isLyricsLoading.isTrue)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            else if (!hasLyrics && !hasSynced)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  S.current.lyricsNotAvailable,
                  style: textTheme.bodyMedium?.copyWith(
                    color:
                        colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              const SizedBox(
                height: 200,
                child: LyricsWidget(padding: EdgeInsets.zero),
              ),
          ],
        ),
      );
    });
  }
}
