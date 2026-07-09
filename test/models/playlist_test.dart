import 'package:flutter_test/flutter_test.dart';
import 'package:harmonymusic/models/playlist.dart';

void main() {
  test('Playlist.fromJson accepts cloud payload values returned as strings', () {
    final playlist = Playlist.fromJson({
      'playlist_id': 'LIB123',
      'title': 'Cloud Playlist',
      'description': 'From EMusic',
      'thumbnail_url': Playlist.thumbPlaceholderUrl,
      'itemCount': 2,
      'is_public': '1',
      'is_collaborative': 0,
      'owner_id': '42',
    });

    expect(playlist.playlistId, 'LIB123');
    expect(playlist.title, 'Cloud Playlist');
    expect(playlist.songCount, '2');
    expect(playlist.isPublic, isTrue);
    expect(playlist.isCollaborative, isFalse);
    expect(playlist.ownerId, 42);
  });
}
