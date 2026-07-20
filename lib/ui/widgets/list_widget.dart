import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/utils/localization/l10n_extensions.dart';

import '/models/album.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/models/playling_from.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/navigator.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'image_widget.dart';
import 'song_list_tile.dart';
import 'songinfo_bottom_sheet.dart';

class ListWidget extends StatelessWidget with RemoveSongFromPlaylistMixin {
  const ListWidget(this.items, this.title, this.isCompleteList,
      {super.key,
      this.isPlaylistOrAlbum = false,
      this.isArtistSongs = false,
      this.playlist,
      this.album,
      this.artist,
      this.scrollController});
  final List<dynamic> items;
  final String title;
  final bool isCompleteList;
  final ScrollController? scrollController;

  /// Valid for songlist
  final bool isArtistSongs;
  final bool isPlaylistOrAlbum;
  final Playlist? playlist;
  final Album? album;
  final Artist? artist;

  @override
  Widget build(BuildContext context) {
    final normalizedTitle = title.toLowerCase();
    if (items.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            "${S.current.no} ${title.t}!",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    }

    final firstItem = items.first;
    if (firstItem is Artist) {
      return isCompleteList
          ? Expanded(child: listViewArtists(items, sc: scrollController))
          : SizedBox(
              height: items.length * 95.0,
              child: listViewArtists(items),
            );
    }
    if (firstItem is Album) {
      return listViewAlbums(items, sc: scrollController);
    }
    if (firstItem is Playlist) {
      return listViewPlaylists(items, sc: scrollController);
    }

    if (normalizedTitle == "videos" ||
        normalizedTitle.contains("songs") ||
        normalizedTitle == "episodes" ||
        normalizedTitle == "top result") {
      return isCompleteList
          ? Expanded(
              child: listViewSongVid(items,
                  isPlaylistOrAlbum: isPlaylistOrAlbum,
                  playlist: playlist,
                  album: album,
                  artist: artist,
                  sc: scrollController,
                  isArtistSongs: isArtistSongs))
          : SizedBox(
              height: items.length * 75.0,
              child: listViewSongVid(items),
            );
    } else if (normalizedTitle.contains("playlist")) {
      return listViewPlaylists(items, sc: scrollController);
    } else if (title == "Albums" || title == "Singles" || title == "Podcasts") {
      return listViewAlbums(items, sc: scrollController);
    } else if (title.contains('Artists') || title == "Profiles") {
      return isCompleteList
          ? Expanded(child: listViewArtists(items, sc: scrollController))
          : SizedBox(
              height: items.length * 95.0,
              child: listViewArtists(items),
            );
    }
    return const SizedBox.shrink();
  }

  Widget listViewSongVid(List<dynamic> items,
      {bool isPlaylistOrAlbum = false,
      Playlist? playlist,
      Album? album,
      Artist? artist,
      bool isArtistSongs = false,
      ScrollController? sc}) {
    final playerController = Get.find<PlayerController>();
    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: 200,
        top: 0,
      ),
      addRepaintBoundaries: false,
      addAutomaticKeepAlives: false,
      controller: sc,
      itemCount: items.length,
      physics: isCompleteList
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SongListTile(
        song: items[index] as MediaItem,
        onTap: () {
          isArtistSongs
              // if song is from artist then play from artist
              ? playerController.playPlayListSong(
                  List<MediaItem>.from(items), index,
                  playfrom: PlaylingFrom(
                      type: PlaylingFromType.ARTIST,
                      name: artist?.name ?? "........."))
              :
              // if playlist is not null then play from playlist else play from album
              playlist != null && album == null
                  ? playerController.playPlayListSong(
                      List<MediaItem>.from(items), index,
                      playfrom: PlaylingFrom(
                        type: PlaylingFromType.PLAYLIST,
                        name: playlist.title,
                      ))
                  : playerController.pushSongToQueue(items[index] as MediaItem);
        },
      ),
    );
  }

  Widget listViewPlaylists(List<dynamic> playlists, {ScrollController? sc}) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 210,
            top: 0,
          ),
          controller: sc,
          itemCount: playlists.length,
          itemExtent: 120,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => wideListTile(context,
              playlist: playlists[index],
              title: playlists[index].title,
              subtitle: playlists[index]?.description ?? "NA",
              subtitle2: "")),
    );
  }

  Widget listViewAlbums(List<dynamic> albums, {ScrollController? sc}) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 210,
            top: 0,
          ),
          controller: sc,
          itemCount: albums.length,
          itemExtent: 120,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            String artistName = "";
            try {
              for (dynamic items in (albums[index].artists).sublist(1)) {
                artistName = "${artistName + items['name']},";
              }
            // ignore: empty_catches
            } catch (e) {}
            artistName = artistName.length > 16
                ? artistName.substring(0, 16)
                : artistName;
            return wideListTile(context,
                album: albums[index],
                title: albums[index].title,
                subtitle: artistName,
                subtitle2: albums[index].artists.isEmpty
                    ? "${albums[index].year}"
                    : "${(albums[index].artists[0]['name'])} • ${albums[index].year}");
          }),
    );
  }

  Widget listViewArtists(List<dynamic> artists, {ScrollController? sc}) {
    if (isCompleteList) {
      return LayoutBuilder(builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        const itemWidth = 110.0;
        final isMobile = availableWidth < 600;
        final int columns = isMobile ? 3 : (availableWidth / itemWidth).floor();

        return GridView.builder(
          padding: const EdgeInsets.only(
            bottom: 200,
            top: 5,
          ),
          controller: sc,
          itemCount: artists.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
          ),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final artist = artists[index];
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Get.toNamed(ScreenNavigationSetup.artistScreen,
                    id: ScreenNavigationSetup.id, arguments: [false, artist]);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: ImageWidget(
                          size: 90,
                          artist: artist,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    artist.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                  if (artist.subscribers != null && artist.subscribers.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        artist.subscribers,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      });
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: 200,
        top: 5,
      ),
      controller: sc,
      itemCount: artists.length,
      itemExtent: 90,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
        onTap: () {
          Get.toNamed(ScreenNavigationSetup.artistScreen,
              id: ScreenNavigationSetup.id, arguments: [false, artists[index]]);
        },
        contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 5),
        leading: ImageWidget(
          size: 90,
          artist: artists[index],
        ),
        title: Text(
          artists[index].name,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          artists[index].subscribers,
          maxLines: 2,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }

  Widget wideListTile(BuildContext context,
      {dynamic album,
      dynamic playlist,
      required String title,
      required String subtitle,
      required String subtitle2}) {
    return InkWell(
      onTap: () {
        if (album != null) {
          Get.toNamed(ScreenNavigationSetup.albumScreen,
              id: ScreenNavigationSetup.id, arguments: (album, album.browseId));
        } else {
          Get.toNamed(ScreenNavigationSetup.playlistScreen,
              id: ScreenNavigationSetup.id,
              arguments: [playlist, playlist.playlistId]);
        }
      },
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Row(
            children: [
              ImageWidget(
                size: 100,
                album: album,
                playlist: playlist,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      subtitle2,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
