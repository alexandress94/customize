import 'package:get_storage/get_storage.dart';

import '../contracts/local_get_storage.dart';

class LocalGetStorageImplementation implements LocalGetStorage {
  final GetStorage _storage = GetStorage();
  @override
  bool? read(String key) {
    return _storage.read(key);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  @override
  Future<void> write({required String key, required value}) async {
    await _storage.write(key, value);
  }
}
