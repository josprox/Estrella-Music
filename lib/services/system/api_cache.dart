import 'dart:async';

class Semaphore {
  final int maxCount;
  int _currentCount = 0;
  final List<Completer<void>> _waitQueue = [];

  Semaphore(this.maxCount);

  Future<void> acquire() async {
    if (_currentCount < maxCount) {
      _currentCount++;
      return Future.value();
    }
    final completer = Completer<void>();
    _waitQueue.add(completer);
    return completer.future;
  }

  void release() {
    if (_waitQueue.isNotEmpty) {
      final next = _waitQueue.removeAt(0);
      next.complete();
    } else {
      _currentCount--;
    }
  }
}

class CacheEntry<T> {
  final T data;
  final DateTime timestamp;

  CacheEntry(this.data) : timestamp = DateTime.now();

  bool isExpired(Duration duration) {
    return DateTime.now().difference(timestamp) > duration;
  }
}

class ApiCache {
  static final ApiCache _instance = ApiCache._internal();
  factory ApiCache() => _instance;
  ApiCache._internal();

  final Semaphore _semaphore = Semaphore(3);
  final Map<String, CacheEntry<dynamic>> _cache = {};

  Future<T> getOrFetch<T>({
    required String key,
    required Future<T> Function() fetcher,
    Duration cacheDuration = const Duration(minutes: 5),
  }) async {
    if (_cache.containsKey(key) && !_cache[key]!.isExpired(cacheDuration)) {
      return _cache[key]!.data as T;
    }

    await _semaphore.acquire();
    try {
      final T data = await fetcher();
      _cache[key] = CacheEntry(data);
      return data;
    } finally {
      _semaphore.release();
    }
  }

  void invalidate(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }
}
