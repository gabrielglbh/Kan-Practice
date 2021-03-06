import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:kanpractice/ui/pages/settings/widgets/change_kanji_test.dart';
import 'package:kanpractice/ui/pages/settings/widgets/change_theme.dart';
import 'package:kanpractice/ui/pages/settings/widgets/copyrigh_info.dart';
import 'package:kanpractice/ui/pages/settings/widgets/dev_info.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  VisualizationMode _graphMode = VisualizationMode.radialChart;
  bool _toggleAffect = false;
  int _kanjiInTest = CustomSizes.numberOfKanjiInTest;

  @override
  void initState() {
    _toggleAffect = StorageManager.readData(StorageManager.affectOnPractice);
    _graphMode = VisualizationModeExt.mode(
        StorageManager.readData(StorageManager.kanListGraphVisualization) ??
            VisualizationMode.radialChart);
    _kanjiInTest =
        StorageManager.readData(StorageManager.numberOfKanjiInTest) ??
            CustomSizes.numberOfKanjiInTest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => SettingsBloc()..add(SettingsLoadingBackUpDate(context)),
      child: KPScaffold(
          appBarTitle: "settings_title".tr(),
          appBarActions: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) => IconButton(
                onPressed: () => context
                    .read<SettingsBloc>()
                    .add(SettingsLoadingBackUpDate(context)),
                icon: const Icon(Icons.sync),
              ),
            )
          ],
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.local_florist_rounded,
                    color: Colors.orangeAccent),
                title: Text("settings_information_rating".tr()),
                trailing: const Icon(Icons.link),
                onTap: () async {
                  try {
                    await launch("google_play_link".tr());
                  } catch (err) {
                    GeneralUtils.getSnackBar(
                        context, "settings_information_rating_failed".tr());
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.device_hub_rounded),
                title: Text("settings_information_contribute".tr()),
                trailing: const Icon(Icons.link),
                onTap: () async {
                  try {
                    await launch("https://github.com/gabrielglbh/Kan-Practice");
                  } catch (err) {
                    GeneralUtils.getSnackBar(
                        context, "settings_information_rating_failed".tr());
                  }
                },
              ),
              _header("settings_general".tr()),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lightbulb, color: Colors.lime),
                title: Text('settings_toggle_theme'.tr()),
                onTap: () {
                  ChangeAppTheme.show(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.insert_chart_outlined_rounded,
                    color: Colors.teal),
                title: Text("settings_general_statistics".tr()),
                onTap: () => Navigator.of(context)
                    .pushNamed(KanPracticePages.statisticsPage),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.track_changes_rounded,
                    color: CustomColors.getSecondaryColor(context)),
                title: Text("settings_general_testHistory".tr()),
                onTap: () async => Navigator.of(context)
                    .pushNamed(KanPracticePages.testHistoryPage),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.auto_graph_rounded,
                    color: Colors.lightBlueAccent),
                title: Text("settings_general_toggle".tr()),
                subtitle: Padding(
                    padding: const EdgeInsets.only(top: Margins.margin8),
                    child: Text("settings_general_toggle_sub".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.grey.shade500))),
                trailing: Switch(
                  activeColor: Colors.blueAccent,
                  activeTrackColor: Colors.lightBlueAccent,
                  inactiveThumbColor:
                      Brightness.light == Theme.of(context).brightness
                          ? Colors.grey[600]
                          : Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (bool value) {
                    StorageManager.saveData(
                        StorageManager.affectOnPractice, value);
                    setState(() => _toggleAffect = value);
                  },
                  value: _toggleAffect,
                ),
                onTap: () async {
                  StorageManager.saveData(
                      StorageManager.affectOnPractice, !_toggleAffect);
                  setState(() => _toggleAffect = !_toggleAffect);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.adjust_rounded),
                title: Text("settings_number_of_kanji_in_test".tr()),
                trailing: Text("$_kanjiInTest",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.grey.shade500)),
                onTap: () async {
                  final newValue = await ChangeKanjiInTest.show(context);
                  setState(() => _kanjiInTest =
                      newValue ?? CustomSizes.numberOfKanjiInTest);
                  StorageManager.saveData(
                      StorageManager.numberOfKanjiInTest, _kanjiInTest);
                },
              ),
              const Divider(),
              ListTile(
                  leading: _graphMode.icon,
                  title: Text("settings_general_graphs".tr()),
                  onTap: () {
                    setState(() =>
                        _graphMode = VisualizationModeExt.toggle(_graphMode));
                    StorageManager.saveData(
                        StorageManager.kanListGraphVisualization,
                        _graphMode.name);
                  }),
              const Divider(),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  if (state is SettingsStateBackUpDateLoaded) {
                    return _header("settings_account_section".tr(),
                        subtitle: state.date);
                  } else if (state is SettingsStateBackUpDateLoading) {
                    return _header("settings_account_section".tr());
                  } else {
                    return Container();
                  }
                },
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.whatshot_rounded),
                  title: Text("settings_account_label".tr()),
                  onTap: () => Navigator.of(context)
                      .pushNamed(KanPracticePages.loginPage)),
              _header("settings_information_section".tr()),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.green),
                title: Text("settings_general_versionNotes".tr()),
                onTap: () async => await GeneralUtils.showVersionNotes(context),
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.handyman),
                  title: Text("settings_information_developer_label".tr()),
                  onTap: () => DevInfo.callModalSheet(context)),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.copyright_rounded),
                  title: Text("settings_information_about_label".tr()),
                  onTap: () => CopyrightInfo.callModalSheet(context)),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.apps),
                  title: Text("settings_information_license_label".tr()),
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) {
                        return FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              return LicensePage(
                                applicationName: "KanPractice",
                                applicationVersion: snapshot.data?.version,
                                applicationIcon: SizedBox(
                                    width: CustomSizes.appIcon,
                                    height: CustomSizes.appIcon,
                                    child: Image.asset("assets/icon/icon.png")),
                              );
                            });
                      }),
                    );
                  }),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: Margins.margin48),
                child: ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: Text("settings_information_terms_label".tr()),
                    trailing: const Icon(Icons.link),
                    onTap: () async {
                      try {
                        await launch("https://kanpractice.web.app");
                      } catch (err) {
                        GeneralUtils.getSnackBar(
                            context, "launch_url_failed".tr());
                      }
                    }),
              ),
            ],
          )),
    );
  }

  ListTile _header(String title, {String? subtitle}) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline6),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey.shade500))
          : null,
    );
  }
}
