import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';
import 'package:kanpractice/core/types/test_modes.dart';

part 'test_data.g.dart';

@JsonSerializable()
class TestData {
  final String statsId;
  final int totalTests;
  final double totalTestAccuracy;
  final int testTotalCountWriting;
  final int testTotalCountReading;
  final int testTotalCountRecognition;
  final int testTotalCountListening;
  final int testTotalCountSpeaking;
  final double testTotalWinRateWriting;
  final double testTotalWinRateReading;
  final double testTotalWinRateRecognition;
  final double testTotalWinRateListening;
  final double testTotalWinRateSpeaking;
  final int selectionTests;
  final TestSpecificData selectionTestData;
  final int blitzTests;
  final TestSpecificData blitzTestData;
  final int remembranceTests;
  final TestSpecificData remembranceTestData;
  final int numberTests;
  final TestSpecificData numberTestData;
  final int lessPctTests;
  final TestSpecificData lessPctTestData;
  final int categoryTests;
  final TestSpecificData categoryTestData;
  final int folderTests;
  final TestSpecificData folderTestData;
  final int dailyTests;
  final TestSpecificData dailyTestData;

  const TestData({
    this.statsId = TestDataTableFields.statsMainId,
    required this.totalTests,
    required this.totalTestAccuracy,
    required this.testTotalCountWriting,
    required this.testTotalCountReading,
    required this.testTotalCountRecognition,
    required this.testTotalCountListening,
    required this.testTotalCountSpeaking,
    required this.testTotalWinRateWriting,
    required this.testTotalWinRateReading,
    required this.testTotalWinRateRecognition,
    required this.testTotalWinRateListening,
    required this.testTotalWinRateSpeaking,
    required this.selectionTests,
    required this.selectionTestData,
    required this.blitzTests,
    required this.blitzTestData,
    required this.remembranceTests,
    required this.remembranceTestData,
    required this.numberTests,
    required this.numberTestData,
    required this.lessPctTests,
    required this.lessPctTestData,
    required this.categoryTests,
    required this.categoryTestData,
    required this.folderTests,
    required this.folderTestData,
    required this.dailyTests,
    required this.dailyTestData,
  });

  TestData copyWith(TestSpecificData testSpecs) {
    final test = TestsUtils.mapTestMode(testSpecs.id);
    return TestData(
      totalTests: totalTests,
      totalTestAccuracy: totalTestAccuracy,
      testTotalCountWriting: testTotalCountWriting,
      testTotalCountReading: testTotalCountReading,
      testTotalCountRecognition: testTotalCountRecognition,
      testTotalCountListening: testTotalCountListening,
      testTotalCountSpeaking: testTotalCountSpeaking,
      testTotalWinRateWriting: testTotalWinRateWriting,
      testTotalWinRateReading: testTotalWinRateReading,
      testTotalWinRateRecognition: testTotalWinRateRecognition,
      testTotalWinRateListening: testTotalWinRateListening,
      testTotalWinRateSpeaking: testTotalWinRateSpeaking,
      selectionTests: selectionTests,
      selectionTestData: test == Tests.lists ? testSpecs : selectionTestData,
      blitzTests: blitzTests,
      blitzTestData: test == Tests.blitz ? testSpecs : blitzTestData,
      remembranceTests: remembranceTests,
      remembranceTestData: test == Tests.time ? testSpecs : remembranceTestData,
      numberTests: numberTests,
      numberTestData: test == Tests.numbers ? testSpecs : numberTestData,
      lessPctTests: lessPctTests,
      lessPctTestData: test == Tests.less ? testSpecs : lessPctTestData,
      categoryTests: categoryTests,
      categoryTestData: test == Tests.categories ? testSpecs : categoryTestData,
      folderTests: folderTests,
      folderTestData: test == Tests.folder ? testSpecs : folderTestData,
      dailyTests: dailyTests,
      dailyTestData: test == Tests.daily ? testSpecs : dailyTestData,
    );
  }

  /// Empty instance of [BackUp]
  static const TestData empty = TestData(
    totalTests: 0,
    totalTestAccuracy: 0,
    testTotalCountWriting: 0,
    testTotalCountReading: 0,
    testTotalCountRecognition: 0,
    testTotalCountListening: 0,
    testTotalCountSpeaking: 0,
    testTotalWinRateWriting: 0,
    testTotalWinRateReading: 0,
    testTotalWinRateRecognition: 0,
    testTotalWinRateListening: 0,
    testTotalWinRateSpeaking: 0,
    selectionTests: 0,
    selectionTestData: TestSpecificData.empty,
    blitzTests: 0,
    blitzTestData: TestSpecificData.empty,
    remembranceTests: 0,
    remembranceTestData: TestSpecificData.empty,
    numberTests: 0,
    numberTestData: TestSpecificData.empty,
    lessPctTests: 0,
    lessPctTestData: TestSpecificData.empty,
    categoryTests: 0,
    categoryTestData: TestSpecificData.empty,
    folderTests: 0,
    folderTestData: TestSpecificData.empty,
    dailyTests: 0,
    dailyTestData: TestSpecificData.empty,
  );

  factory TestData.fromJson(Map<String, dynamic> json) =>
      _$TestDataFromJson(json);
  Map<String, dynamic> toJson() => _$TestDataToJson(this);
}
