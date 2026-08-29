import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/artist.dart';
import 'package:estrella_music/models/media_item_builder.dart';
import 'package:estrella_music/models/playlist.dart';

void main() {
  test('musical entities preserve provider profile and source identity', () {
    const identity = {
      'providerId': 'community.example',
      'profileId': 'personal',
      'sourceId': 'source-42',
    };

    final track = MediaItemBuilder.fromJson({
      ...identity,
      'videoId': 'legacy-id',
      'title': 'Track',
      'artists': [
        {'name': 'Artist'}
      ],
      'album': {'id': 'album', 'name': 'Album'},
      'thumbnails': [
        {'url': 'https://example.test/art.jpg'}
      ],
    });
    final trackJson = MediaItemBuilder.toJson(track);
    expect(track.extras?['sourceId'], 'source-42');
    expect(trackJson, containsPair('providerId', 'community.example'));
    expect(trackJson, containsPair('profileId', 'personal'));
    expect(trackJson, containsPair('sourceId', 'source-42'));

    final album = Album.fromJson({
      ...identity,
      'title': 'Album',
      'browseId': 'legacy-album',
      'artists': const [],
      'thumbnails': const [],
    });
    final artist = Artist.fromJson({
      ...identity,
      'title': 'Artist',
      'browseId': 'legacy-artist',
      'thumbnails': const [],
    });
    final playlist = Playlist.fromJson({
      ...identity,
      'title': 'Playlist',
      'playlistId': 'legacy-playlist',
      'thumbnailUrl': '',
    });

    for (final json in [album.toJson(), artist.toJson(), playlist.toJson()]) {
      expect(json, containsPair('providerId', 'community.example'));
      expect(json, containsPair('profileId', 'personal'));
      expect(json, containsPair('sourceId', 'source-42'));
    }
  });

  test('legacy media items fall back to their old id as sourceId', () {
    final item = MediaItemBuilder.fromJson({
      'videoId': 'legacy-only',
      'title': 'Legacy',
      'artists': const [],
      'thumbnails': [
        {'url': 'https://example.test/art.jpg'}
      ],
    });
    expect(item, isA<MediaItem>());
    expect(item.extras?['sourceId'], 'legacy-only');
  });
}
