import 'package:audio_service/audio_service.dart' show MediaItem;

import 'package:estrella_music/models/thumbnail.dart';

class PlaylistContent {
  PlaylistContent({required this.title, required this.playlistList});
  final String title;
  final List<Playlist> playlistList;

  factory PlaylistContent.fromJson(Map<dynamic, dynamic> json) =>
      PlaylistContent(
          title: json['title'],
          playlistList: (json['playlists'] as List)
              .map((e) => Playlist.fromJson(e))
              .toList());
  Map<String, dynamic> toJson() => {
        "type": "Playlist Content",
        "title": title,
        "playlists": playlistList.map((e) => e.toJson()).toList()
      };
}

class Playlist {
  Playlist(
      {required this.title,
      required this.playlistId,
      this.description,
      required this.thumbnailUrl,
      this.songCount,
      this.isPipedPlaylist = false,
      this.isCloudPlaylist = true,
      this.isPublic = false,
      this.isCollaborative = false,
      this.collaborators = const [],
      this.ownerId,
      this.providerId,
      this.profileId,
      String? sourceId})
      : sourceId = sourceId ?? playlistId;
  final String playlistId;
  String title;
  final bool isPipedPlaylist;
  String? description;
  String thumbnailUrl;
  final String? songCount;
  final bool isCloudPlaylist;
  final bool isPublic;
  bool isCollaborative;
  List<dynamic> collaborators;
  final int? ownerId;
  final String? providerId;
  final String? profileId;
  final String sourceId;
  static const thumbPlaceholderUrl =
      "https://raw.githubusercontent.com/josprox/Estrella-Music/main/assets/icons/song.png";

  factory Playlist.fromJson(Map<dynamic, dynamic> json) {
    final thumbnailUrl = _thumbnailUrlFromJson(json);
    return Playlist(
      title: json["title"]?.toString() ?? "Playlist",
      playlistId:
          (json["playlistId"] ?? json["playlist_id"] ?? json["browseId"])
              .toString(),
      thumbnailUrl: thumbnailUrl.isEmpty
          ? Thumbnail(thumbPlaceholderUrl).extraHigh
          : Thumbnail(thumbnailUrl).extraHigh,
      description: json["description"]?.toString() ?? "Playlist",
      songCount:
          (json['itemCount'] ?? json['count'] ?? json['songCount'])?.toString(),
      isPipedPlaylist: _boolFromJson(json["isPipedPlaylist"]),
      isCloudPlaylist: json.containsKey("isCloudPlaylist")
          ? _boolFromJson(json["isCloudPlaylist"])
          : true,
      isPublic: _boolFromJson(json["isPublic"] ?? json["is_public"]),
      isCollaborative:
          _boolFromJson(json["isCollaborative"] ?? json["is_collaborative"]),
      collaborators: json["collaborators"] as List? ?? [],
      ownerId: _intFromJson(json["ownerId"] ?? json["owner_id"]),
      providerId: json['providerId']?.toString(),
      profileId: json['profileId']?.toString(),
      sourceId: json['sourceId']?.toString(),
    );
  }

  static String _thumbnailUrlFromJson(Map<dynamic, dynamic> json) {
    final directUrl = json["thumbnailUrl"] ?? json["thumbnail_url"];
    if (directUrl != null && directUrl.toString().isNotEmpty) {
      return directUrl.toString();
    }

    final thumbnails = json["thumbnails"];
    if (thumbnails is List && thumbnails.isNotEmpty) {
      final first = thumbnails.first;
      if (first is Map) {
        return first["url"]?.toString() ?? "";
      }
    }
    return "";
  }

  static bool _boolFromJson(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.toLowerCase().trim();
      return normalized == 'true' || normalized == '1';
    }
    return false;
  }

  static int? _intFromJson(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "playlistId": playlistId,
        'providerId': providerId,
        'profileId': profileId,
        'sourceId': sourceId,
        "description": description,
        'thumbnails': [
          {'url': thumbnailUrl}
        ],
        "itemCount": songCount,
        "isPipedPlaylist": isPipedPlaylist,
        "isCloudPlaylist": isCloudPlaylist,
        "isPublic": isPublic,
        "isCollaborative": isCollaborative,
        "collaborators": collaborators,
        "ownerId": ownerId
      };

  Playlist copyWith({
    String? title,
    String? thumbnailUrl,
    bool? isPublic,
    bool? isCollaborative,
    List<dynamic>? collaborators,
    int? ownerId,
  }) {
    return Playlist(
        title: title ?? this.title,
        playlistId: playlistId,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        description: description,
        songCount: songCount,
        isPipedPlaylist: isPipedPlaylist,
        isCloudPlaylist: isCloudPlaylist,
        isPublic: isPublic ?? this.isPublic,
        isCollaborative: isCollaborative ?? this.isCollaborative,
        collaborators: collaborators ?? this.collaborators,
        ownerId: ownerId ?? this.ownerId,
        providerId: providerId,
        profileId: profileId,
        sourceId: sourceId);
  }

  // Converts this object to a MediaItem object.
  // This is used to display the playlist in Android auto.
  MediaItem toMediaItem() {
    return MediaItem(
        id: playlistId,
        title: title,
        artUri: Uri.parse(thumbnailUrl),
        playable: false);
  }

  set newTitle(String title) {
    this.title = title;
  }
}
