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
  @JsonKey(ignore: true)
  final TestSpecificData selectionTestData;
  final int blitzTests;
  @JsonKey(ignore: true)
  final TestSpecificData blitzTestData;
  final int remembranceTests;
  @JsonKey(ignore: true)
  final TestSpecificData remembranceTestData;
  final int numberTests;
  @JsonKey(ignore: true)
  final TestSpecificData numberTestData;
  final int lessPctTests;
  @JsonKey(ignore: true)
  final TestSpecificData lessPctTestData;
  final int categoryTests;
  @JsonKey(ignore: true)
  final TestSpecificData categoryTestData;
  final int folderTests;
  @JsonKey(ignore: true)
  final TestSpecificData folderTestData;
  final int dailyTests;
  @JsonKey(ignore: true)
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
    required this.blitzTests,
    required this.remembranceTests,
    required this.numberTests,
    required this.lessPctTests,
    required this.categoryTests,
    required this.folderTests,
    required this.dailyTests,
    this.selectionTestData = TestSpecificData.empty,
    this.blitzTestData = TestSpecificData.empty,
    this.remembranceTestData = TestSpecificData.empty,
    this.numberTestData = TestSpecificData.empty,
    this.lessPctTestData = TestSpecificData.empty,
    this.categoryTestData = TestSpecificData.empty,
    this.folderTestData = TestSpecificData.empty,
    this.dailyTestData = TestSpecificData.empty,
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
