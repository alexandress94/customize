import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organize_more/core/services/packages/contracts/local_get_storage.dart';
import 'package:organize_more/core/services/packages/gateways/local_get_storage_implementation.dart';
import 'package:organize_more/core/values/keys/keys.dart';

class ThemeServiceController extends GetxController {
  final LocalGetStorage _storage = LocalGetStorageImplementation();

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return _storage.read(Keys.DARK_THEME) ?? false;
  }

  void _writeThemeMode(bool isDarkMode) {
    _storage.write(key: Keys.DARK_THEME, value: isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    _writeThemeMode(!isSavedDarkMode());
    update(['change-theme']);
  }
}
