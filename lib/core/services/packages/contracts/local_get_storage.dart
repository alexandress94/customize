abstract class LocalGetStorage {
  Future<void> write({required String key, required dynamic value});
  Future<T?> read<T>(String key);
  Future<void> remove(String key);
}
