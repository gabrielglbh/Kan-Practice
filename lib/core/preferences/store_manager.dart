import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String themeMode = "themeMode";
  static const String filtersOnList = "listFilters";
  static const String filtersOnMarket = "marketFilters";
  static const String orderOnList = "listOrder";
  static const String orderOnMarket = "marketOrder";
  static const String hasDoneTutorial = "hasDoneTutorial";
  static const String affectOnPractice = "affectOnPractice";
  static const String kanListGraphVisualization = "kanListGraphVisualization";
  static const String haveSeenKanListCoachMark = "haveSeenKanListCoachMark";
  static const String haveSeenKanListDetailCoachMark = "haveSeenKanListDetailCoachMark";
  static const String numberOfKanjiInTest = "numberOfKanjiInTest";

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