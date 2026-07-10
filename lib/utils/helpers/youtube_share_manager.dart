import 'package:share_plus/share_plus.dart';

class YoutubeShareManager {
  static const String _youtubeMusicDomain = 'https://music.youtube.com';
  static const String _youtubeVideoDomain = 'https://youtube.com';

  /// Comparte una canción
  static Future<void> shareSong(String songId, {String? title, String? artist}) async {
    final url = '$_youtubeMusicDomain/watch?v=$songId';
    if (title != null && artist != null) {
      await Share.share('Escucha $title de $artist en $url');
    } else {
      await Share.share(url);
    }
  }

  /// Comparte un álbum (que en YouTube Music funciona como playlist)
  static Future<void> shareAlbum(String playlistId, {String? albumTitle}) async {
    final url = '$_youtubeVideoDomain/playlist?list=$playlistId';
    if (albumTitle != null) {
      await Share.share('Escucha el álbum $albumTitle en $url');
    } else {
      await Share.share(url);
    }
  }

  /// Comparte una lista de reproducción
  static Future<void> sharePlaylist(String playlistId, {String? playlistTitle}) async {
    final url = '$_youtubeVideoDomain/playlist?list=$playlistId';
    if (playlistTitle != null) {
      await Share.share('Escucha la lista $playlistTitle en $url');
    } else {
      await Share.share(url);
    }
  }

  /// Comparte un artista
  static Future<void> shareArtist(String browseId, {String? artistName}) async {
    final url = '$_youtubeMusicDomain/channel/$browseId';
    if (artistName != null) {
      await Share.share('Escucha a $artistName en $url');
    } else {
      await Share.share(url);
    }
  }

  /// Obtiene solo el enlace de una canción (por ejemplo, para copiar)
  static String getSongUrl(String songId) {
    return '$_youtubeVideoDomain/watch?v=$songId';
  }

  /// Obtiene solo el enlace de Music
  static String getMusicSongUrl(String songId) {
    return '$_youtubeMusicDomain/watch?v=$songId';
  }
}
