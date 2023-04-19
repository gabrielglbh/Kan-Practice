import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/daily_options/daily_options_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_switch.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';

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
  bool _grammarPointNotification = true;
  bool _controlledPace = true;
  late TextEditingController _wordsController, _grammarController;

  @override
  void initState() {
    final service = getIt<PreferencesService>();
    _writingNotification =
        service.readData(SharedKeys.writingDailyNotification);
    _readingNotification =
        service.readData(SharedKeys.readingDailyNotification);
    _recognitionNotification =
        service.readData(SharedKeys.recognitionDailyNotification);
    _listeningNotification =
        service.readData(SharedKeys.listeningDailyNotification);
    _speakingNotification =
        service.readData(SharedKeys.speakingDailyNotification);
    _definitionNotification =
        service.readData(SharedKeys.definitionDailyNotification);
    _grammarPointNotification =
        service.readData(SharedKeys.grammarPointDailyNotification);
    _controlledPace = service.readData(SharedKeys.dailyTestOnControlledPace);
    _wordsController = TextEditingController(
        text: service.readData(SharedKeys.maxWordsOnDaily).toString());
    _grammarController = TextEditingController(
        text: service.readData(SharedKeys.maxGrammarOnDaily).toString());
    context.read<DailyOptionsBloc>().add(DailyOptionsEventLoadData());
    super.initState();
  }

  _saveData(StudyModes mode, bool value) {
    final service = getIt<PreferencesService>();
    switch (mode) {
      case StudyModes.writing:
        service.saveData(SharedKeys.writingDailyNotification, value);
        setState(() => _writingNotification = value);
        return;
      case StudyModes.reading:
        service.saveData(SharedKeys.readingDailyNotification, value);
        setState(() => _readingNotification = value);
        return;
      case StudyModes.recognition:
        service.saveData(SharedKeys.recognitionDailyNotification, value);
        setState(() => _recognitionNotification = value);
        return;
      case StudyModes.listening:
        service.saveData(SharedKeys.listeningDailyNotification, value);
        setState(() => _listeningNotification = value);
        return;
      case StudyModes.speaking:
        service.saveData(SharedKeys.speakingDailyNotification, value);
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
  void dispose() {
    _wordsController.dispose();
    _grammarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: 'settings_daily_test_options'.tr(),
      resizeToAvoidBottomInset: true,
      child: ListView(
        children: [
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
                    .bodyMedium
                    ?.copyWith(color: KPColors.midGrey),
              ),
            ),
            onTap: () {
              getIt<PreferencesService>().saveData(
                  SharedKeys.dailyTestOnControlledPace, !_controlledPace);
              setState(() => _controlledPace = !_controlledPace);
            },
          ),
          if (_controlledPace)
            BlocBuilder<DailyOptionsBloc, DailyOptionsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (words, grammar, wordsMean, grammarMean) => Padding(
                    padding: const EdgeInsets.only(
                        left: KPMargins.margin32 + KPMargins.margin12),
                    child: Column(
                      children: [
                        const SizedBox(height: KPMargins.margin12),
                        KPTextForm(
                          header: 'Maximum words per day',
                          hint: wordsMean.toString(),
                          controller: _wordsController,
                          focusNode: FocusNode(),
                          onEditingComplete: () {
                            if (_wordsController.text.isNotEmpty) {
                              final number = int.parse(_wordsController.text);
                              if (number < 0 || number > words) {
                                getIt<PreferencesService>().saveData(
                                    SharedKeys.maxWordsOnDaily, wordsMean);
                                return;
                              }
                              getIt<PreferencesService>()
                                  .saveData(SharedKeys.maxWordsOnDaily, number);
                            }
                          },
                          inputType: TextInputType.number,
                          action: TextInputAction.done,
                        ),
                        const SizedBox(height: KPMargins.margin12),
                        KPTextForm(
                          header: 'Maximum grammar points per day',
                          hint: grammarMean.toString(),
                          controller: _grammarController,
                          focusNode: FocusNode(),
                          onEditingComplete: () {
                            if (_grammarController.text.isNotEmpty) {
                              final number = int.parse(_grammarController.text);
                              if (number < 0 || number > grammar) {
                                getIt<PreferencesService>().saveData(
                                    SharedKeys.maxGrammarOnDaily, grammarMean);
                                return;
                              }
                              getIt<PreferencesService>().saveData(
                                  SharedKeys.maxGrammarOnDaily, number);
                            }
                          },
                          inputType: TextInputType.number,
                          action: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  loading: () => const KPProgressIndicator(),
                  orElse: () => const SizedBox(),
                );
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_view_day_rounded),
            title: Text("settings_daily_notification_title".tr()),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: KPMargins.margin8),
              child: Text(
                "settings_daily_notification_sub".tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
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
          _notificationDaily(
            _grammarPointNotification,
            Icon(GrammarModes.grammarPoints.icon,
                color: GrammarModes.grammarPoints.color),
            GrammarModes.grammarPoints.mode,
            (v) {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.grammarPointDailyNotification, v);
              setState(() => _grammarPointNotification = v);
            },
          ),
        ],
      ),
    );
  }
}
