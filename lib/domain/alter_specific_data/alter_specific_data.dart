import 'package:json_annotation/json_annotation.dart';

part 'alter_specific_data.g.dart';

@JsonSerializable()
class AlterSpecificData {
  final int id;
  final int totalNumberTestCount;
  final int totalTranslationTestCount;
  final double totalWinRateNumberTest;
  final double totalWinRateTranslationTest;

  const AlterSpecificData({
    required this.id,
    required this.totalNumberTestCount,
    required this.totalTranslationTestCount,
    required this.totalWinRateNumberTest,
    required this.totalWinRateTranslationTest,
  });

  /// Empty instance of [BackUp]
  static const AlterSpecificData empty = AlterSpecificData(
    id: -1,
    totalNumberTestCount: 0,
    totalTranslationTestCount: 0,
    totalWinRateNumberTest: 0,
    totalWinRateTranslationTest: 0,
  );

  factory AlterSpecificData.fromJson(Map<String, dynamic> json) =>
      _$AlterSpecificDataFromJson(json);
  Map<String, dynamic> toJson() => _$AlterSpecificDataToJson(this);
}
