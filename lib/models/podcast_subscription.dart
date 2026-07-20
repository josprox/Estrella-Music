class PodcastSubscription {
  final String podcastId;
  final String title;
  final String author;
  final String thumbnailUrl;

  PodcastSubscription({
    required this.podcastId,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  factory PodcastSubscription.fromJson(Map<dynamic, dynamic> json) {
    return PodcastSubscription(
      podcastId: json['podcastId'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'podcastId': podcastId,
      'title': title,
      'author': author,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
