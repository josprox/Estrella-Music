import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/download/downloader.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

import 'loader.dart';
import 'snackbar.dart';
import 'package:harmonymusic/generated/l10n.dart';

class SongDownloadButton extends StatelessWidget {
  const SongDownloadButton(
      {super.key,
      this.calledFromPlayer = false,
      this.song_,
      this.isDownloadingDoneCallback});
  final bool calledFromPlayer;
  final MediaItem? song_;
  final void Function(bool)? isDownloadingDoneCallback;

  @override
  Widget build(BuildContext context) {
    final downloader = Get.find<Downloader>();
    final playerController = Get.find<PlayerController>();
    return Obx(() {
      final song =
          calledFromPlayer ? playerController.currentSong.value : song_;
      if (song == null) return const SizedBox.shrink();
      final isDownloadingDone = (downloader.songQueue.contains(song) &&
          downloader.songProgressMap[song.id] == 100);
      if (isDownloadingDoneCallback != null) {
        isDownloadingDoneCallback!(isDownloadingDone);
      }

      return (isDownloadingDone ||
              SqliteStore.box("SongDownloads").containsKey(song.id))
          ? Icon(
              Icons.download_done,
              color: Theme.of(context).textTheme.titleMedium!.color,
            )
          : downloader.songQueue.contains(song) &&
                  downloader.isJobRunning.isTrue &&
                  downloader.songProgressMap.containsKey(song.id)
              ? Obx(() => Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${downloader.songProgressMap[song.id]}%",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      LoadingIndicator(
                        dimension: 30,
                        strokeWidth: 4,
                        value: (downloader.songProgressMap[song.id] ?? 0) / 100,
                      )
                    ],
                  ))
              : downloader.songQueue.contains(song)
                  ? const LoadingIndicator()
                  : IconButton(
                      icon: Icon(
                        Icons.download,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      ),
                      onPressed: () {
                        (SqliteStore.openBox("SongsCache").then((box) {
                          if (box.containsKey(song.id)) {
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(snackbar(
                                context, S.current.songAlreadyOfflineAlert,
                                size: SanckBarSize.BIG));
                          } else {
                            downloader.download(song);
                          }
                        }));
                      },
                    );
    });
  }
}
