import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/ui/screens/Search/search_result_screen_controller.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/ui/navigator.dart';
import '/ui/widgets/content_list_widget_item.dart';
import 'image_widget.dart';
import 'hover_card_wrapper.dart';
import '/ui/theme/app_spacing.dart';
import 'package:harmonymusic/generated/l10n.dart';

class ContentListWidget extends StatelessWidget {
  /// ContentListWidget renders a horizontal-scroll section of Albums or Playlists
  const ContentListWidget(
      {super.key,
      this.content,
      this.isHomeContent = true,
      this.scrollController});

  final dynamic content;
  final bool isHomeContent;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final isAlbumContent = content.runtimeType.toString() == 'AlbumContent';
    final isArtistContent = content.runtimeType.toString() == 'ArtistContent';
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section header ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(
                left: AppSpacing.sm,
                right: AppSpacing.sm,
                bottom: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    !isHomeContent && content.title.length > 14
                        ? '${content.title.substring(0, 14)}…'
                        : content.title,
                    style: tt.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: cs.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!isHomeContent)
                  TextButton(
                    onPressed: () {
                      final ctrl = Get.find<SearchResultScreenController>();
                      ctrl.applyFilter(content.title);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusPill),
                        side: BorderSide(
                          color: cs.primary.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      S.current.viewAll,
                      style: tt.labelMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Horizontal list ────────────────────────────────────────────────
          SizedBox(
            height: 212,
            child: Scrollbar(
              thickness: GetPlatform.isDesktop ? null : 0,
              controller: scrollController,
              child: ListView.separated(
                controller: scrollController,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.md),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                itemCount: isAlbumContent
                    ? content.albumList.length
                    : isArtistContent
                        ? content.content.length
                        : content.playlistList.length,
                itemBuilder: (_, index) {
                  if (isArtistContent) {
                    return _ArtistListItem(content: content.content[index]);
                  }
                  return isAlbumContent
                      ? ContentListItem(content: content.albumList[index])
                      : ContentListItem(content: content.playlistList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtistListItem extends StatelessWidget {
  const _ArtistListItem({required this.content});

  final Artist content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Get.toNamed(ScreenNavigationSetup.artistScreen,
            id: ScreenNavigationSetup.id, arguments: [false, content]);
      },
      child: SizedBox(
        width: 130,
        height: 194,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HoverCardWrapper(
              isCircle: true,
              child: ImageWidget(size: 120, artist: content),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              content.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if ((content.subscribers ?? '').isNotEmpty)
              Text(
                content.subscribers!,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
          ],
        ),
      ),
    );
  }
}
