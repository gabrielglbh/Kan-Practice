import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static final String themeMode = "themeMode";
  static final String filtersOnList = "listFilters";
  static final String orderOnList = "listOrder";
  static final String hasDoneTutorial = "hasDoneTutorial";
  static final String affectOnPractice = "affectOnPractice";
  static final String kanListGraphVisualization = "kanListGraphVisualization";
  static final String haveSeenKanListCoachMark = "haveSeenKanListCoachMark";
  static final String haveSeenKanListDetailCoachMark = "haveSeenKanListDetailCoachMark";

  static StorageManager? _storageUtils;
  static SharedPreferences? _preferences;

  /// Creates a singleton for the shared preferences
  static Future<StorageManager?> getInstance() async {
    if (_storageUtils == null) {
      var sec = StorageManager._();
      await sec._init();
      _storageUtils = sec;
    }
    return _storageUtils;
  }

  StorageManager._();

  Future _init() async => _preferences = await SharedPreferences.getInstance();

  /// Saves a dynamic [value] [String], [int] or [bool] into the Shared Preferences
  /// with a defined [key]
  static saveData(String key, dynamic value) {
    if (value is int) {
      _preferences?.setInt(key, value);
    } else if (value is String) {
      _preferences?.setString(key, value);
    } else if (value is bool) {
      _preferences?.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  /// Reads the data from the Share Preferences based on the given [key]
  static dynamic readData(String key) => _preferences?.get(key);
}