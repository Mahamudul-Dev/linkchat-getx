import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// These class provide only theme related information.
// All theme information is saved in local storage.
class ThemeProvider {
  final _getStorage = GetStorage();
  final themeStoreKey = 'isDark';

  ThemeMode getThemeMode() {
    return isSavedLightMood() ? ThemeMode.light : ThemeMode.dark;
  }

  bool isSavedLightMood() {
    return _getStorage.read(themeStoreKey) ?? false;
  }
}
