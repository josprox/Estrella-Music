import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estrella_music/models/quick_picks.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/ui/widgets/image_widget.dart';

/// A compact, snap-to-card Home carousel.
///
/// It deliberately receives provider-neutral [QuickPicks], so a Home section
/// can use it without knowing whether its tracks were supplied by eMusic or a
/// future provider.
class SuggestedPlaylistCarousel extends StatelessWidget {
  const SuggestedPlaylistCarousel({super.key, required this.content});

  final QuickPicks content;

  @override
  Widget build(BuildContext context) {
    if (content.songList.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final player = Get.find<PlayerController>();

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              content.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 230,
            child: CarouselView.weighted(
              flexWeights: const [3, 2, 1],
              itemSnapping: true,
              // CarouselView owns the tap gesture while it is settling, so
              // dispatch playback here instead of relying only on InkWell.
              onTap: (index) => player.pushSongToQueue(content.songList[index]),
              children: [
                for (final song in content.songList)
                  _SuggestedTrackCard(song: song, player: player),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestedTrackCard extends StatelessWidget {
  const _SuggestedTrackCard({required this.song, required this.player});

  final MediaItem song;
  final PlayerController player;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => player.pushSongToQueue(song),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'suggested-${song.id}',
                // These cards are wider than regular list artwork. Do not use
                // ImageWidget's 140px list cache variant or the cover looks
                // soft while the selected card expands.
                child: ImageWidget(
                  song: song,
                  size: 240,
                  isPlayerArtImage: true,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: .84)
                    ],
                    stops: const [0.36, 1],
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 10,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                )),
                    Text(song.artist ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            )),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.play_circle_fill_rounded,
                    color: Colors.white.withValues(alpha: .92), size: 34),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
