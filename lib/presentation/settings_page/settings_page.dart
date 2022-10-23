import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/settings/settings_bloc.dart';
import 'package:kanpractice/infrastructure/preferences/preferences_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/settings_page/widgets/change_kanji_test.dart';
import 'package:kanpractice/presentation/settings_page/widgets/change_theme.dart';
import 'package:kanpractice/presentation/settings_page/widgets/copyrigh_info.dart';
import 'package:kanpractice/presentation/settings_page/widgets/dev_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _aggStats = false;
  bool _toggleAffect = false;
  int _kanjiInTest = KPSizes.numberOfKanjiInTest;

  @override
  void initState() {
    _toggleAffect = getIt<PreferencesRepositoryImpl>()
        .readData(SharedKeys.affectOnPractice);
    _aggStats = getIt<PreferencesRepositoryImpl>()
        .readData(SharedKeys.kanListListVisualization);
    _kanjiInTest = getIt<PreferencesRepositoryImpl>()
            .readData(SharedKeys.numberOfKanjiInTest) ??
        KPSizes.numberOfKanjiInTest;
    context.read<SettingsBloc>().add(SettingsLoadingBackUpDate(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.local_florist_rounded,
              color: Colors.orangeAccent),
          title: Text("settings_information_rating".tr()),
          trailing: const Icon(Icons.link),
          onTap: () async {
            await Utils.launch(context, "google_play_link".tr());
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.device_hub_rounded),
          title: Text("settings_information_contribute".tr()),
          trailing: const Icon(Icons.link),
          onTap: () async {
            try {
              await Utils.launch(
                  context, "https://github.com/gabrielglbh/Kan-Practice");
            } catch (err) {
              Utils.getSnackBar(
                  context, "settings_information_rating_failed".tr());
            }
          },
        ),
        _header("settings_general".tr()),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.insert_chart_outlined_rounded,
              color: Colors.teal),
          title: Text("settings_general_statistics".tr()),
          onTap: () =>
              Navigator.of(context).pushNamed(KanPracticePages.statisticsPage),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.auto_graph_rounded,
              color: Colors.lightBlueAccent),
          title: Text("settings_general_toggle".tr()),
          subtitle: Padding(
              padding: const EdgeInsets.only(top: KPMargins.margin8),
              child: Text("settings_general_toggle_sub".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey.shade500))),
          trailing: Switch(
            activeColor: KPColors.secondaryDarkerColor,
            activeTrackColor: KPColors.secondaryColor,
            inactiveThumbColor: Brightness.light == Theme.of(context).brightness
                ? Colors.grey[600]
                : Colors.white,
            inactiveTrackColor: Colors.grey,
            onChanged: (bool value) {
              getIt<PreferencesRepositoryImpl>()
                  .saveData(SharedKeys.affectOnPractice, value);
              setState(() => _toggleAffect = value);
            },
            value: _toggleAffect,
          ),
          onTap: () async {
            getIt<PreferencesRepositoryImpl>()
                .saveData(SharedKeys.affectOnPractice, !_toggleAffect);
            setState(() => _toggleAffect = !_toggleAffect);
          },
        ),
        const Divider(),
        ListTile(
          leading:
              const Icon(Icons.group_work_rounded, color: Colors.orangeAccent),
          title: Text("settings_general_kanji_list".tr()),
          subtitle: Padding(
              padding: const EdgeInsets.only(top: KPMargins.margin8),
              child: Text("settings_general_kanji_list_description".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey.shade500))),
          trailing: Switch(
            activeColor: KPColors.secondaryDarkerColor,
            activeTrackColor: KPColors.secondaryColor,
            inactiveThumbColor: Brightness.light == Theme.of(context).brightness
                ? Colors.grey[600]
                : Colors.white,
            inactiveTrackColor: Colors.grey,
            onChanged: (bool value) {
              getIt<PreferencesRepositoryImpl>()
                  .saveData(SharedKeys.kanListListVisualization, value);
              setState(() => _aggStats = value);
            },
            value: _aggStats,
          ),
          onTap: () async {
            getIt<PreferencesRepositoryImpl>()
                .saveData(SharedKeys.kanListListVisualization, !_aggStats);
            setState(() => _aggStats = !_aggStats);
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
            if (newValue != null) {
              setState(() => _kanjiInTest = newValue);
              getIt<PreferencesRepositoryImpl>()
                  .saveData(SharedKeys.numberOfKanjiInTest, _kanjiInTest);
            }
          },
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.notifications_active_rounded),
            title: Text("settings_notifications_label".tr()),
            onTap: () {
              AppSettings.openNotificationSettings();
            }),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.lightbulb, color: Colors.lime),
          title: Text('settings_toggle_theme'.tr()),
          onTap: () {
            ChangeAppTheme.show(context);
          },
        ),
        const Divider(),
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsStateBackUpDateLoaded) {
              return _header(
                "settings_account_section".tr(),
                subtitle: state.date,
                hasTrailing: true,
              );
            } else if (state is SettingsStateBackUpDateLoading) {
              return _header("settings_account_section".tr(),
                  hasTrailing: true);
            } else {
              return Container();
            }
          },
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.whatshot_rounded),
            title: Text("settings_account_label".tr()),
            onTap: () =>
                Navigator.of(context).pushNamed(KanPracticePages.loginPage)),
        _header("settings_information_section".tr()),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.star, color: Colors.green),
          title: Text("settings_general_versionNotes".tr()),
          onTap: () async => await Utils.showVersionNotes(context),
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
                              width: KPSizes.appIcon,
                              height: KPSizes.appIcon,
                              child: Image.asset("assets/icon/icon.png")),
                        );
                      });
                }),
              );
            }),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: KPMargins.margin48),
          child: ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: Text("settings_information_terms_label".tr()),
              trailing: const Icon(Icons.link),
              onTap: () async {
                await Utils.launch(context, "https://kanpractice.web.app");
              }),
        ),
      ],
    );
  }

  ListTile _header(String title, {String? subtitle, bool hasTrailing = false}) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline6),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey.shade500))
          : null,
      trailing: hasTrailing
          ? IconButton(
              onPressed: () {
                context
                    .read<SettingsBloc>()
                    .add(SettingsLoadingBackUpDate(context));
              },
              icon: const Icon(Icons.sync))
          : null,
    );
  }
}
