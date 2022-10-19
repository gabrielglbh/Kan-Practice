import 'package:json_annotation/json_annotation.dart';

part 'specific_data.g.dart';

@JsonSerializable()
class SpecificData {
  final int id;
  final int totalWritingCount;
  final int totalReadingCount;
  final int totalRecognitionCount;
  final int totalListeningCount;
  final int totalSpeakingCount;
  final double totalWinRateWriting;
  final double totalWinRateReading;
  final double totalWinRateRecognition;
  final double totalWinRateListening;
  final double totalWinRateSpeaking;

  const SpecificData({
    required this.id,
    required this.totalWritingCount,
    required this.totalReadingCount,
    required this.totalRecognitionCount,
    required this.totalListeningCount,
    required this.totalSpeakingCount,
    required this.totalWinRateWriting,
    required this.totalWinRateReading,
    required this.totalWinRateRecognition,
    required this.totalWinRateListening,
    required this.totalWinRateSpeaking,
  });

  /// Empty instance of [BackUp]
  static const SpecificData empty = SpecificData(
    id: -1,
    totalWritingCount: 0,
    totalReadingCount: 0,
    totalRecognitionCount: 0,
    totalListeningCount: 0,
    totalSpeakingCount: 0,
    totalWinRateWriting: 0,
    totalWinRateReading: 0,
    totalWinRateRecognition: 0,
    totalWinRateListening: 0,
    totalWinRateSpeaking: 0,
  );

  factory SpecificData.fromJson(Map<String, dynamic> json) =>
      _$SpecificDataFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificDataToJson(this);
}
