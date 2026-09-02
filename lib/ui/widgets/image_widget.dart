import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:estrella_music/ui/screens/Settings/settings_screen_controller.dart';
import '/models/artist.dart';
import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/playlist.dart';

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

    final bool isFileUri = imageUrl.startsWith("file://") ||
        imageUrl.startsWith("/") ||
        (song?.artUri != null && song!.artUri!.isScheme("file"));

    String localFilePath = "";
    if (isFileUri) {
      if (song?.artUri != null && song!.artUri!.isScheme("file")) {
        try {
          localFilePath = song!.artUri!.toFilePath();
        } catch (_) {
          localFilePath = song!.artUri!.path;
        }
      } else if (imageUrl.startsWith("file://")) {
        try {
          localFilePath = Uri.parse(imageUrl).toFilePath();
        } catch (_) {
          localFilePath = imageUrl.replaceFirst(RegExp(r'^file://+'), '/');
        }
      } else if (imageUrl.startsWith("/")) {
        localFilePath = imageUrl;
      }
    }

    final String supportDir = Get.isRegistered<SettingsScreenController>()
        ? Get.find<SettingsScreenController>().supportDirPath
        : '';

    final String localThumbnailPath = song != null
        ? (supportDir.isNotEmpty
            ? "$supportDir/thumbnails/${song!.id}.png"
            : "")
        : album != null && album!.browseId.isNotEmpty
            ? (supportDir.isNotEmpty
                ? "$supportDir/thumbnails/${album!.browseId}.png"
                : "")
            : artist != null && artist!.browseId.isNotEmpty
                ? (supportDir.isNotEmpty
                    ? "$supportDir/thumbnails/${artist!.browseId}.png"
                    : "")
                : "";

    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: artist != null ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: artist != null ? null : BorderRadius.circular(5),
      ),
      child: (localFilePath.isNotEmpty && File(localFilePath).existsSync())
          ? Image.file(
              File(localFilePath),
              height: size,
              width: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildErrorWidget(context),
            )
          : (localThumbnailPath.isNotEmpty &&
                  File(localThumbnailPath).existsSync())
              ? Image.file(
                  File(localThumbnailPath),
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildNetworkOrFallback(context, imageUrl),
                )
              : _buildNetworkOrFallback(context, imageUrl),
    );
  }

  Widget _buildNetworkOrFallback(BuildContext context, String imageUrl) {
    if (imageUrl.isEmpty ||
        imageUrl.startsWith("data:") ||
        imageUrl.startsWith("file:") ||
        imageUrl.startsWith("/")) {
      return _buildErrorWidget(context);
    }
    return CachedNetworkImage(
      height: size,
      width: size,
      memCacheHeight: (song != null && !isPlayerArtImage) ? 140 : null,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => _buildErrorWidget(context),
      progressIndicatorBuilder: (context, url, progress) =>
          _buildLoader(context),
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
