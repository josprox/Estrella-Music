import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/ui/widgets/image_widget.dart';

enum SharedSongAction {
  play,
  enqueue,
  addToPlaylist,
}

class SharedSongActionSheet extends StatelessWidget {
  const SharedSongActionSheet({super.key, required this.song});

  final MediaItem song;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withAlpha(32),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                ImageWidget(song: song, size: 72),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (song.artist?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 4),
                        Text(
                          song.artist!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _ActionTile(
              icon: Icons.play_arrow_rounded,
              label: S.current.playNow,
              emphasized: true,
              onTap: () => Navigator.pop(context, SharedSongAction.play),
            ),
            const SizedBox(height: 8),
            _ActionTile(
              icon: Icons.queue_music_rounded,
              label: S.current.enqueueSong,
              onTap: () => Navigator.pop(context, SharedSongAction.enqueue),
            ),
            const SizedBox(height: 8),
            _ActionTile(
              icon: Icons.playlist_add_rounded,
              label: S.current.addToPlaylist,
              onTap: () =>
                  Navigator.pop(context, SharedSongAction.addToPlaylist),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.emphasized = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foreground =
        emphasized ? colorScheme.onPrimaryContainer : colorScheme.onSurface;

    return Material(
      color: emphasized
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerHighest.withAlpha(110),
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Row(
            children: [
              Icon(icon, color: foreground),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}
