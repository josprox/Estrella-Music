import 'package:flutter/material.dart';

import 'package:harmonymusic/services/storage/sqlite_store.dart';

/// Wraps a child widget and overlays small download/like badge icons
/// that reactively update when the SqliteStore boxes change.
class SongStatusBadges extends StatelessWidget {
  final String songId;
  final Widget child;

  const SongStatusBadges({
    super.key,
    required this.songId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // SqliteStore boxes should already be open at this point
    final favBox = SqliteStore.box('LIBFAV');
    final dlBox = SqliteStore.box('SongDownloads');

    return ValueListenableBuilder(
      valueListenable: favBox.listenable(),
      builder: (context, _, __) {
        return ValueListenableBuilder(
          valueListenable: dlBox.listenable(),
          builder: (context, _, __) {
            final isLiked = favBox.containsKey(songId);
            final isDownloaded = dlBox.containsKey(songId);

            if (!isLiked && !isDownloaded) return child;

            return Stack(
              children: [
                child,
                // Badges bottom-right corner
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isDownloaded)
                        const _Badge(
                          icon: Icons.download_done_rounded,
                          color: Colors.greenAccent,
                        ),
                      if (isLiked)
                        const _Badge(
                          icon: Icons.favorite_rounded,
                          color: Colors.redAccent,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _Badge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(right: 1),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 10, color: color),
    );
  }
}
