import 'package:share_plus/share_plus.dart';

/// Creates provider-neutral public links owned by eMusic.
class MusicShareManager {
  static const String _emusicShareDomain = 'https://emusic.joss.red';

  static Future<void> shareSong(String songId,
      {String? title, String? artist}) async {
    final url = '$_emusicShareDomain/share/song/$songId';
    if (title != null && artist != null) {
      await SharePlus.instance.share(
        ShareParams(text: 'Escucha $title de $artist en $url'),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(uri: Uri.parse(url)),
      );
    }
  }

  static Future<void> shareAlbum(String albumId, {String? albumTitle}) async {
    final url = '$_emusicShareDomain/share/album/$albumId';
    if (albumTitle != null) {
      await SharePlus.instance.share(
        ShareParams(text: 'Escucha el álbum $albumTitle en $url'),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(uri: Uri.parse(url)),
      );
    }
  }

  static Future<void> sharePlaylist(String playlistId,
      {String? playlistTitle}) async {
    final url = '$_emusicShareDomain/share/playlist/$playlistId';
    if (playlistTitle != null) {
      await SharePlus.instance.share(
        ShareParams(text: 'Escucha la lista $playlistTitle en $url'),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(uri: Uri.parse(url)),
      );
    }
  }

  static Future<void> shareArtist(String artistId, {String? artistName}) async {
    final url = '$_emusicShareDomain/share/artist/$artistId';
    if (artistName != null) {
      await SharePlus.instance.share(
        ShareParams(text: 'Escucha a $artistName en $url'),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(uri: Uri.parse(url)),
      );
    }
  }
}
