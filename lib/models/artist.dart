import 'package:estrella_music/models/thumbnail.dart';

class Artist {
  Artist({
    required this.name,
    required this.browseId,
    this.radioId,
    this.shuffleId,
    this.isProfile = false,
    this.isSubscribed = false,
    required this.thumbnailUrl,
    this.subscribers,
    this.monthlyListeners,
    this.providerId,
    this.profileId,
    String? sourceId,
  }) : sourceId = sourceId ?? browseId;
  final String name;
  final String browseId;
  final String? radioId;
  final String? shuffleId;
  final bool isProfile;
  final bool isSubscribed;
  final String? subscribers;
  final String thumbnailUrl;

  /// Monthly listeners string, e.g. "12,345,678 monthly listeners"
  final String? monthlyListeners;
  final String? providerId;
  final String? profileId;
  final String sourceId;

  factory Artist.fromJson(dynamic json) => Artist(
      name: json['artist'] ?? json['title'] ?? "Unknown Artist",
      browseId: json['browseId'],
      radioId: json['radioId'],
      shuffleId: json['shuffleId'],
      isProfile: json['isProfile'] ?? false,
      isSubscribed: json['isSubscribed'] ?? false,
      providerId: json['providerId']?.toString(),
      profileId: json['profileId']?.toString(),
      sourceId: json['sourceId']?.toString(),
      monthlyListeners: json['monthlyListeners'],
      subscribers: (json['subscribers']) == null
          ? ""
          : (json['subscribers']).runtimeType.toString() == "String"
              ? json['subscribers']
              : json['subscribers']['text'],
      thumbnailUrl: Thumbnail(
              json["thumbnails"] != null && json["thumbnails"].isNotEmpty
                  ? json["thumbnails"][0]["url"]
                  : "")
          .high);

  Map<String, dynamic> toJson() => {
        'artist': name,
        'browseId': browseId,
        'providerId': providerId,
        'profileId': profileId,
        'sourceId': sourceId,
        'radioId': radioId,
        'shuffleId': shuffleId,
        'isProfile': isProfile,
        'isSubscribed': isSubscribed,
        'monthlyListeners': monthlyListeners,
        'subscribers': subscribers,
        'thumbnails': [
          {'url': thumbnailUrl}
        ]
      };
}

class ArtistContent {
  ArtistContent(this.content, {this.title = "Artists"});
  final List<Artist> content;
  final String title;

  factory ArtistContent.fromJson(Map<dynamic, dynamic> json) => ArtistContent(
        (json['artists'] as List).map((e) => Artist.fromJson(e)).toList(),
        title: json['title'] ?? "Artists",
      );

  Map<String, dynamic> toJson() => {
        "type": "Artist Content",
        "title": title,
        "artists": content.map((e) => e.toJson()).toList(),
      };
}
