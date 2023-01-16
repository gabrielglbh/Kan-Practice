import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_switch.dart';
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
  bool _definitionNotification = true;
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
    _definitionNotification = getIt<PreferencesService>()
        .readData(SharedKeys.definitionDailyNotification);
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

  ListTile _notificationDaily(
    bool notification,
    Icon icon,
    String title,
    Function(bool) onTap,
  ) {
    return ListTile(
      leading: icon,
      title: Text(title),
      trailing: KPSwitch(
        onChanged: onTap,
        value: notification,
      ),
      contentPadding: const EdgeInsets.only(
        right: KPMargins.margin16,
        left: KPMargins.margin32 + KPMargins.margin12,
      ),
      onTap: () {
        onTap(!notification);
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
          _notificationDaily(
            _writingNotification,
            Icon(StudyModes.writing.icon, color: StudyModes.writing.color),
            StudyModes.writing.mode,
            (v) => _saveData(StudyModes.writing, v),
          ),
          _notificationDaily(
            _readingNotification,
            Icon(StudyModes.reading.icon, color: StudyModes.reading.color),
            StudyModes.reading.mode,
            (v) => _saveData(StudyModes.reading, v),
          ),
          _notificationDaily(
            _recognitionNotification,
            Icon(StudyModes.recognition.icon,
                color: StudyModes.recognition.color),
            StudyModes.recognition.mode,
            (v) => _saveData(StudyModes.recognition, v),
          ),
          _notificationDaily(
            _listeningNotification,
            Icon(StudyModes.listening.icon, color: StudyModes.listening.color),
            StudyModes.listening.mode,
            (v) => _saveData(StudyModes.listening, v),
          ),
          _notificationDaily(
            _speakingNotification,
            Icon(StudyModes.speaking.icon, color: StudyModes.speaking.color),
            StudyModes.speaking.mode,
            (v) => _saveData(StudyModes.speaking, v),
          ),
          _notificationDaily(
            _definitionNotification,
            Icon(GrammarModes.definition.icon,
                color: GrammarModes.definition.color),
            GrammarModes.definition.mode,
            (v) {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.definitionDailyNotification, v);
              setState(() => _definitionNotification = v);
            },
          ),
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
