abstract class LocalGetStorage {
  Future<void> write({required String key, required dynamic value});
  bool? read(String key);
  Future<void> remove(String key);
}
