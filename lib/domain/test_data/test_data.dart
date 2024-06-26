import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/alter_specific_data/alter_specific_data.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';

part 'test_data.g.dart';

@JsonSerializable()
class TestData {
  final String statsId;
  final int totalTests;
  final int testTotalCountWriting;
  final int testTotalCountReading;
  final int testTotalCountRecognition;
  final int testTotalCountListening;
  final int testTotalCountSpeaking;
  final int testTotalCountDefinition;
  final int testTotalCountGrammarPoint;
  final double testTotalWinRateWriting;
  final double testTotalWinRateReading;
  final double testTotalWinRateRecognition;
  final double testTotalWinRateListening;
  final double testTotalWinRateSpeaking;
  final double testTotalWinRateDefinition;
  final double testTotalWinRateGrammarPoint;
  final double testTotalSecondsPerWordWriting;
  final double testTotalSecondsPerWordReading;
  final double testTotalSecondsPerWordRecognition;
  final double testTotalSecondsPerWordListening;
  final double testTotalSecondsPerWordSpeaking;
  final double testTotalSecondsPerPointDefinition;
  final double testTotalSecondsPerPointGrammarPoint;
  final int selectionTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData selectionTestData;
  final int blitzTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData blitzTestData;
  final int remembranceTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData remembranceTestData;
  final int numberTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final AlterSpecificData numberTestData;
  final int lessPctTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData lessPctTestData;
  final int categoryTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData categoryTestData;
  final int folderTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData folderTestData;
  final int dailyTests;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SpecificData dailyTestData;

  const TestData({
    this.statsId = TestDataTableFields.statsMainId,
    required this.totalTests,
    required this.testTotalCountWriting,
    required this.testTotalCountReading,
    required this.testTotalCountRecognition,
    required this.testTotalCountListening,
    required this.testTotalCountSpeaking,
    required this.testTotalCountDefinition,
    required this.testTotalCountGrammarPoint,
    required this.testTotalWinRateWriting,
    required this.testTotalWinRateReading,
    required this.testTotalWinRateRecognition,
    required this.testTotalWinRateListening,
    required this.testTotalWinRateSpeaking,
    required this.testTotalWinRateDefinition,
    required this.testTotalWinRateGrammarPoint,
    required this.testTotalSecondsPerWordWriting,
    required this.testTotalSecondsPerWordReading,
    required this.testTotalSecondsPerWordRecognition,
    required this.testTotalSecondsPerWordListening,
    required this.testTotalSecondsPerWordSpeaking,
    required this.testTotalSecondsPerPointDefinition,
    required this.testTotalSecondsPerPointGrammarPoint,
    required this.selectionTests,
    required this.blitzTests,
    required this.remembranceTests,
    required this.numberTests,
    required this.lessPctTests,
    required this.categoryTests,
    required this.folderTests,
    required this.dailyTests,
    this.selectionTestData = SpecificData.empty,
    this.blitzTestData = SpecificData.empty,
    this.remembranceTestData = SpecificData.empty,
    this.numberTestData = AlterSpecificData.empty,
    this.lessPctTestData = SpecificData.empty,
    this.categoryTestData = SpecificData.empty,
    this.folderTestData = SpecificData.empty,
    this.dailyTestData = SpecificData.empty,
  });

  TestData copyWith({
    SpecificData testSpecs = SpecificData.empty,
    AlterSpecificData alterTestSpecs = AlterSpecificData.empty,
  }) {
    if (testSpecs.id != -1) {
      final test = Tests.values[testSpecs.id];
      return TestData(
        totalTests: totalTests,
        testTotalCountWriting: testTotalCountWriting,
        testTotalCountReading: testTotalCountReading,
        testTotalCountRecognition: testTotalCountRecognition,
        testTotalCountListening: testTotalCountListening,
        testTotalCountSpeaking: testTotalCountSpeaking,
        testTotalCountDefinition: testTotalCountDefinition,
        testTotalCountGrammarPoint: testTotalCountGrammarPoint,
        testTotalWinRateWriting: testTotalWinRateWriting,
        testTotalWinRateReading: testTotalWinRateReading,
        testTotalWinRateRecognition: testTotalWinRateRecognition,
        testTotalWinRateListening: testTotalWinRateListening,
        testTotalWinRateSpeaking: testTotalWinRateSpeaking,
        testTotalWinRateDefinition: testTotalWinRateDefinition,
        testTotalWinRateGrammarPoint: testTotalWinRateGrammarPoint,
        testTotalSecondsPerWordWriting: testTotalSecondsPerWordWriting,
        testTotalSecondsPerWordReading: testTotalSecondsPerWordReading,
        testTotalSecondsPerWordRecognition: testTotalSecondsPerWordRecognition,
        testTotalSecondsPerWordListening: testTotalSecondsPerWordListening,
        testTotalSecondsPerWordSpeaking: testTotalSecondsPerWordSpeaking,
        testTotalSecondsPerPointDefinition: testTotalSecondsPerPointDefinition,
        testTotalSecondsPerPointGrammarPoint:
            testTotalSecondsPerPointGrammarPoint,
        selectionTests: selectionTests,
        selectionTestData: test == Tests.lists ? testSpecs : selectionTestData,
        blitzTests: blitzTests,
        blitzTestData: test == Tests.blitz ? testSpecs : blitzTestData,
        remembranceTests: remembranceTests,
        remembranceTestData:
            test == Tests.time ? testSpecs : remembranceTestData,
        numberTests: numberTests,
        numberTestData: numberTestData,
        lessPctTests: lessPctTests,
        lessPctTestData: test == Tests.less ? testSpecs : lessPctTestData,
        categoryTests: categoryTests,
        categoryTestData:
            test == Tests.categories ? testSpecs : categoryTestData,
        folderTests: folderTests,
        folderTestData: test == Tests.folder ? testSpecs : folderTestData,
        dailyTests: dailyTests,
        dailyTestData: test == Tests.daily ? testSpecs : dailyTestData,
      );
    }
    final test = Tests.values[alterTestSpecs.id];
    return TestData(
      totalTests: totalTests,
      testTotalCountWriting: testTotalCountWriting,
      testTotalCountReading: testTotalCountReading,
      testTotalCountRecognition: testTotalCountRecognition,
      testTotalCountListening: testTotalCountListening,
      testTotalCountSpeaking: testTotalCountSpeaking,
      testTotalCountDefinition: testTotalCountDefinition,
      testTotalCountGrammarPoint: testTotalCountGrammarPoint,
      testTotalWinRateWriting: testTotalWinRateWriting,
      testTotalWinRateReading: testTotalWinRateReading,
      testTotalWinRateRecognition: testTotalWinRateRecognition,
      testTotalWinRateListening: testTotalWinRateListening,
      testTotalWinRateSpeaking: testTotalWinRateSpeaking,
      testTotalWinRateDefinition: testTotalWinRateDefinition,
      testTotalWinRateGrammarPoint: testTotalWinRateGrammarPoint,
      testTotalSecondsPerWordWriting: testTotalSecondsPerWordWriting,
      testTotalSecondsPerWordReading: testTotalSecondsPerWordReading,
      testTotalSecondsPerWordRecognition: testTotalSecondsPerWordRecognition,
      testTotalSecondsPerWordListening: testTotalSecondsPerWordListening,
      testTotalSecondsPerWordSpeaking: testTotalSecondsPerWordSpeaking,
      testTotalSecondsPerPointDefinition: testTotalSecondsPerPointDefinition,
      testTotalSecondsPerPointGrammarPoint:
          testTotalSecondsPerPointGrammarPoint,
      selectionTests: selectionTests,
      selectionTestData: selectionTestData,
      blitzTests: blitzTests,
      blitzTestData: blitzTestData,
      remembranceTests: remembranceTests,
      remembranceTestData: remembranceTestData,
      numberTests: numberTests,
      numberTestData: test == Tests.numbers ? alterTestSpecs : numberTestData,
      lessPctTests: lessPctTests,
      lessPctTestData: lessPctTestData,
      categoryTests: categoryTests,
      categoryTestData: categoryTestData,
      folderTests: folderTests,
      folderTestData: folderTestData,
      dailyTests: dailyTests,
      dailyTestData: dailyTestData,
    );
  }

  /// Empty instance of [TestData]
  static const TestData empty = TestData(
    statsId: TestDataTableFields.statsMainId,
    totalTests: 0,
    testTotalCountWriting: 0,
    testTotalCountReading: 0,
    testTotalCountRecognition: 0,
    testTotalCountListening: 0,
    testTotalCountSpeaking: 0,
    testTotalCountDefinition: 0,
    testTotalCountGrammarPoint: 0,
    testTotalWinRateWriting: 0,
    testTotalWinRateReading: 0,
    testTotalWinRateRecognition: 0,
    testTotalWinRateListening: 0,
    testTotalWinRateSpeaking: 0,
    testTotalWinRateDefinition: 0,
    testTotalWinRateGrammarPoint: 0,
    testTotalSecondsPerWordWriting: 0,
    testTotalSecondsPerWordReading: 0,
    testTotalSecondsPerWordRecognition: 0,
    testTotalSecondsPerWordListening: 0,
    testTotalSecondsPerWordSpeaking: 0,
    testTotalSecondsPerPointDefinition: 0,
    testTotalSecondsPerPointGrammarPoint: 0,
    selectionTests: 0,
    blitzTests: 0,
    remembranceTests: 0,
    numberTests: 0,
    lessPctTests: 0,
    categoryTests: 0,
    folderTests: 0,
    dailyTests: 0,
  );

  factory TestData.fromJson(Map<String, dynamic> json) =>
      _$TestDataFromJson(json);
  Map<String, dynamic> toJson() => _$TestDataToJson(this);
}
