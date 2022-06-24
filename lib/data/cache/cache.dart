abstract class Cache<K, V> {
  V? get(K key);

  V set(K key, V value);

  bool contains(K key);
}

class InAppMemory<K, V> extends Cache<K, V> {
  InAppMemory() : _cache = {};
  final Map<K, V> _cache;
  @override
  V? get(K key) {
    if (contains(key)) {
      return _cache[key]!;
    }
    return null;
  }

  @override
  V set(K key, V value) {
    _cache[key] = value;
    return value;
  }

  @override
  bool contains(K key) => _cache.containsKey(key);
}
