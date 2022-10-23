import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedKeys {
  static const String themeMode = "themeMode";
  static const String filtersOnList = "listFilters";
  static const String filtersOnFolder = "folderFilters";
  static const String filtersOnMarket = "marketFilters";
  static const String orderOnList = "listOrder";
  static const String orderOnFolder = "folderOrder";
  static const String orderOnMarket = "marketOrder";
  static const String hasDoneTutorial = "hasDoneTutorial";
  static const String affectOnPractice = "affectOnPractice";
  static const String kanListListVisualization = "kanListListVisualization";
  static const String haveSeenKanListCoachMark = "haveSeenKanListCoachMark";
  static const String haveSeenKanListDetailCoachMark =
      "haveSeenKanListDetailCoachMark";
  static const String numberOfKanjiInTest = "numberOfKanjiInTest";
  static const String folderWhenOnTest = "folderWhenOnTest";
}

@LazySingleton(as: IPreferencesRepository)
class PreferencesRepositoryImpl implements IPreferencesRepository {
  final SharedPreferences? _preferences;

  PreferencesRepositoryImpl(this._preferences);

  @override
  saveData(String key, dynamic value) {
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

  @override
  dynamic readData(String key) => _preferences?.get(key);
}
