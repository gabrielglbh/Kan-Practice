import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';

import 'dark.dart';
import 'light.dart';

const String lightTheme = "light";
const String darkTheme = "dark";

class ThemeManager {
  ThemeNotifier? _notifier;

  ThemeManager._() {
    _notifier = ThemeNotifier();
  }

  static final ThemeManager _instance = ThemeManager._();

  /// Singleton instance of [ThemeManager]
  static ThemeManager get instance => _instance;

  ThemeMode get themeMode => _notifier?.isDarkTheme == true ? ThemeMode.dark : ThemeMode.light;
  ThemeData? get currentLightThemeData => light;
  ThemeData? get currentDarkThemeData => dark;

  /// Switch the theme mode on the device
  switchMode(bool mode) => _notifier?.setMode(mode);

  /// Adds a custom listener to the [_notifier]
  addListenerTo(Function() listener) => _notifier?.addListener(listener);
}

class ThemeNotifier with ChangeNotifier {
  late bool isDarkTheme;

  ThemeNotifier([bool isDarkTheme = false]) {
    this.isDarkTheme = isDarkTheme;
    _getCurrentTheme();
  }

  _getCurrentTheme() async {
    bool? mode = await StorageManager.readData(StorageManager.themeMode);
    if (mode != null) isDarkTheme = mode;
    notifyListeners();
  }

  /// Sets the actual theme mode in the Shared Preferences and notifies the listeners
  /// that the value has changed to apply it to the UI
  setMode(bool mode) {
    isDarkTheme = mode;
    StorageManager.saveData(StorageManager.themeMode, isDarkTheme);
    notifyListeners();
  }
}