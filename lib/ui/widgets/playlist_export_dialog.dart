import 'package:flutter/material.dart';

import 'package:estrella_music/ui/screens/Playlist/playlist_screen_controller.dart';
import 'common_dialog_widget.dart';
import 'package:estrella_music/generated/l10n.dart';

class PlaylistExportDialog extends StatelessWidget {
  const PlaylistExportDialog({
    super.key,
    required this.controller,
    required this.parentContext,
  });

  final PlaylistScreenController controller;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: Text(
                S.current.exportPlaylist,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            _ExportButton(
              icon: Icons.save,
              title: S.current.exportPlaylistJson,
              subtitle: S.current.exportPlaylistJsonSubtitle,
              onTap: () {
                Navigator.of(context).pop();
                controller.exportPlaylistToJson(parentContext);
              },
            ),
            const SizedBox(height: 12),
            _ExportButton(
              icon: Icons.table_chart,
              title: S.current.exportPlaylistCsv,
              subtitle: S.current.exportPlaylistCsvSubtitle,
              onTap: () {
                Navigator.of(context).pop();
                controller.exportPlaylistToCsv(parentContext);
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  S.current.close,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).textTheme.titleMedium!.color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
