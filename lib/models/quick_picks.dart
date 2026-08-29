import 'package:audio_service/audio_service.dart';
import 'media_item_builder.dart';

class QuickPicks {
  QuickPicks(this.songList, {this.title = "Discover"});
  List<MediaItem> songList;
  final String title;

  factory QuickPicks.fromJson(Map<dynamic, dynamic> json) => QuickPicks(
      (json['songList'] as List)
          .map((e) => MediaItemBuilder.fromJson(e))
          .toList(),
      title: json['title']);

  Map<String, dynamic> toJson() => {
        "type": "QuickPicks Content",
        "title": title,
        "songList": songList.map((e) => MediaItemBuilder.toJson(e)).toList()
      };
}
