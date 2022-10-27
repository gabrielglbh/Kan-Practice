part of 'study_mode_bloc.dart';

class SMAlgorithm {
  /// Days from today to review the word again
  final int interval;

  /// Milliseconds of the proposed interval to review the word again
  final int intervalAsDate;
  final int repetitions;
  final double easeFactor;

  SMAlgorithm({
    required this.interval,
    required this.intervalAsDate,
    required this.repetitions,
    required this.easeFactor,
  });

  /// See https://github.com/thyagoluciano/sm2
  ///
  /// Takes today's score and calulates next iterations based on SM2 params
  factory SMAlgorithm.calc({
    required double quality,
    required int repetitions,
    required int previousInterval,
    required double previousEaseFactor,
  }) {
    int interval;
    double easeFactor;
    // This is based on the win rate of the Word in a ceratin Study Mode
    // In the SM2 paper, the quality must be 0 to 5, so we just round it
    // up to match the percentage to the range.
    int qualityParsed = (quality * 5).round();

    if (qualityParsed >= 3) {
      switch (repetitions) {
        case 0:
          interval = 1;
          break;
        case 1:
          interval = 6;
          break;
        default:
          interval = (previousInterval * previousEaseFactor).round();
      }

      repetitions++;
      easeFactor = previousEaseFactor +
          (0.1 - (5 - qualityParsed) * (0.08 + (5 - qualityParsed) * 0.02));
    } else {
      repetitions = 0;
      interval = 1;
      easeFactor = previousEaseFactor;
    }

    if (easeFactor < 1.3) easeFactor = 1.3;

    final intervalAsDate =
        DateTime.now().add(Duration(days: interval)).millisecondsSinceEpoch;

    return SMAlgorithm(
      interval: interval,
      intervalAsDate: intervalAsDate,
      repetitions: repetitions,
      easeFactor: easeFactor,
    );
  }
}
