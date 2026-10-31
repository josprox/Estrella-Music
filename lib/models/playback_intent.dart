import 'package:audio_service/audio_service.dart';
import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/playling_from.dart';
import 'package:estrella_music/models/playlist.dart';

/// Sealed hierarchy defining explicit, type-safe playback intentions.
///
/// UI widgets dispatch an intent instead of deciding low-level queue mutations.
sealed class PlaybackIntent {
  const PlaybackIntent();
}

/// Plays tracks from an album context starting at [startIndex].
class PlayAlbumIntent extends PlaybackIntent {
  final Album album;
  final List<MediaItem> tracks;
  final int startIndex;

  const PlayAlbumIntent({
    required this.album,
    required this.tracks,
    this.startIndex = 0,
  });

  PlaylingFrom get playFrom => PlaylingFrom(
        name: album.title,
        type: PlaylingFromType.ALBUM,
      );
}

/// Plays tracks from a playlist context starting at [startIndex].
class PlayPlaylistIntent extends PlaybackIntent {
  final Playlist playlist;
  final List<MediaItem> tracks;
  final int startIndex;

  const PlayPlaylistIntent({
    required this.playlist,
    required this.tracks,
    this.startIndex = 0,
  });

  PlaylingFrom get playFrom => PlaylingFrom(
        name: playlist.title,
        type: PlaylingFromType.PLAYLIST,
      );
}

/// Starts dynamic radio recommendations seeded from [seedTrack].
class StartRadioIntent extends PlaybackIntent {
  final MediaItem seedTrack;
  final String? playlistId;

  const StartRadioIntent({
    required this.seedTrack,
    this.playlistId,
  });

  PlaylingFrom get playFrom => PlaylingFrom(
        name: seedTrack.title,
        type: PlaylingFromType.SELECTION,
      );
}

/// Plays an arbitrary list of tracks with a specified playback origin context.
class PlayTrackListIntent extends PlaybackIntent {
  final List<MediaItem> tracks;
  final int startIndex;
  final PlaylingFrom? playFrom;

  const PlayTrackListIntent({
    required this.tracks,
    this.startIndex = 0,
    this.playFrom,
  });
}

/// Plays an individual standalone track and resolves associated queue in background.
class PlayTrackStandaloneIntent extends PlaybackIntent {
  final MediaItem track;

  const PlayTrackStandaloneIntent({
    required this.track,
  });

  PlaylingFrom get playFrom => PlaylingFrom(
        name: track.title,
        type: PlaylingFromType.SELECTION,
      );
}
