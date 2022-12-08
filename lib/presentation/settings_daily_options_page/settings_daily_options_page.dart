import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_switch.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class SettingsDailyOptionsPage extends StatefulWidget {
  const SettingsDailyOptionsPage({super.key});

  @override
  State<SettingsDailyOptionsPage> createState() =>
      _SettingsDailyOptionsPageState();
}

class _SettingsDailyOptionsPageState extends State<SettingsDailyOptionsPage> {
  bool _writingNotification = true;
  bool _readingNotification = true;
  bool _recognitionNotification = true;
  bool _listeningNotification = true;
  bool _speakingNotification = true;
  bool _controlledPace = true;

  @override
  void initState() {
    _writingNotification = getIt<PreferencesService>()
        .readData(SharedKeys.writingDailyNotification);
    _readingNotification = getIt<PreferencesService>()
        .readData(SharedKeys.readingDailyNotification);
    _recognitionNotification = getIt<PreferencesService>()
        .readData(SharedKeys.recognitionDailyNotification);
    _listeningNotification = getIt<PreferencesService>()
        .readData(SharedKeys.listeningDailyNotification);
    _speakingNotification = getIt<PreferencesService>()
        .readData(SharedKeys.speakingDailyNotification);
    _controlledPace = getIt<PreferencesService>()
        .readData(SharedKeys.dailyTestOnControlledPace);
    super.initState();
  }

  _saveData(StudyModes mode, bool value) {
    switch (mode) {
      case StudyModes.writing:
        getIt<PreferencesService>()
            .saveData(SharedKeys.writingDailyNotification, value);
        setState(() => _writingNotification = value);
        return;
      case StudyModes.reading:
        getIt<PreferencesService>()
            .saveData(SharedKeys.readingDailyNotification, value);
        setState(() => _readingNotification = value);
        return;
      case StudyModes.recognition:
        getIt<PreferencesService>()
            .saveData(SharedKeys.recognitionDailyNotification, value);
        setState(() => _recognitionNotification = value);
        return;
      case StudyModes.listening:
        getIt<PreferencesService>()
            .saveData(SharedKeys.listeningDailyNotification, value);
        setState(() => _listeningNotification = value);
        return;
      case StudyModes.speaking:
        getIt<PreferencesService>()
            .saveData(SharedKeys.speakingDailyNotification, value);
        setState(() => _speakingNotification = value);
        return;
    }
  }

  ListTile _notificationDaily(StudyModes mode) {
    late bool notification;
    switch (mode) {
      case StudyModes.writing:
        notification = _writingNotification;
        break;
      case StudyModes.reading:
        notification = _readingNotification;
        break;
      case StudyModes.recognition:
        notification = _recognitionNotification;
        break;
      case StudyModes.listening:
        notification = _listeningNotification;
        break;
      case StudyModes.speaking:
        notification = _speakingNotification;
        break;
    }

    return ListTile(
      leading: Icon(mode.icon, color: mode.color),
      title: Text(mode.mode),
      trailing: KPSwitch(
        onChanged: (bool value) {
          _saveData(mode, value);
        },
        value: notification,
      ),
      contentPadding: const EdgeInsets.only(
        right: KPMargins.margin16,
        left: KPMargins.margin32 + KPMargins.margin12,
      ),
      onTap: () {
        _saveData(mode, !notification);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: 'settings_daily_test_options'.tr(),
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_view_day_rounded),
            title: Text("settings_daily_notification_title".tr()),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: KPMargins.margin8),
              child: Text(
                "settings_daily_notification_sub".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: KPColors.midGrey),
              ),
            ),
          ),
          _notificationDaily(StudyModes.writing),
          _notificationDaily(StudyModes.reading),
          _notificationDaily(StudyModes.recognition),
          _notificationDaily(StudyModes.listening),
          _notificationDaily(StudyModes.speaking),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.sports_gymnastics_rounded),
            title: Text("settings_daily_pace".tr()),
            trailing: KPSwitch(
              onChanged: (bool value) {
                getIt<PreferencesService>()
                    .saveData(SharedKeys.dailyTestOnControlledPace, value);
                setState(() => _controlledPace = value);
              },
              value: _controlledPace,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: KPMargins.margin8),
              child: Text(
                "settings_daily_pace_sub".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: KPColors.midGrey),
              ),
            ),
            onTap: () {
              getIt<PreferencesService>().saveData(
                  SharedKeys.dailyTestOnControlledPace, !_controlledPace);
              setState(() => _controlledPace = !_controlledPace);
            },
          ),
        ],
      ),
    );
  }
}
