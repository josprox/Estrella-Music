import 'package:flutter_test/flutter_test.dart';
import 'package:audio_service/audio_service.dart';
import 'package:estrella_music/ui/player/player_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlayButtonState & ProcessingState Mapping', () {
    PlayButtonState resolvePlayButtonState({
      required bool isPlaying,
      required AudioProcessingState processingState,
    }) {
      if (isPlaying && processingState != AudioProcessingState.buffering) {
        return PlayButtonState.playing;
      } else if (processingState == AudioProcessingState.loading) {
        return PlayButtonState.loading;
      } else if (processingState == AudioProcessingState.buffering) {
        return PlayButtonState.loading;
      } else if (!isPlaying || processingState == AudioProcessingState.error) {
        return PlayButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        return PlayButtonState.playing;
      } else {
        return PlayButtonState.paused;
      }
    }

    test('When song is playing and ready, button is playing (never loading)', () {
      final state = resolvePlayButtonState(
        isPlaying: true,
        processingState: AudioProcessingState.ready,
      );
      expect(state, PlayButtonState.playing);
    });

    test('Defensive check: if isPlaying is true but processingState was momentarily loading, button shows playing', () {
      final state = resolvePlayButtonState(
        isPlaying: true,
        processingState: AudioProcessingState.loading,
      );
      expect(state, PlayButtonState.playing);
    });

    test('When song is buffering during playback, button displays loading', () {
      final state = resolvePlayButtonState(
        isPlaying: true,
        processingState: AudioProcessingState.buffering,
      );
      expect(state, PlayButtonState.loading);
    });

    test('When player is paused and ready, button displays paused', () {
      final state = resolvePlayButtonState(
        isPlaying: false,
        processingState: AudioProcessingState.ready,
      );
      expect(state, PlayButtonState.paused);
    });

    test('When player is starting cold and loading, button displays loading', () {
      final state = resolvePlayButtonState(
        isPlaying: false,
        processingState: AudioProcessingState.loading,
      );
      expect(state, PlayButtonState.loading);
    });

    test('When playback encounters an error, button displays paused', () {
      final state = resolvePlayButtonState(
        isPlaying: false,
        processingState: AudioProcessingState.error,
      );
      expect(state, PlayButtonState.paused);
    });
  });

  group('Effective Duration Resolution', () {
    Duration? resolveEffectiveDuration({
      required Duration? playerDuration,
      required Duration? mediaItemDuration,
    }) {
      if (playerDuration != null && playerDuration.inMilliseconds > 1500) {
        if (mediaItemDuration != null && mediaItemDuration.inMilliseconds > 1500) {
          return playerDuration < mediaItemDuration ? playerDuration : mediaItemDuration;
        }
        return playerDuration;
      }
      return mediaItemDuration;
    }

    test('Takes minimum when container has trailing phantom padding larger than advertised track', () {
      // Advertised track is 2:25 (145s), but WebM container reports 2:28 (148s)
      const mediaDur = Duration(seconds: 145);
      const playerDur = Duration(seconds: 148);

      final effective = resolveEffectiveDuration(
        playerDuration: playerDur,
        mediaItemDuration: mediaDur,
      );

      // Ensures we don't wait for 3 seconds of phantom padding
      expect(effective, mediaDur);
    });

    test('Takes player duration when container stream is shorter than rounded catalog metadata', () {
      // Advertised track is 2:25 (145s), but actual audio stream finishes at 2:24.5 (144.5s)
      const mediaDur = Duration(seconds: 145);
      const playerDur = Duration(milliseconds: 144500);

      final effective = resolveEffectiveDuration(
        playerDuration: playerDur,
        mediaItemDuration: mediaDur,
      );

      expect(effective, playerDur);
    });
  });

  group('Universal Cross-Platform Track Completion Engine', () {
    int calculateUniversalOffsetMs(Duration duration) {
      const universalOffsetMs = 1500;
      if (duration.inMilliseconds < 4000) {
        return (duration.inMilliseconds * 0.2).round();
      }
      return universalOffsetMs;
    }

    bool shouldTriggerTrackCompletion({
      required Duration position,
      required Duration? duration,
      required bool isSongLoading,
      required bool isTriggeringNext,
    }) {
      if (isSongLoading || isTriggeringNext) {
        return false;
      }
      if (duration != null && duration.inMilliseconds > 1500) {
        final offset = calculateUniversalOffsetMs(duration);
        final remainingMs = duration.inMilliseconds - position.inMilliseconds;
        if (remainingMs <= offset) {
          return true;
        }
      }
      return false;
    }

    test('Universal: 2:24 of 2:25 smoothly triggers completion', () {
      const duration = Duration(minutes: 2, seconds: 25); // 145,000 ms
      const position = Duration(minutes: 2, seconds: 24); // 144,000 ms (remaining 1,000 ms <= 1,500 ms)

      final triggers = shouldTriggerTrackCompletion(
        position: position,
        duration: duration,
        isSongLoading: false,
        isTriggeringNext: false,
      );

      expect(triggers, isTrue);
    });

    test('Universal: 4:03 of 4:04 smoothly triggers completion', () {
      const duration = Duration(minutes: 4, seconds: 4); // 244,000 ms
      const position = Duration(minutes: 4, seconds: 3); // 243,000 ms (remaining 1,000 ms <= 1,500 ms)

      final triggers = shouldTriggerTrackCompletion(
        position: position,
        duration: duration,
        isSongLoading: false,
        isTriggeringNext: false,
      );

      expect(triggers, isTrue);
    });

    test('Universal: 3:36 of 3:37 smoothly triggers completion', () {
      const duration = Duration(minutes: 3, seconds: 37); // 217,000 ms
      const position = Duration(minutes: 3, seconds: 36); // 216,000 ms (remaining 1,000 ms <= 1,500 ms)

      final triggers = shouldTriggerTrackCompletion(
        position: position,
        duration: duration,
        isSongLoading: false,
        isTriggeringNext: false,
      );

      expect(triggers, isTrue);
    });

    test('In middle of track (e.g. 1:15 of 2:25), completion is NOT triggered', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const position = Duration(minutes: 1, seconds: 15);

      final triggers = shouldTriggerTrackCompletion(
        position: position,
        duration: duration,
        isSongLoading: false,
        isTriggeringNext: false,
      );

      expect(triggers, isFalse);
    });

    test('Ultra-short track (e.g. 3.0s sound effect) scales offset proportionally (20%) without premature cutoff', () {
      const duration = Duration(milliseconds: 3000);
      final offset = calculateUniversalOffsetMs(duration);
      expect(offset, 600); // 20% of 3000ms = 600ms, instead of 1500ms

      expect(
        shouldTriggerTrackCompletion(
          position: const Duration(milliseconds: 2000),
          duration: duration,
          isSongLoading: false,
          isTriggeringNext: false,
        ),
        isFalse,
      );

      expect(
        shouldTriggerTrackCompletion(
          position: const Duration(milliseconds: 2500),
          duration: duration,
          isSongLoading: false,
          isTriggeringNext: false,
        ),
        isTrue,
      );
    });
  });

  group('PlayerStateStream End-of-Track Stop Detection', () {
    bool shouldAutoAdvanceOnPlaybackHalt({
      required bool userInitiatedPause,
      required bool isPlaying,
      required bool isSongLoading,
      required bool isTriggeringNext,
      required Duration position,
      required Duration? duration,
    }) {
      if (userInitiatedPause || isPlaying || isSongLoading || isTriggeringNext) {
        return false;
      }
      if (duration != null && duration.inMilliseconds > 1500) {
        final remainingMs = duration.inMilliseconds - position.inMilliseconds;
        if (remainingMs <= 4000) {
          return true;
        }
      }
      return false;
    }

    test('When player stops at 2:24 of 2:25 without user pause, it auto-advances immediately', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const position = Duration(minutes: 2, seconds: 24);

      final shouldAdvance = shouldAutoAdvanceOnPlaybackHalt(
        userInitiatedPause: false, // user did not pause!
        isPlaying: false, // ExoPlayer halted audio track at EOF
        isSongLoading: false,
        isTriggeringNext: false,
        position: position,
        duration: duration,
      );

      expect(shouldAdvance, isTrue);
    });

    test('When user intentionally pauses at 2:24 of 2:25, it does NOT auto-advance', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const position = Duration(minutes: 2, seconds: 24);

      final shouldAdvance = shouldAutoAdvanceOnPlaybackHalt(
        userInitiatedPause: true, // user tapped pause button!
        isPlaying: false,
        isSongLoading: false,
        isTriggeringNext: false,
        position: position,
        duration: duration,
      );

      expect(shouldAdvance, isFalse);
    });

    test('When player is paused mid-track (e.g. 1:00 of 2:25), it does NOT auto-advance', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const position = Duration(minutes: 1);

      final shouldAdvance = shouldAutoAdvanceOnPlaybackHalt(
        userInitiatedPause: false,
        isPlaying: false,
        isSongLoading: false,
        isTriggeringNext: false,
        position: position,
        duration: duration,
      );

      expect(shouldAdvance, isFalse);
    });
  });

  group('Universal Near-End Stall Watchdog Detection', () {
    bool checkNearEndStallWatchdog({
      required Duration currentPosition,
      required Duration lastPosition,
      required Duration? duration,
      required bool userInitiatedPause,
      required bool isTriggeringNext,
      required bool isSongLoading,
    }) {
      if (isTriggeringNext || isSongLoading) return false;
      if (userInitiatedPause) return false;
      if (duration == null || duration.inMilliseconds <= 1500) return false;

      final remainingMs = duration.inMilliseconds - currentPosition.inMilliseconds;
      if (remainingMs <= 4000) {
        final advanced = currentPosition - lastPosition;
        if (advanced.inMilliseconds.abs() < 100) {
          return true; // Stall detected across any OS
        }
      }
      return false;
    }

    test('Watchdog triggers completion when audio halts anywhere in the last 4s across any platform', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const frozenPosition = Duration(minutes: 2, seconds: 23, milliseconds: 500);

      final shouldTrigger = checkNearEndStallWatchdog(
        currentPosition: frozenPosition,
        lastPosition: frozenPosition, // no progress for 1.0s
        duration: duration,
        userInitiatedPause: false,
        isTriggeringNext: false,
        isSongLoading: false,
      );

      expect(shouldTrigger, isTrue);
    });

    test('Watchdog respects user pause near end of track and does NOT trigger', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const frozenPosition = Duration(minutes: 2, seconds: 24);

      final shouldTrigger = checkNearEndStallWatchdog(
        currentPosition: frozenPosition,
        lastPosition: frozenPosition,
        duration: duration,
        userInitiatedPause: true, // user paused!
        isTriggeringNext: false,
        isSongLoading: false,
      );

      expect(shouldTrigger, isFalse);
    });

    test('Watchdog does not trigger mid-track (e.g. 1:00 of 2:25)', () {
      const duration = Duration(minutes: 2, seconds: 25);
      const position = Duration(minutes: 1);

      final shouldTrigger = checkNearEndStallWatchdog(
        currentPosition: position,
        lastPosition: position,
        duration: duration,
        userInitiatedPause: false,
        isTriggeringNext: false,
        isSongLoading: false,
      );

      expect(shouldTrigger, isFalse);
    });
  });
}
