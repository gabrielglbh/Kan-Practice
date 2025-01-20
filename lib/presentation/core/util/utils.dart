import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/presentation/core/util/string_similarity.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timeago/timeago.dart' as t;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExtension on String {
  String get capitalized {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  double similarityTo(String? other) =>
      StringSimilarity.compareTwoStrings(this, other);

  String roundUpAsString() {
    if (this == "NaN") return "0";
    bool isRounded = substring(3) == "00" // XX.00%
        ||
        substring(2) == "00" // X.00%
        ||
        substring(4) == "00"; // XXX.00%
    return isRounded ? substring(0, length - 3) : this;
  }
}

extension DoubleExtension on double {
  /// Returns the color based on the given [winRate]
  Color getColorBasedOnWinRate(BuildContext context) {
    if (this >= 0 && this <= 0.1) {
      return KPColors.darkRed;
    } else if (this > 0.1 && this <= 0.2) {
      return KPColors.darkMidRed;
    } else if (this > 0.2 && this <= 0.3) {
      return KPColors.midRed;
    } else if (this > 0.3 && this <= 0.4) {
      return KPColors.lightMidRed;
    } else if (this > 0.4 && this <= 0.5) {
      return KPColors.darkMidOrange;
    } else if (this > 0.5 && this <= 0.6) {
      return KPColors.darkOrange;
    } else if (this > 0.6 && this <= 0.7) {
      return KPColors.darkMidAmber;
    } else if (this > 0.7 && this <= 0.8) {
      return KPColors.darkAmber;
    } else if (this > 0.8 && this <= 0.9) {
      return KPColors.darkOlive;
    } else if (this > 0.9 && this <= 1) {
      return KPColors.darkGreen;
    } else {
      return Theme.of(context).colorScheme.surface;
    }
  }

  /// Returns the color based on the given [score]
  Color getColorBasedOnScore(BuildContext context) {
    if (this >= 0 && this <= 0.2) {
      return Colors.green.shade50;
    } else if (this > 0.2 && this <= 0.4) {
      return Colors.green.shade200;
    } else if (this > 0.4 && this <= 0.6) {
      return Colors.green.shade300;
    } else if (this > 0.6 && this <= 0.8) {
      return Colors.green.shade400;
    } else if (this > 0.8 && this <= 1) {
      return KPColors.darkGreen;
    } else {
      return Theme.of(context).colorScheme.surface;
    }
  }

  // Returns a emoji based on the [winRate]
  IconData getEmojiBasedOnWinRate() {
    if (this >= 0 && this <= 0.1) {
      return FontAwesomeIcons.faceDizzy;
    } else if (this > 0.1 && this <= 0.2) {
      return FontAwesomeIcons.faceFrown;
    } else if (this > 0.2 && this <= 0.3) {
      return FontAwesomeIcons.faceFrown;
    } else if (this > 0.3 && this <= 0.4) {
      return FontAwesomeIcons.faceFrown;
    } else if (this > 0.4 && this <= 0.5) {
      return FontAwesomeIcons.faceGrinBeamSweat;
    } else if (this > 0.5 && this <= 0.6) {
      return FontAwesomeIcons.faceGrinBeamSweat;
    } else if (this > 0.6 && this <= 0.7) {
      return FontAwesomeIcons.faceSmileBeam;
    } else if (this > 0.7 && this <= 0.8) {
      return FontAwesomeIcons.faceSmileBeam;
    } else if (this > 0.8 && this <= 0.9) {
      return FontAwesomeIcons.faceLaughBeam;
    } else if (this > 0.9 && this <= 1) {
      return FontAwesomeIcons.faceLaughBeam;
    } else {
      return FontAwesomeIcons.faceDizzy;
    }
  }

  /// Returns the text color based on the given [score]
  Color getTextColorBasedOnScore() {
    if (this >= 0 && this <= 0.2) {
      return KPColors.accentLight;
    } else if (this > 0.2 && this <= 0.4) {
      return KPColors.accentLight;
    } else {
      return Colors.white;
    }
  }

  String getFixedPercentageAsString() {
    return "${(this * 100).getFixedDouble().roundUpAsString()}%";
  }

  double getFixedPercentage() {
    return double.parse((this * 100).getFixedDouble());
  }

  String getFixedDouble() => toStringAsFixed(2);
}

extension IntExtension on int {
  /// Parses the [date] that should be in milliseconds to a [DateTime] object
  /// and applies a parser with the time_ago package
  String parseDateMilliseconds() {
    final d = DateTime.fromMillisecondsSinceEpoch(this);
    Duration e = DateTime.now().difference(d);
    return t.format(DateTime.now().subtract(e), locale: Utils.currentLocale);
  }
}

/// Class that contains useful methods for all classes to use
class Utils {
  static String get currentLocale =>
      PlatformDispatcher.instance.locale.languageCode;

  static String getJishoUri(String word) => "https://jisho.org/word/$word";

  /// Opens up a [url]
  static Future<void> launch(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      // ignore: use_build_context_synchronously
      context
          .read<SnackbarBloc>()
          .add(SnackbarEventShow("launch_url_failed".tr()));
    }
  }

  /// Transforms the current time to milliseconds
  static int getCurrentMilliseconds() => DateTime.now().millisecondsSinceEpoch;

  static Future<String> parseTodayDate() async {
    await initializeDateFormatting(Utils.currentLocale, null);
    final today = DateTime.now();
    final formatter = DateFormat.yMd();
    return formatter.format(today);
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
        versionNotes = "$versionNotes$note\n\n";
      }
      child = Text(versionNotes);
    }

    await showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return KPDialog(
          title: Text(version != null
              ? "word_lists_versionDialog_title".tr()
              : "${"word_lists_versionDialog_notes".tr()} ${pi.version}"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView(
                children: [
                  if (version != null)
                    Text("${"word_lists_versionDialog_notes".tr()} $version\n"),
                  child
                ],
              ),
            ),
          ),
          positiveButtonText: version != null
              ? 'word_lists_versionDialog_button_label'.tr()
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
              style: Theme.of(context).textTheme.titleLarge),
          content: Text("disclaimer_spatial_repetition".tr(),
              style: Theme.of(context).textTheme.bodyLarge),
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
        return child!;
      },
    ).then((value) => range = value);
    return range;
  }
}
