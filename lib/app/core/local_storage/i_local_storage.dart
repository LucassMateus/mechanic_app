abstract interface class ILocalStorage {
  Future<void> save(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<void> remove(String key);
}
