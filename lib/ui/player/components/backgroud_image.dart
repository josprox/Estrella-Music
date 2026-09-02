import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estrella_music/ui/screens/Settings/settings_screen_controller.dart';
import 'package:estrella_music/ui/utils/theme_controller.dart';
import 'package:estrella_music/ui/player/player_controller.dart';

class BackgroudImage extends StatelessWidget {
  const BackgroudImage({super.key, this.cacheHeight});

  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    return GetX<PlayerController>(
      builder: (playerController) {
        final song = playerController.currentSong.value;
        if (song == null) return const SizedBox.expand();

        final rawArtUrl = song.artUri?.toString() ?? '';
        final extrasUrl = (song.extras?['url'] ?? '').toString();
        final isLocalSong = rawArtUrl.startsWith('file://') ||
            rawArtUrl.startsWith('/') ||
            extrasUrl.startsWith('file') ||
            extrasUrl.startsWith('/');

        if (isLocalSong) {
          return Builder(builder: (context) {
            String filePath = '';
            if (rawArtUrl.startsWith('file://')) {
              try {
                filePath = Uri.parse(rawArtUrl).toFilePath();
              } catch (_) {
                filePath = rawArtUrl.replaceFirst(RegExp(r'^file://+'), '/');
              }
            } else if (rawArtUrl.startsWith('/')) {
              filePath = rawArtUrl;
            }

            final supportDir = Get.isRegistered<SettingsScreenController>()
                ? Get.find<SettingsScreenController>().supportDirPath
                : '';
            final fallbackThumbPath = supportDir.isNotEmpty
                ? "$supportDir/thumbnails/${song.id}.png"
                : '';

            File? imgFile;
            if (filePath.isNotEmpty && File(filePath).existsSync()) {
              imgFile = File(filePath);
            } else if (fallbackThumbPath.isNotEmpty &&
                File(fallbackThumbPath).existsSync()) {
              imgFile = File(fallbackThumbPath);
            }

            if (imgFile == null || !imgFile.existsSync()) {
              return const SizedBox.expand();
            }

            if (Get.find<SettingsScreenController>().themeModetype.value ==
                ThemeType.dynamic) {
              Get.find<ThemeController>().setTheme(FileImage(imgFile), song.id);
            }

            return Image.file(
              imgFile,
              cacheHeight: cacheHeight,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            );
          });
        }

        if (rawArtUrl.isEmpty ||
            rawArtUrl.startsWith('data:') ||
            rawArtUrl.startsWith('file:')) {
          return const SizedBox.expand();
        }

        return CachedNetworkImage(
          memCacheHeight: cacheHeight,
          imageBuilder: (context, imageProvider) {
            Get.find<SettingsScreenController>().themeModetype.value ==
                    ThemeType.dynamic
                ? Future.delayed(
                    const Duration(milliseconds: 50),
                    () => Get.find<ThemeController>()
                        .setTheme(imageProvider, song.id))
                : null;
            return Image(
              image: imageProvider,
              fit: BoxFit.cover,
            );
          },
          imageUrl: rawArtUrl,
          cacheKey: "${song.id}_song",
          errorWidget: (_, __, ___) => const SizedBox.expand(),
        );
      },
    );
  }
}
