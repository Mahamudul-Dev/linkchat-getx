import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// These class provide only theme related information.
// All theme information is saved in local storage.
class ThemeProvider {
  final _getStorage = GetStorage();
  final themeStoreKey = 'isDark';

  ThemeMode getThemeMode() {
    return isSavedLightMood().value ? ThemeMode.light : ThemeMode.dark;
  }

  RxBool isSavedLightMood() {
    RxBool isDark = false.obs;
    _getStorage.writeIfNull(themeStoreKey, isDark.value);
    _getStorage.listenKey(themeStoreKey, (value) { isDark.value = value; });
    return isDark;
  }
}
