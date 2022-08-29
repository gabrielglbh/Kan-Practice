class KanjiTableFields {
  static const String kanjiTable = "KANJI_TABLE";
  static const String kanjiField = "kanji";
  static const String listNameField = "name";
  static const String meaningField = "meaning";
  static const String pronunciationField = "pronunciation";
  static const String winRateWritingField = "winRateWriting";
  static const String winRateReadingField = "winRateReading";
  static const String winRateRecognitionField = "winRateRecognition";
  static const String winRateListeningField = "winRateListening";
  static const String winRateSpeakingField = "winRateSpeaking";
  static const String dateAddedField = "dateAdded";
  static const String dateLastShown = "dateLastShown";
  static const String dateLastShownWriting = "dateLastShownWriting";
  static const String dateLastShownReading = "dateLastShownReading";
  static const String dateLastShownRecognition = "dateLastShownRecognition";
  static const String dateLastShownListening = "dateLastShownListening";
  static const String dateLastShownSpeaking = "dateLastShownSpeaking";
  static const String categoryField = "category";
}

class KanListTableFields {
  static const String listsTable = "LISTS_TABLE";
  static const String nameField = "name";
  static const String totalWinRateWritingField = "totalWinRateWriting";
  static const String totalWinRateReadingField = "totalWinRateReading";
  static const String totalWinRateRecognitionField = "totalWinRateRecognition";
  static const String totalWinRateListeningField = "totalWinRateListening";
  static const String totalWinRateSpeakingField = "totalWinRateSpeaking";
  static const String lastUpdatedField = "lastUpdated";
}

class TestTableFields {
  static const String testTable = "TEST_RESULT_TABLE";
  static const String testIdField = "id";
  static const String takenDateField = "takenDate";
  static const String testScoreField = "score";
  static const String kanjiInTestField = "totalKanji";
  static const String kanjiListsField = "kanjiLists";
  static const String studyModeField = "studyMode";
  static const String testModeField = "testMode";
}

class KanListFolderRelationTableFields {
  static const String relTable = "FOLDER_RELATION_TABLE";
  static const String nameField = "folder";
  static const String kanListNameField = "kanListName";
}

class FolderTableFields {
  static const String folderTable = "FOLDER_TABLE";
  static const String nameField = "folder";
  static const String lastUpdatedField = "lastUpdated";
}

class WordHistoryFields {
  static const String historyTable = "WORD_HISTORY_TABLE";
  static const String wordField = "word";
  static const String searchedOnField = "searchedOn";
}

class TestDataTableFields {
  static const String statsMainId = "MAIN_STATS_TABLE";
  static const String testDataTable = "TEST_DATA_TABLE";
  static const String statsIdField = "statsId";
  static const String totalTestsField = "totalTests";
  static const String totalTestAccuracyField = "totalTestAccuracy";
  static const String testTotalCountWritingField = "testTotalCountWriting";
  static const String testTotalCountReadingField = "testTotalCountReading";
  static const String testTotalCountRecognitionField =
      "testTotalCountRecognition";
  static const String testTotalCountListeningField = "testTotalCountListening";
  static const String testTotalCountSpeakingField = "testTotalCountSpeaking";
  static const String testTotalWinRateWritingField = "testTotalWinRateWriting";
  static const String testTotalWinRateReadingField = "testTotalWinRateReading";
  static const String testTotalWinRateRecognitionField =
      "testTotalWinRateRecognition";
  static const String testTotalWinRateListeningField =
      "testTotalWinRateListening";
  static const String testTotalWinRateSpeakingField =
      "testTotalWinRateSpeaking";
  static const String selectionTestsField = "selectionTests";
  static const String blitzTestsField = "blitzTests";
  static const String remembranceTestsField = "remembranceTests";
  static const String numberTestsField = "numberTests";
  static const String lessPctTestsField = "lessPctTests";
  static const String categoryTestsField = "categoryTests";
  static const String folderTestsField = "folderTests";
  static const String dailyTestsField = "dailyTests";
}

class TestSpecificDataTableFields {
  static const String testDataTable = "TEST_SPECIFIC_ACC_TABLE";
  static const String idField = "id";
  static const String totalWritingCountField = "totalWritingCount";
  static const String totalReadingCountField = "totalReadingCount";
  static const String totalRecognitionCountField = "totalRecognitionCount";
  static const String totalListeningCountField = "totalListeningCount";
  static const String totalSpeakingCountField = "totalSpeakingCount";
  static const String totalWinRateWritingField = "totalWinRateWriting";
  static const String totalWinRateReadingField = "totalWinRateReading";
  static const String totalWinRateRecognitionField = "totalWinRateRecognition";
  static const String totalWinRateListeningField = "totalWinRateListening";
  static const String totalWinRateSpeakingField = "totalWinRateSpeaking";
}

class DatabaseConstants {
  static const double emptyWinRate = -1;
}
