import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_switch.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class SettingsTogglePage extends StatefulWidget {
  const SettingsTogglePage({super.key});

  @override
  State<SettingsTogglePage> createState() => _SettingsTogglePageState();
}

class _SettingsTogglePageState extends State<SettingsTogglePage> {
  bool _aggStats = false;
  bool _toggleAffect = false;
  bool _enableRep = false;
  bool _speakingWithSTT = false;
  bool _showTimer = false;

  @override
  void initState() {
    final service = getIt<PreferencesService>();
    _toggleAffect = service.readData(SharedKeys.affectOnPractice);
    _aggStats = service.readData(SharedKeys.kanListListVisualization);
    _enableRep = service.readData(SharedKeys.enableRepetitionOnTests);
    _speakingWithSTT = service.readData(SharedKeys.speakingWithSTT);
    _showTimer = service.readData(SharedKeys.showTimer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: 'settings_enhancements_label'.tr(),
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.auto_graph_rounded,
                color: Colors.lightBlueAccent),
            title: Text("settings_general_toggle".tr()),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: KPMargins.margin8),
                child: Text("settings_general_toggle_sub".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: KPColors.midGrey))),
            trailing: KPSwitch(
              onChanged: (bool value) {
                getIt<PreferencesService>()
                    .saveData(SharedKeys.affectOnPractice, value);
                setState(() => _toggleAffect = value);
              },
              value: _toggleAffect,
            ),
            onTap: () async {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.affectOnPractice, !_toggleAffect);
              setState(() => _toggleAffect = !_toggleAffect);
            },
          ),
          const Divider(),
          ListTile(
            leading:
                const Icon(Icons.repeat_rounded, color: Colors.purpleAccent),
            title: Text("settings_general_repetition_toggle".tr()),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: KPMargins.margin8),
                child: Text("settings_general_repetition_sub".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: KPColors.midGrey))),
            trailing: KPSwitch(
              onChanged: (bool value) {
                getIt<PreferencesService>()
                    .saveData(SharedKeys.enableRepetitionOnTests, value);
                setState(() => _enableRep = value);
              },
              value: _enableRep,
            ),
            onTap: () async {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.enableRepetitionOnTests, !_enableRep);
              setState(() => _enableRep = !_enableRep);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group_work_rounded,
                color: Colors.orangeAccent),
            title: Text("settings_general_word_list".tr()),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: KPMargins.margin8),
                child: Text("settings_general_word_list_description".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: KPColors.midGrey))),
            trailing: KPSwitch(
              onChanged: (bool value) {
                getIt<PreferencesService>()
                    .saveData(SharedKeys.kanListListVisualization, value);
                setState(() => _aggStats = value);
              },
              value: _aggStats,
            ),
            onTap: () async {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.kanListListVisualization, !_aggStats);
              setState(() => _aggStats = !_aggStats);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.timer,
              color: Colors.green.shade700,
            ),
            title: Text("settings_general_timer".tr()),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: KPMargins.margin8),
                child: Text("settings_general_timer_description".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: KPColors.midGrey))),
            trailing: KPSwitch(
              onChanged: (bool value) {
                getIt<PreferencesService>()
                    .saveData(SharedKeys.showTimer, value);
                setState(() => _showTimer = value);
              },
              value: _showTimer,
            ),
            onTap: () async {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.showTimer, !_showTimer);
              setState(() => _showTimer = !_showTimer);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.record_voice_over_rounded),
            title: Text("settings_general_stt".tr()),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: KPMargins.margin8),
                child: Text("settings_general_stt_description".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: KPColors.midGrey))),
            trailing: KPSwitch(
              onChanged: (bool value) {
                getIt<PreferencesService>()
                    .saveData(SharedKeys.speakingWithSTT, value);
                setState(() => _speakingWithSTT = value);
              },
              value: _speakingWithSTT,
            ),
            onTap: () async {
              getIt<PreferencesService>()
                  .saveData(SharedKeys.speakingWithSTT, !_speakingWithSTT);
              setState(() => _speakingWithSTT = !_speakingWithSTT);
            },
          ),
        ],
      ),
    );
  }
}
