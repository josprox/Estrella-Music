// ignore_for_file: constant_identifier_names

import 'package:harmonymusic/generated/l10n.dart';

class PlaylingFrom {
  PlaylingFromType type;
  String name;

  PlaylingFrom({required this.type, this.name = ""});

  get typeString {
    switch (type) {
      case PlaylingFromType.ALBUM:
        return S.current.playingfromAlbum;
      case PlaylingFromType.PLAYLIST:
        return S.current.playingfromPlaylist;
      case PlaylingFromType.SELECTION:
        return S.current.playingfromSelection;
      case PlaylingFromType.ARTIST:
        return S.current.playingfromArtist;
    }
  }

  get nameString {
    if (type == PlaylingFromType.SELECTION) return S.current.randomSelection;
    return name;
  }
}

enum PlaylingFromType { ALBUM, PLAYLIST, SELECTION, ARTIST }
