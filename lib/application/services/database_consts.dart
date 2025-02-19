class WordTableFields {
  static const String wordTable = "KANJI_TABLE";
  static const String wordField = "kanji";
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
  static const String repetitionsWritingField = "repetitionsWriting";
  static const String previousEaseFactorWritingField =
      "previousEaseFactorWriting";
  static const String previousIntervalWritingField = "previousIntervalWriting";
  static const String previousIntervalAsDateWritingField =
      "previousIntervalAsDateWriting";
  static const String repetitionsReadingField = "repetitionsReading";
  static const String previousEaseFactorReadingField =
      "previousEaseFactorReading";
  static const String previousIntervalReadingField = "previousIntervalReading";
  static const String previousIntervalAsDateReadingField =
      "previousIntervalAsDateReading";
  static const String repetitionsRecognitionField = "repetitionsRecognition";
  static const String previousEaseFactorRecognitionField =
      "previousEaseFactorRecognition";
  static const String previousIntervalRecognitionField =
      "previousIntervalRecognition";
  static const String previousIntervalAsDateRecognitionField =
      "previousIntervalAsDateRecognition";
  static const String repetitionsListeningField = "repetitionsListening";
  static const String previousEaseFactorListeningField =
      "previousEaseFactorListening";
  static const String previousIntervalListeningField =
      "previousIntervalListening";
  static const String previousIntervalAsDateListeningField =
      "previousIntervalAsDateListening";
  static const String repetitionsSpeakingField = "repetitionsSpeaking";
  static const String previousEaseFactorSpeakingField =
      "previousEaseFactorSpeaking";
  static const String previousIntervalSpeakingField =
      "previousIntervalSpeaking";
  static const String previousIntervalAsDateSpeakingField =
      "previousIntervalAsDateSpeaking";
}

class ListTableFields {
  static const String listsTable = "LISTS_TABLE";
  static const String nameField = "name";
  static const String totalWinRateWritingField = "totalWinRateWriting";
  static const String totalWinRateReadingField = "totalWinRateReading";
  static const String totalWinRateRecognitionField = "totalWinRateRecognition";
  static const String totalWinRateListeningField = "totalWinRateListening";
  static const String totalWinRateSpeakingField = "totalWinRateSpeaking";
  static const String totalWinRateDefinitionField = "totalWinRateDefinition";
  static const String totalWinRateGrammarPointField =
      "totalWinRateGrammarPoint";
  static const String lastUpdatedField = "lastUpdated";
}

class TestTableFields {
  static const String testTable = "TEST_RESULT_TABLE";
  static const String testIdField = "id";
  static const String takenDateField = "takenDate";
  static const String testScoreField = "score";
  static const String wordsInTestField = "totalKanji";
  static const String wordsListsField = "kanjiLists";
  static const String studyModeField = "studyMode";
  static const String testModeField = "testMode";
  static const String grammarModeField = "grammarMode";
}

class RelationFolderListTableFields {
  static const String relTable = "FOLDER_RELATION_TABLE";
  static const String nameField = "folder";
  static const String listNameField = "kanListName";
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
  static const String testTotalCountWritingField = "testTotalCountWriting";
  static const String testTotalCountReadingField = "testTotalCountReading";
  static const String testTotalCountRecognitionField =
      "testTotalCountRecognition";
  static const String testTotalCountListeningField = "testTotalCountListening";
  static const String testTotalCountSpeakingField = "testTotalCountSpeaking";
  static const String testTotalCountDefinitionField =
      "testTotalCountDefinition";
  static const String testTotalCountGrammarPointField =
      "testTotalCountGrammarPoint";
  static const String testTotalWinRateWritingField = "testTotalWinRateWriting";
  static const String testTotalWinRateReadingField = "testTotalWinRateReading";
  static const String testTotalWinRateRecognitionField =
      "testTotalWinRateRecognition";
  static const String testTotalWinRateListeningField =
      "testTotalWinRateListening";
  static const String testTotalWinRateSpeakingField =
      "testTotalWinRateSpeaking";
  static const String testTotalWinRateDefinitionField =
      "testTotalWinRateDefinition";
  static const String testTotalWinRateGrammarPointField =
      "testTotalWinRateGrammarPoint";
  static const String testTotalSecondsPerWordWritingField =
      "testTotalSecondsPerWordWriting";
  static const String testTotalSecondsPerWordReadingField =
      "testTotalSecondsPerWordReading";
  static const String testTotalSecondsPerWordRecognitionField =
      "testTotalSecondsPerWordRecognition";
  static const String testTotalSecondsPerWordListeningField =
      "testTotalSecondsPerWordListening";
  static const String testTotalSecondsPerWordSpeakingField =
      "testTotalSecondsPerWordSpeaking";
  static const String testTotalSecondsPerPointGrammarPointField =
      "testTotalSecondsPerPointGrammarPoint";
  static const String testTotalSecondsPerPointDefinitionField =
      "testTotalSecondsPerPointDefinition";
  static const String selectionTestsField = "selectionTests";
  static const String blitzTestsField = "blitzTests";
  static const String remembranceTestsField = "remembranceTests";
  static const String numberTestsField = "numberTests";
  static const String lessPctTestsField = "lessPctTests";
  static const String categoryTestsField = "categoryTests";
  static const String folderTestsField = "folderTests";
  static const String dailyTestsField = "dailyTests";
  static const String translationTestsField = "translationTests";
}

class TestSpecificDataTableFields {
  static const String testDataTable = "TEST_SPECIFIC_ACC_TABLE";
  static const String idField = "id";
  static const String totalWritingCountField = "totalWritingCount";
  static const String totalReadingCountField = "totalReadingCount";
  static const String totalRecognitionCountField = "totalRecognitionCount";
  static const String totalListeningCountField = "totalListeningCount";
  static const String totalSpeakingCountField = "totalSpeakingCount";
  static const String totalDefinitionCountField = "totalDefinitionCount";
  static const String totalGrammarPointCountField = "totalGrammarPointCount";
  static const String totalWinRateWritingField = "totalWinRateWriting";
  static const String totalWinRateReadingField = "totalWinRateReading";
  static const String totalWinRateRecognitionField = "totalWinRateRecognition";
  static const String totalWinRateListeningField = "totalWinRateListening";
  static const String totalWinRateSpeakingField = "totalWinRateSpeaking";
  static const String totalWinRateDefinitionField = "totalWinRateDefinition";
  static const String totalWinRateGrammarPointField =
      "totalWinRateGrammarPoint";
}

class AlterTestSpecificDataTableFields {
  static const String testDataTable = "ALTER_TEST_SPECIFIC_ACC_TABLE";
  static const String idField = "id";
  static const String totalNumberTestCountField = "totalNumberTestCount";
  static const String totalTranslationTestCountField =
      "totalTranslationTestCount";
  static const String totalWinRateNumberTestField = "totalWinRateNumberTest";
  static const String totalWinRateTranslationTestField =
      "totalWinRateTranslationTest";
}

class GrammarTableFields {
  static const String grammarTable = "GRAMMAR_TABLE";
  static const String nameField = "name";
  static const String definitionField = "definition";
  static const String exampleField = "example";
  static const String listNameField = "listName";
  static const String winRateDefinitionField = "winRateDefinition";
  static const String winRateGrammarPointField = "winRateGrammarPoint";
  static const String dateAddedField = "dateAdded";
  static const String dateLastShownField = "dateLastShown";
  static const String dateLastShownDefinitionField = "dateLastShownDefinition";
  static const String repetitionsDefinitionField = "repetitionsDefinition";
  static const String previousEaseFactorDefinitionField =
      "previousEaseFactorDefinition";
  static const String previousIntervalDefinitionField =
      "previousIntervalDefinition";
  static const String previousIntervalAsDateDefinitionField =
      "previousIntervalAsDateDefinition";
  static const String dateLastShownGrammarPointField =
      "dateLastShownGrammarPoint";
  static const String repetitionsGrammarPointField = "repetitionsGrammarPoint";
  static const String previousEaseFactorGrammarPointField =
      "previousEaseFactorGrammarPoint";
  static const String previousIntervalGrammarPointField =
      "previousIntervalGrammarPoint";
  static const String previousIntervalAsDateGrammarPointField =
      "previousIntervalAsDateGrammarPoint";
}

class DatabaseConstants {
  static const double emptyWinRate = -1;
}
