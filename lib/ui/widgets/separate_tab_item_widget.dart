import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/widgets/modification_list.dart';
import 'package:harmonymusic/utils/localization/l10n_extensions.dart';

import 'package:harmonymusic/ui/screens/Artists/artist_screen_controller.dart';
import 'list_widget.dart';
import 'loader.dart';
import 'sort_widget.dart';
import 'package:harmonymusic/generated/l10n.dart';

class SeparateTabItemWidget extends StatelessWidget {
  const SeparateTabItemWidget(
      {super.key,
      required this.items,
      required this.title,
      this.isCompleteList = true,
      this.hideTitle = false,
      this.topPadding = 0,
      this.scrollController,
      this.artistControllerTag});

  /// tag for accessing Artist controller inst, [artistControllerTag] only valid for Artist screen
  final String? artistControllerTag;
  final List<dynamic> items;
  final String title;
  final bool isCompleteList;
  final double topPadding;
  final bool hideTitle;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final artistController =
        Get.isRegistered<ArtistScreenController>(tag: artistControllerTag)
            ? Get.find<ArtistScreenController>(tag: artistControllerTag)
            : null;
    return Padding(
      padding: EdgeInsets.only(top: topPadding, left: 5),
      child: Column(
        children: [
          if (!hideTitle)
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.t,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          isCompleteList
              ? Obx(() => SortWidget(
                    tag: "${title}_$artistControllerTag",
                    screenController: artistController,
                    isAdditionalOperationRequired: artistController != null &&
                        (title == "Songs" || title == "Videos"),
                    isSearchFeatureRequired: artistController != null,
                    titleLeftPadding: 9,
                    itemCountTitle:
                        "${(artistController?.sepataredContent[title] != null ? artistController?.sepataredContent[title]['results'] : []).length} ${S.current.items}",
                    requiredSortTypes: buildSortTypeSet(
                        title == 'Albums' || title == "Singles" || title == "Podcasts",
                        title == "Songs" || title == "Videos" || title == "Episodes"),
                    onSort: (type, ascending) {
                      artistController?.onSort(type, ascending, title);
                    },
                    onSearch: artistController?.onSearch,
                    onSearchClose: artistController?.onSearchClose,
                    onSearchStart: artistController?.onSearchStart,
                    startAdditionalOperation:
                        artistController?.startAdditionalOperation,
                    selectAll: artistController?.selectAll,
                    performAdditionalOperation:
                        artistController?.performAdditionalOperation,
                    cancelAdditionalOperation:
                        artistController?.cancelAdditionalOperation,
                  ))
              : const SizedBox.shrink(),
          isCompleteList
              ? (artistController!.isArtistContentFetced.isTrue
                      ? Obx(() =>
                          (artistController.additionalOperationMode.value ==
                                  OperationMode.none
                              ? ListWidget(
                                  items,
                                  title,
                                  isCompleteList,
                                  isArtistSongs: true,
                                  artist: artistController.artist_,
                                  scrollController: scrollController,
                                )
                              : ModificationList(
                                  mode: artistController
                                      .additionalOperationMode.value,
                                  screenController: artistController,
                                )))
                      : const Expanded(
                          child: Center(child: LoadingIndicator())))
              : ListWidget(
                  items,
                  title,
                  isCompleteList,
                  scrollController: scrollController,
                ),
        ],
      ),
    );
  }
}
