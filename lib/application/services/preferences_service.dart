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
  static const String enableRepetitionOnTests = "enableRepetitionOnTests";

  static const String writingDailyNotification = "writingDailyNotification";
  static const String readingDailyNotification = "readingDailyNotification";
  static const String recognitionDailyNotification =
      "recognitionDailyNotification";
  static const String listeningDailyNotification = "listeningDailyNotification";
  static const String speakingDailyNotification = "speakingDailyNotification";
  static const String definitionDailyNotification =
      "definitionDailyNotification";

  static const String dailyTestOnControlledPace = "dailyTestOnControlledPace";
  static const String writingDailyPerformed = "writingDailyPerformed";
  static const String readingDailyPerformed = "readingDailyPerformed";
  static const String recognitionDailyPerformed = "recognitionDailyPerformed";
  static const String listeningDailyPerformed = "listeningDailyPerformed";
  static const String speakingDailyPerformed = "speakingDailyPerformed";
  static const String definitionDailyPerformed = "definitionDailyPerformed";

  static const String showGrammarGraphs = "showGrammarGraphs";
}
