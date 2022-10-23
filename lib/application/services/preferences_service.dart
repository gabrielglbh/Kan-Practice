import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';

@injectable
class PreferencesService {
  final IPreferencesRepository _preferencesRepository;

  PreferencesService(this._preferencesRepository);

  dynamic saveData(String key, dynamic value) {
    _preferencesRepository.saveData(key, value);
  }

  dynamic readData(String key) => _preferencesRepository.readData(key);
}

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
