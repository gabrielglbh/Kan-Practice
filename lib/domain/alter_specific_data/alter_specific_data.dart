import 'package:json_annotation/json_annotation.dart';

part 'alter_specific_data.g.dart';

@JsonSerializable()
class AlterSpecificData {
  final int id;
  final int totalNumberTestCount;
  final double totalWinRateNumberTest;

  const AlterSpecificData({
    required this.id,
    required this.totalNumberTestCount,
    required this.totalWinRateNumberTest,
  });

  /// Empty instance of [BackUp]
  static const AlterSpecificData empty = AlterSpecificData(
    id: -1,
    totalNumberTestCount: 0,
    totalWinRateNumberTest: 0,
  );

  factory AlterSpecificData.fromJson(Map<String, dynamic> json) =>
      _$AlterSpecificDataFromJson(json);
  Map<String, dynamic> toJson() => _$AlterSpecificDataToJson(this);
}
