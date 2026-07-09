import 'package:flutter/gestures.dart' show kSecondaryMouseButton;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/quick_picks.dart';
import '../player/player_controller.dart';
import 'image_widget.dart';
import 'hover_card_wrapper.dart';
import 'songinfo_bottom_sheet.dart';
import '../../utils/l10n_extensions.dart';
import 'song_status_badges.dart';

class QuickPicksWidget extends StatelessWidget {
  const QuickPicksWidget(
      {super.key, required this.content, this.scrollController});
  final QuickPicks content;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find<PlayerController>();
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content.title.t,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )),
          const SizedBox(height: 10),
          Expanded(
            child: Scrollbar(
              thickness: GetPlatform.isDesktop ? null : 0,
              controller: scrollController,
              child: GridView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: content.songList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: .26 / 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (_, item) {
                    return Listener(
                      onPointerDown: (PointerDownEvent event) {
                        if (event.buttons == kSecondaryMouseButton) {
                          //show songinfobotomsheet
                          showModalBottomSheet(
                            constraints: const BoxConstraints(maxWidth: 500),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                            ),

                            isScrollControlled: true,
                            context: playerController
                                .homeScaffoldkey.currentState!.context,

                            builder: (context) => SongInfoBottomSheet(
                              content.songList[item],
                            ),
                          ).whenComplete(
                              () => Get.delete<SongInfoController>());
                        }
                      },
                      child: Obx(() {
                        final isPlaying = playerController.currentSong.value?.id == content.songList[item].id;
                        final cs = Theme.of(context).colorScheme;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isPlaying
                                ? cs.primaryContainer
                                : cs.surfaceContainerLow,
                          ),
                          child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              leading: SongStatusBadges(
                                songId: content.songList[item].id,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: isPlaying
                                        ? [
                                            BoxShadow(
                                              color: cs.primary.withValues(alpha: 0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: HoverCardWrapper(
                                    borderRadius: 8.0,
                                    onPlayTap: () {
                                      playerController.pushSongToQueue(content.songList[item]);
                                    },
                                    child: ImageWidget(
                                      song: content.songList[item],
                                      size: 55,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                content.songList[item].title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: isPlaying ? cs.primary : null,
                                  fontWeight: isPlaying ? FontWeight.w700 : FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                "${content.songList[item].artist}",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                          onTap: () {
                            playerController
                                .pushSongToQueue(content.songList[item]);
                          },
                          onLongPress: () {
                            showModalBottomSheet(
                              constraints: const BoxConstraints(maxWidth: 500),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                              ),

                              isScrollControlled: true,
                              context: playerController
                                  .homeScaffoldkey.currentState!.context,
                              //constraints: BoxConstraints(maxHeight:Get.height),

                              builder: (context) =>
                                  SongInfoBottomSheet(content.songList[item]),
                            ).whenComplete(
                                () => Get.delete<SongInfoController>());
                          },
                          trailing: (GetPlatform.isDesktop)
                              ? IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10.0)),
                                      ),

                                      isScrollControlled: true,
                                      context: playerController.homeScaffoldkey
                                          .currentState!.context,
                                      //constraints: BoxConstraints(maxHeight:Get.height),
                                      barrierColor:
                                          Colors.transparent.withAlpha(100),
                                      builder: (context) => SongInfoBottomSheet(
                                          content.songList[item]),
                                    ).whenComplete(
                                        () => Get.delete<SongInfoController>());
                                  },
                                  icon: const Icon(Icons.more_vert))
                              : null),
                        );
                      }),
                    );
                  }),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
