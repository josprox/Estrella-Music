import 'package:audio_service/audio_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/ui/screens/Search/search_result_screen_controller.dart';
import '/models/album.dart';
import '/models/artist.dart';
import '/models/playlist.dart';
import '/ui/widgets/content_list_widget_item.dart';
import '/ui/widgets/song_list_tile.dart';
import '/ui/widgets/image_widget.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';

import '/ui/navigator.dart';



class ResultWidget extends StatelessWidget {
  const ResultWidget({super.key, this.isv2Used = false});
  final bool isv2Used;

  @override
  Widget build(BuildContext context) {
    final SearchResultScreenController searchResScrController =
        Get.find<SearchResultScreenController>();
    return Obx(
      () => Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: CustomScrollView(
            controller: searchResScrController.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
               if (!isv2Used)
                 SliverToBoxAdapter(
                   child: Padding(
                     padding: const EdgeInsets.only(left: 16, bottom: 8, top: 16),
                     child: Text(
                        S.current.searchRes,
                        style: Theme.of(context).textTheme.titleLarge,
                     ),
                   ),
                 ),
               if (!isv2Used)
                 SliverToBoxAdapter(
                   child: Padding(
                     padding: const EdgeInsets.only(left: 16, bottom: 16),
                     child: Text(
                        "${S.current.for1} \"${searchResScrController.queryString.value}\"",
                        style: Theme.of(context).textTheme.titleMedium,
                     ),
                   ),
                 ),
               if (searchResScrController.isResultContentFetced.value)
                  ..._buildBloomeeSlivers(context, searchResScrController)
               else
                  const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
               const SliverPadding(padding: EdgeInsets.only(bottom: 200)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBloomeeSlivers(BuildContext context, SearchResultScreenController controller) {
    List<Widget> slivers = [];
    final playerController = Get.find<PlayerController>();

    for (dynamic item in controller.resultContent.entries) {
      final values = item.value is List ? item.value as List : [item.value];
      if (values.isEmpty) continue;
      
      final key = item.key;
      
      // Filter out non-category keys
      if (key == "searchEndpoint" || key == "params") continue;

      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
            child: Text(
              key,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ),
      );

      if (key == "Songs" || key == "Videos" || key == "Episodes" || key == "Top Result" || key == "Top result") {
        final mediaItems = values.whereType<MediaItem>().toList();
        if (mediaItems.isNotEmpty) {
           slivers.add(
             SliverPadding(
               padding: const EdgeInsets.only(bottom: 12),
               sliver: SliverList(
                 delegate: SliverChildBuilderDelegate(
                   (context, index) {
                     return Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                       child: SongListTile(
                         song: mediaItems[index],
                         onTap: () {
                           playerController.pushSongToQueue(mediaItems[index]);
                         },
                       ),
                     );
                   },
                   childCount: mediaItems.length,
                 ),
               ),
             ),
           );
        }
      } else if (key == "Albums" || key == "Podcasts") {
        final albums = values.whereType<Album>().toList();
        if (albums.isNotEmpty) {
           slivers.add(_buildResponsiveGrid(albums));
        }
      } else if (key == "Playlists" || key == "Featured playlists" || key == "Community playlists") {
        final playlists = values.whereType<Playlist>().toList();
        if (playlists.isNotEmpty) {
           slivers.add(_buildResponsiveGrid(playlists));
        }
      } else if (key.contains("Artist") || key == "Profiles") {
        final artists = values.whereType<Artist>().toList();
        if (artists.isNotEmpty) {
           slivers.add(
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 28,
                    alignment: WrapAlignment.start,
                    children: artists.map((a) => _buildArtistGridItem(context, a)).toList(),
                  ),
                ),
              )
           );
        }
      }
    }

    return slivers;
  }

  Widget _buildResponsiveGrid(List<dynamic> items) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Wrap(
          spacing: 20,
          runSpacing: 28,
          alignment: WrapAlignment.start,
          children: items.map((i) => ContentListItem(content: i)).toList(),
        ),
      ),
    );
  }

  Widget _buildArtistGridItem(BuildContext context, Artist artist) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
         Get.toNamed(ScreenNavigationSetup.artistScreen, id: ScreenNavigationSetup.id, arguments: [false, artist]);
      },
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            ClipOval(
              child: ImageWidget(
                size: 100,
                artist: artist,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              artist.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (artist.subscribers?.isNotEmpty == true)
              Text(
                artist.subscribers ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
          ],
        ),
      ),
    );
  }
}
