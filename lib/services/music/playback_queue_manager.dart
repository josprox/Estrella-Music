import 'package:audio_service/audio_service.dart';
import 'package:estrella_music/models/playling_from.dart';
import 'package:estrella_music/utils/helpers/queue_reorder.dart';

/// Single source of truth for queue items, shuffle state, and playback navigation.
///
/// Completely decoupled from UI layers and native audio drivers.
class PlaybackQueueManager {
  PlaybackQueueManager({
    List<MediaItem>? initialQueue,
    int initialIndex = 0,
    bool shuffleModeEnabled = false,
    bool loopModeEnabled = false,
    bool queueLoopModeEnabled = false,
  })  : _items = initialQueue != null ? List.from(initialQueue) : <MediaItem>[],
        _currentIndex = initialIndex,
        _shuffleModeEnabled = shuffleModeEnabled,
        _loopModeEnabled = loopModeEnabled,
        _queueLoopModeEnabled = queueLoopModeEnabled {
    if (_shuffleModeEnabled && _items.isNotEmpty) {
      _initShuffle(_currentIndex);
    }
  }

  List<MediaItem> _items;
  int _currentIndex;
  List<String> _shuffledQueue = [];
  int _currentShuffleIndex = 0;
  bool _shuffleModeEnabled;
  bool _loopModeEnabled;
  bool _queueLoopModeEnabled;
  PlaylingFrom? _playingFrom;
  bool _isRadioMode = false;

  // Getters
  List<MediaItem> get items => List.unmodifiable(_items);
  int get currentIndex => _currentIndex;
  List<String> get shuffledQueue => List.unmodifiable(_shuffledQueue);
  int get currentShuffleIndex => _currentShuffleIndex;
  bool get shuffleModeEnabled => _shuffleModeEnabled;
  bool get loopModeEnabled => _loopModeEnabled;
  bool get queueLoopModeEnabled => _queueLoopModeEnabled;
  PlaylingFrom? get playingFrom => _playingFrom;
  bool get isRadioMode => _isRadioMode;
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;
  int get length => _items.length;

  MediaItem? get currentTrack {
    if (_currentIndex >= 0 && _currentIndex < _items.length) {
      return _items[_currentIndex];
    }
    return null;
  }

  /// Atomically replaces the current queue and aligns indices.
  void loadQueue(
    List<MediaItem> newItems, {
    int startIndex = 0,
    PlaylingFrom? playFrom,
    bool isRadio = false,
  }) {
    _items = List<MediaItem>.from(newItems);
    _currentIndex = (_items.isNotEmpty)
        ? startIndex.clamp(0, _items.length - 1)
        : 0;
    _playingFrom = playFrom;
    _isRadioMode = isRadio;

    if (_shuffleModeEnabled && _items.isNotEmpty) {
      _initShuffle(_currentIndex);
    } else {
      _shuffledQueue.clear();
      _currentShuffleIndex = 0;
    }
  }

  /// Appends multiple items to the current queue.
  void addItems(List<MediaItem> additionalItems) {
    if (additionalItems.isEmpty) return;
    _items.addAll(additionalItems);

    if (_shuffleModeEnabled) {
      final additionalIds = additionalItems.map((e) => e.id).toList()..shuffle();
      _shuffledQueue.addAll(additionalIds);
    }
  }

  /// Appends a single item to the current queue.
  void addItem(MediaItem item) {
    _items.add(item);
    if (_shuffleModeEnabled) {
      _shuffledQueue.add(item.id);
    }
  }

  /// Inserts a song immediately after the current playing song.
  void insertPlayNext(MediaItem item) {
    if (_items.isEmpty) {
      _items.add(item);
      _currentIndex = 0;
      return;
    }
    final insertIndex = (_currentIndex + 1).clamp(0, _items.length);
    _items.insert(insertIndex, item);

    if (_shuffleModeEnabled) {
      final shuffleInsertIndex = (_currentShuffleIndex + 1).clamp(0, _shuffledQueue.length);
      _shuffledQueue.insert(shuffleInsertIndex, item.id);
    }
  }

  /// Removes an item at [index] and keeps indices safely synchronized.
  MediaItem? removeAt(int index) {
    if (index < 0 || index >= _items.length) return null;
    final removed = _items.removeAt(index);

    if (_shuffleModeEnabled) {
      final shuffleIndex = _shuffledQueue.indexOf(removed.id);
      if (shuffleIndex != -1) {
        if (_currentShuffleIndex > shuffleIndex) {
          _currentShuffleIndex--;
        }
        _shuffledQueue.removeAt(shuffleIndex);
      }
    }

    if (_currentIndex > index) {
      _currentIndex--;
    } else if (_currentIndex >= _items.length && _items.isNotEmpty) {
      _currentIndex = _items.length - 1;
    }
    return removed;
  }

  /// Reorders an item and preserves the selected track position.
  void reorder(int oldIndex, int newIndex) {
    if (_items.isEmpty) return;
    final result = reorderQueue<MediaItem>(
      items: _items,
      oldIndex: oldIndex,
      newIndex: newIndex,
      currentIndex: _currentIndex,
    );
    _items = result.items;
    _currentIndex = result.currentIndex;
  }

  /// Toggles or updates shuffle mode.
  void setShuffle(bool enabled) {
    _shuffleModeEnabled = enabled;
    if (_shuffleModeEnabled && _items.isNotEmpty) {
      _initShuffle(_currentIndex);
    } else {
      _shuffledQueue.clear();
      _currentShuffleIndex = 0;
    }
  }

  void setLoopMode(bool enabled) {
    _loopModeEnabled = enabled;
  }

  void setQueueLoopMode(bool enabled) {
    _queueLoopModeEnabled = enabled;
  }

  /// Seeks to a specific queue index and aligns shuffle pointers.
  void seekToIndex(int index) {
    if (index < 0 || index >= _items.length) return;
    _currentIndex = index;

    if (_shuffleModeEnabled && _shuffledQueue.isNotEmpty) {
      final currentId = _items[_currentIndex].id;
      final foundShuffleIdx = _shuffledQueue.indexOf(currentId);
      if (foundShuffleIdx != -1) {
        _currentShuffleIndex = foundShuffleIdx;
      }
    }
  }

  /// Computes the index of the next song, or null if the queue concludes.
  int? getNextIndex() {
    if (_items.isEmpty) return null;

    if (_shuffleModeEnabled && _shuffledQueue.isNotEmpty) {
      if (_currentShuffleIndex + 1 >= _shuffledQueue.length) {
        if (_queueLoopModeEnabled) {
          _shuffledQueue.shuffle();
          _currentShuffleIndex = 0;
        } else {
          return null; // Queue ended in shuffle
        }
      } else {
        _currentShuffleIndex++;
      }
      final targetId = _shuffledQueue[_currentShuffleIndex];
      final targetIndex = _items.indexWhere((item) => item.id == targetId);
      return targetIndex != -1 ? targetIndex : _currentIndex;
    }

    if (_currentIndex + 1 < _items.length) {
      return _currentIndex + 1;
    } else if (_queueLoopModeEnabled) {
      return 0;
    }
    return null;
  }

  /// Computes the index of the previous song.
  int? getPreviousIndex() {
    if (_items.isEmpty) return null;

    if (_shuffleModeEnabled && _shuffledQueue.isNotEmpty) {
      if (_currentShuffleIndex - 1 < 0) {
        if (_queueLoopModeEnabled) {
          _currentShuffleIndex = _shuffledQueue.length - 1;
        } else {
          return _currentIndex;
        }
      } else {
        _currentShuffleIndex--;
      }
      final targetId = _shuffledQueue[_currentShuffleIndex];
      final targetIndex = _items.indexWhere((item) => item.id == targetId);
      return targetIndex != -1 ? targetIndex : _currentIndex;
    }

    if (_currentIndex - 1 >= 0) {
      return _currentIndex - 1;
    }
    return 0;
  }

  void _initShuffle(int selectedIndex) {
    final ids = _items.map((e) => e.id).toList();
    if (selectedIndex >= 0 && selectedIndex < ids.length) {
      final selectedId = ids.removeAt(selectedIndex);
      ids.shuffle();
      ids.insert(0, selectedId);
    } else {
      ids.shuffle();
    }
    _shuffledQueue = ids;
    _currentShuffleIndex = 0;
  }
}
