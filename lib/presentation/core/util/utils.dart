import 'package:easy_localization/easy_localization.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timeago/timeago.dart' as t;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExtension on String {
  String get capitalized {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

/// Class that contains useful methods for all classes to use
class Utils {
  /// Returns the color based on the given [winRate]
  static Color getColorBasedOnWinRate(double winRate) {
    if (winRate >= 0 && winRate <= 0.1) {
      return Colors.redAccent.shade700;
    } else if (winRate > 0.1 && winRate <= 0.2) {
      return Colors.redAccent.shade200;
    } else if (winRate > 0.2 && winRate <= 0.3) {
      return Colors.redAccent.shade100;
    } else if (winRate > 0.3 && winRate <= 0.4) {
      return Colors.yellow;
    } else if (winRate > 0.4 && winRate <= 0.5) {
      return Colors.yellow.shade400;
    } else if (winRate > 0.5 && winRate <= 0.6) {
      return Colors.yellow.shade300;
    } else if (winRate > 0.6 && winRate <= 0.7) {
      return Colors.yellow.shade200;
    } else if (winRate > 0.7 && winRate <= 0.8) {
      return Colors.green.shade100;
    } else if (winRate > 0.8 && winRate <= 0.9) {
      return Colors.green.shade300;
    } else if (winRate > 0.9 && winRate <= 1) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  /// Returns the color based on the given [score]
  static Color getColorBasedOnScore(double score) {
    if (score >= 0 && score <= 0.2) {
      return Colors.green.shade50;
    } else if (score > 0.2 && score <= 0.4) {
      return Colors.green.shade200;
    } else if (score > 0.4 && score <= 0.6) {
      return Colors.green.shade300;
    } else if (score > 0.6 && score <= 0.8) {
      return Colors.green.shade400;
    } else if (score > 0.8 && score <= 1) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  static String getFixedPercentageAsString(double rate) {
    return "${roundUpAsString(getFixedDouble(rate * 100))}%";
  }

  static double getFixedPercentage(double rate) {
    return double.parse(getFixedDouble(rate * 100));
  }

  /// Opens up a [url]
  static Future<void> launch(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      getSnackBar(context, "launch_url_failed".tr());
    }
  }

  /// Returns the text color based on the given [score]
  static Color getTextColorBasedOnScore(double score) {
    if (score >= 0 && score <= 0.2) {
      return Colors.black;
    } else if (score > 0.2 && score <= 0.4) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static String roundUpAsString(String num) {
    if (num == "NaN") return "0";
    bool isRounded = num.substring(3) == "00" // XX.00%
        ||
        num.substring(2) == "00" // X.00%
        ||
        num.substring(4) == "00"; // XXX.00%
    return isRounded ? num.substring(0, num.length - 3) : num;
  }

  /// Creates a snack bar with the given [message]
  static getSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(children: [
            const Padding(
              padding: EdgeInsets.only(right: KPMargins.margin8),
              child: Icon(Icons.info_rounded, color: Colors.white),
            ),
            Expanded(child: Text(message)),
          ]),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  /// Transforms the current time to milliseconds
  static int getCurrentMilliseconds() => DateTime.now().millisecondsSinceEpoch;

  static Future<String> parseTodayDate(BuildContext context) async {
    final locale =
        EasyLocalization.of(context)?.currentLocale?.languageCode ?? "en";
    await initializeDateFormatting(locale, null);
    final today = DateTime.now();
    final formatter = DateFormat.yMd();
    return formatter.format(today);
  }

  static String getFixedDouble(double d) => d.toStringAsFixed(2);

  /// Parses the [date] that should be in milliseconds to a [DateTime] object
  /// and applies a parser with the time_ago package
  static String parseDateMilliseconds(BuildContext context, int date) {
    final d = DateTime.fromMillisecondsSinceEpoch(date);
    Duration e = DateTime.now().difference(d);
    return t.format(DateTime.now().subtract(e),
        locale: (EasyLocalization.of(context)?.currentLocale?.languageCode ??
            "en"));
  }

  static Future<void> showVersionNotes(
    BuildContext context, {
    String? version,
    List<String> notes = const [],
  }) async {
    PackageInfo pi = await PackageInfo.fromPlatform();
    Text child = const Text("");
    String versionNotes = "";
    if (notes.isNotEmpty) {
      for (var note in notes) {
        versionNotes = "$versionNotes$note\n";
      }
      child = Text(versionNotes);
    }

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return KPDialog(
          title: Text(version != null
              ? "kanji_lists_versionDialog_title".tr()
              : "${"kanji_lists_versionDialog_notes".tr()} ${pi.version}"),
          content: version != null
              ? Wrap(
                  children: [
                    Text(
                        "${"kanji_lists_versionDialog_notes".tr()} $version\n"),
                    child
                  ],
                )
              : child,
          positiveButtonText: version != null
              ? 'kanji_lists_versionDialog_button_label'.tr()
              : 'Ok',
          onPositive: () async {
            if (version != null) {
              await launch(context, "google_play_link".tr());
            }
          },
        );
      },
    );
  }

  static Future<void> showSpatialRepetitionDisclaimer(
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return KPDialog(
          title: Text("list_details_learningMode_spatial".tr(),
              style: Theme.of(context).textTheme.headline6),
          content: Text("disclaimer_spatial_repetition".tr(),
              style: Theme.of(context).textTheme.bodyText1),
          positiveButtonText: "Ok",
          negativeButton: false,
          onPositive: () {},
        );
      },
    );
  }

  static Future<DateTimeRange?> showRangeTimeDialog(
    BuildContext context,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    final dialogColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    late DateTimeRange? range;
    await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: firstDate, end: lastDate),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: context.locale,
      helpText: 'date_picker_helper'.tr(),
      fieldStartHintText: 'date_picker_start_hint'.tr(),
      fieldEndHintText: 'date_picker_end_hint'.tr(),
      saveText: 'date_picker_save'.tr(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: KPColors.secondaryColor,
            splashColor: KPColors.secondaryColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: KPColors.secondaryColor,
              onPrimary: dialogColor,
              surface: KPColors.secondaryColor,
              onSurface: dialogColor,
              secondary: KPColors.secondaryColor,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) => range = value);
    return range;
  }
}