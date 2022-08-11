import 'package:json_annotation/json_annotation.dart';

part 'test_data.g.dart';

@JsonSerializable()
class TestData {
  final int totalTests;
  final double totalTestAccuracy;
  final int testTotalCountWriting;
  final int testTotalCountReading;
  final int testTotalCountRecognition;
  final int testTotalCountListening;
  final double testTotalWinRateWriting;
  final double testTotalWinRateReading;
  final double testTotalWinRateRecognition;
  final double testTotalWinRateListening;
  final int selectionTests;
  final int blitzTests;
  final int remembranceTests;
  final int numberTests;
  final int lessPctTests;
  final int categoryTests;
  final int folderTests;
  final int dailyTests;

  const TestData({
    required this.totalTests,
    required this.totalTestAccuracy,
    required this.testTotalCountWriting,
    required this.testTotalCountReading,
    required this.testTotalCountRecognition,
    required this.testTotalCountListening,
    required this.testTotalWinRateWriting,
    required this.testTotalWinRateReading,
    required this.testTotalWinRateRecognition,
    required this.testTotalWinRateListening,
    required this.selectionTests,
    required this.blitzTests,
    required this.remembranceTests,
    required this.numberTests,
    required this.lessPctTests,
    required this.categoryTests,
    required this.folderTests,
    required this.dailyTests,
  });

  /// Empty instance of [BackUp]
  static const TestData empty = TestData(
    totalTests: 0,
    totalTestAccuracy: 0,
    testTotalCountWriting: 0,
    testTotalCountReading: 0,
    testTotalCountRecognition: 0,
    testTotalCountListening: 0,
    testTotalWinRateWriting: 0,
    testTotalWinRateReading: 0,
    testTotalWinRateRecognition: 0,
    testTotalWinRateListening: 0,
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
