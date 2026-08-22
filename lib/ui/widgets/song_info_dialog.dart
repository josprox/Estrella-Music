import 'package:audio_service/audio_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

import '/ui/widgets/common_dialog_widget.dart';
import 'package:harmonymusic/generated/l10n.dart';

class SongInfoDialog extends StatelessWidget {
  final MediaItem song;
  const SongInfoDialog({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> streamInfo = _getStreamInfo(song.id);
    return CommonDialog(
      child: SizedBox(
        height: Get.mediaQuery.size.height * .7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(S.current.songInfo,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const Divider(),
            Expanded(
                child: ListView(
              children: [
                InfoItem(title: S.current.id, value: song.id),
                InfoItem(title: S.current.title, value: song.title),
                InfoItem(title: S.current.album, value: song.album ?? "NA"),
                InfoItem(title: S.current.artists, value: song.artist ?? "NA"),
                InfoItem(
                    title: S.current.duration,
                    value:
                        "${streamInfo["approxDurationMs"] ?? song.duration?.inMilliseconds ?? "NA"} ms"),
                InfoItem(
                    title: S.current.audioCodec,
                    value: streamInfo["audioCodec"] ?? "NA"),
                InfoItem(
                    title: S.current.bitrate,
                    value: "${streamInfo["bitrate"] ?? "NA"}"),
                InfoItem(
                    title: S.current.loudnessDb,
                    value: "${streamInfo["loudnessDb"] ?? "NA"}"),
              ],
            )),
            const Divider(),
            SizedBox(
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25),
                      child: Text(S.current.close),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map<dynamic, dynamic> _getStreamInfo(String id) {
    Map<dynamic, dynamic> tempstreamInfo;
    final nullVal = {
      "audioCodec": null,
      "bitrate": null,
      "loudnessDb": null,
      "approxDurationMs": null
    };
    if (SqliteStore.box("SongDownloads").containsKey(id)) {
      final song = SqliteStore.box("SongDownloads").get(id);

      tempstreamInfo =
          song["streamInfo"] == null ? nullVal : song["streamInfo"][1];
    } else {
      final dbStreamData = SqliteStore.box("SongsUrlCache").get(id);
      tempstreamInfo = dbStreamData != null &&
              dbStreamData.runtimeType.toString().contains("Map")
          ? dbStreamData[SqliteStore.box('AppPrefs').get('streamingQuality') == 0
              ? 'lowQualityAudio'
              : "highQualityAudio"]
          : nullVal;
    }
    return tempstreamInfo;
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String value;
  const InfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
          ),
          TextSelectionTheme(
            data: Theme.of(context).textSelectionTheme,
            child: SelectableText(
              value,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
