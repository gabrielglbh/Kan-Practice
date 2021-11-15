import 'package:easy_localization/easy_localization.dart';
import 'package:timeago/timeago.dart' as t;
import 'package:flutter/material.dart';

/// Class that contains useful methods for all classes to use
class GeneralUtils {
  /// Returns the color based on the given [winRate]
  static Color getColorBasedOnWinRate(double winRate) {
    if (winRate >= 0 && winRate <= 0.1) return Colors.redAccent[400]!;
    else if (winRate > 0.1 && winRate <= 0.2) return Colors.redAccent[200]!;
    else if (winRate > 0.2 && winRate <= 0.3) return Colors.redAccent[100]!;
    else if (winRate > 0.3 && winRate <= 0.4) return Colors.yellow;
    else if (winRate > 0.4 && winRate <= 0.5) return Colors.yellow[400]!;
    else if (winRate > 0.5 && winRate <= 0.6) return Colors.yellow[300]!;
    else if (winRate > 0.6 && winRate <= 0.7) return Colors.yellow[200]!;
    else if (winRate > 0.7 && winRate <= 0.8) return Colors.green[100]!;
    else if (winRate > 0.8 && winRate <= 0.9) return Colors.green[300]!;
    else if (winRate > 0.9 && winRate <= 1) return Colors.green;
    else return Colors.white;
  }

  /// Creates a snack bar with the given [message]
  static getSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: Duration(seconds: 2))
      );
  }

  /// Transforms the current time to milliseconds
  static int getCurrentMilliseconds() => DateTime.now().millisecondsSinceEpoch;

  /// Parses the [date] that should be in milliseconds to a [DateTime] object
  /// and applies a parser with the time_ago package
  static String parseDateMilliseconds(BuildContext context, int date) {
    final _d = DateTime.fromMillisecondsSinceEpoch(date);
    Duration e = DateTime.now().difference(_d);
    return t.format(DateTime.now().subtract(e), locale: (EasyLocalization.of(context)?.currentLocale?.languageCode ?? "en"));
  }
}