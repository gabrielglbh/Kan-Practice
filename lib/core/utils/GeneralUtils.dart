import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:package_info/package_info.dart';
import 'package:timeago/timeago.dart' as t;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Class that contains useful methods for all classes to use
class GeneralUtils {
  /// Returns the color based on the given [winRate]
  static Color getColorBasedOnWinRate(double winRate) {
    if (winRate >= 0 && winRate <= 0.1) return Colors.redAccent.shade700;
    else if (winRate > 0.1 && winRate <= 0.2) return Colors.redAccent.shade200;
    else if (winRate > 0.2 && winRate <= 0.3) return Colors.redAccent.shade100;
    else if (winRate > 0.3 && winRate <= 0.4) return Colors.yellow;
    else if (winRate > 0.4 && winRate <= 0.5) return Colors.yellow.shade400;
    else if (winRate > 0.5 && winRate <= 0.6) return Colors.yellow.shade300;
    else if (winRate > 0.6 && winRate <= 0.7) return Colors.yellow.shade200;
    else if (winRate > 0.7 && winRate <= 0.8) return Colors.green.shade100;
    else if (winRate > 0.8 && winRate <= 0.9) return Colors.green.shade300;
    else if (winRate > 0.9 && winRate <= 1) return Colors.green;
    else return Colors.white;
  }

  /// Returns the color based on the given [score]
  static Color getColorBasedOnScore(double score) {
    if (score >= 0 && score <= 0.2) return Colors.green.shade50;
    else if (score > 0.2 && score <= 0.4) return Colors.green.shade200;
    else if (score > 0.4 && score <= 0.6) return Colors.green.shade300;
    else if (score > 0.6 && score <= 0.8) return Colors.green.shade400;
    else if (score > 0.8 && score <= 1) return Colors.green;
    else return Colors.white;
  }

  /// Returns the text color based on the given [score]
  static Color getTextColorBasedOnScore(double score) {
    if (score >= 0 && score <= 0.2) return Colors.black;
    else if (score > 0.2 && score <= 0.4) return Colors.black;
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

  static String getFixedDouble(double d) => d.toStringAsFixed(2);

  /// Parses the [date] that should be in milliseconds to a [DateTime] object
  /// and applies a parser with the time_ago package
  static String parseDateMilliseconds(BuildContext context, int date) {
    final _d = DateTime.fromMillisecondsSinceEpoch(date);
    Duration e = DateTime.now().difference(_d);
    return t.format(DateTime.now().subtract(e), locale: (EasyLocalization.of(context)?.currentLocale?.languageCode ?? "en"));
  }

  static Future<void> showVersionNotes(BuildContext context, {String? version}) async {
    PackageInfo pi = await PackageInfo.fromPlatform();
    List<String> notes = await BackUpRecords.instance.getVersionNotes(context);
    Text child = Text("");
    String versionNotes = "";
    if (notes.isNotEmpty) {
      notes.forEach((note) => versionNotes = versionNotes + "$note\n");
      child = Text(versionNotes);
    }

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomDialog(
          title: Text(
            version != null
              ? "kanji_lists_versionDialog_title".tr()
              : "${"kanji_lists_versionDialog_notes".tr()} ${pi.version}"
          ),
          content: version != null ? Wrap(
            children: [
              Text("${"kanji_lists_versionDialog_notes".tr()} $version\n"),
              child
            ],
          ) : child,
          positiveButtonText: version != null ? 'kanji_lists_versionDialog_button_label'.tr() : 'Ok',
          onPositive: () async {
            if (version != null) {
              if (await canLaunch("google_play_link".tr()))
                await launch("google_play_link".tr());
            }
          },
        );
      },
    );
  }
}