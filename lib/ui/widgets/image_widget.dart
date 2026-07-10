import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import '/models/artist.dart';
import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/playlist.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.song,
    this.playlist,
    this.album,
    this.artist,
    required this.size,
    this.isPlayerArtImage = false,
  });
  final MediaItem? song;
  final Playlist? playlist;
  final Album? album;
  final bool isPlayerArtImage;
  final Artist? artist;
  final double size;

  @override
  Widget build(BuildContext context) {
    String imageUrl = song != null
        ? song!.artUri.toString()
        : playlist != null
            ? playlist!.thumbnailUrl
            : album != null
                ? album!.thumbnailUrl
                : artist != null
                    ? artist!.thumbnailUrl
                    : "";

    /// only valid for offline songs
    final bool offlineAvailable =
        song != null && (song?.extras?["url"] ?? "").contains("file");

    final String localThumbnailPath = song != null 
        ? "${Get.find<SettingsScreenController>().supportDirPath}/thumbnails/${song!.id}.png"
        : "";

    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: artist != null ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: artist != null ? null : BorderRadius.circular(5),
      ),
      child: (offlineAvailable && localThumbnailPath.isNotEmpty && File(localThumbnailPath).existsSync())
          ? Image.file(
              File(localThumbnailPath),
              height: size,
              width: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => CachedNetworkImage(
                height: size,
                width: size,
                memCacheHeight: (song != null && !isPlayerArtImage) ? 140 : null,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _buildErrorWidget(context),
                progressIndicatorBuilder: (context, url, progress) => _buildLoader(context),
              ),
            )
          : CachedNetworkImage(
              height: size,
              width: size,
              memCacheHeight: (song != null && !isPlayerArtImage) ? 140 : null,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => _buildErrorWidget(context),
              progressIndicatorBuilder: (context, url, progress) => _buildLoader(context),
            ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: artist != null ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: artist != null ? null : BorderRadius.circular(10),
        ),
        child: Image.asset(
            "assets/icons/${song != null ? "song" : artist != null ? "artist" : "album"}.png"));
  }

  Widget _buildLoader(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[300]!,
        enabled: true,
        direction: ShimmerDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            shape: artist != null ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: artist != null ? null : BorderRadius.circular(10),
            color: Colors.white54,
          ),
        ));
  }
}
