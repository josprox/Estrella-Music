import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'image_widget.dart';

class PlaylistCoverWidget extends StatelessWidget {
  final Playlist playlist;
  final double size;

  const PlaylistCoverWidget({
    super.key,
    required this.playlist,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocal = !playlist.isCloudPlaylist ||
        playlist.playlistId == 'LIBRP' ||
        playlist.playlistId == 'LIBFAV' ||
        playlist.playlistId == 'SongsCache' ||
        playlist.playlistId == 'SongDownloads';

    if (!isLocal) {
      return ImageWidget(
        size: size,
        playlist: playlist,
      );
    }

    return FutureBuilder<List<String>>(
      future: _getPlaylistThumbnails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data!.length >= 4) {
          final urls = snapshot.data!;
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: size,
              height: size,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: _buildQuadImage(urls[0])),
                        Expanded(child: _buildQuadImage(urls[1])),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: _buildQuadImage(urls[2])),
                        Expanded(child: _buildQuadImage(urls[3])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // System/default playlists fallback: if they don't have 4 unique covers, show colored container with icon
        if (playlist.playlistId == 'LIBRP' ||
            playlist.playlistId == 'LIBFAV' ||
            playlist.playlistId == 'SongsCache' ||
            playlist.playlistId == 'SongDownloads') {
          return Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Icon(
                playlist.playlistId == 'LIBRP'
                    ? Icons.history
                    : playlist.playlistId == 'LIBFAV'
                        ? Icons.favorite
                        : playlist.playlistId == 'SongsCache'
                            ? Icons.flight
                            : Icons.download,
                color: Colors.white,
                size: size * 0.35,
              ),
            ),
          );
        }

        return ImageWidget(
          size: size,
          playlist: playlist,
        );
      },
    );
  }

  Widget _buildQuadImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey[800],
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[800],
        child: const Icon(Icons.music_note, color: Colors.white24),
      ),
    );
  }

  Future<List<String>> _getPlaylistThumbnails() async {
    try {
      final boxName = sanitizeBoxName(playlist.playlistId);
      final box = Hive.isBoxOpen(boxName)
          ? Hive.box(boxName)
          : await Hive.openBox(boxName);

      final List<String> urls = [];
      for (var item in box.values) {
        if (item is Map) {
          String? url;
          if (item['thumbnails'] != null &&
              item['thumbnails'] is List &&
              item['thumbnails'].isNotEmpty) {
            url = item['thumbnails'][0]['url'];
          } else if (item['artUri'] != null) {
            url = item['artUri'];
          }
          if (url != null && url.isNotEmpty && !urls.contains(url)) {
            urls.add(url);
            if (urls.length == 4) break;
          }
        }
      }
      return urls;
    } catch (_) {
      return [];
    }
  }
}
