import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/application/generic_test/generic_test_bloc.dart';
import 'package:kanpractice/application/grammar_test/grammar_test_bloc.dart';
import 'package:kanpractice/application/purchases/purchases_bloc.dart';
import 'package:kanpractice/application/settings/settings_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/settings_page/widgets/change_words_test.dart';
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
  int _wordsInTest = KPSizes.numberOfWordInTest;

  @override
  void initState() {
    _wordsInTest =
        getIt<PreferencesService>().readData(SharedKeys.numberOfWordInTest) ??
            KPSizes.numberOfWordInTest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SettingsBloc>()..add(SettingsLoadingBackUpDate()),
      child: ListView(
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
          const SizedBox(height: KPMargins.margin12),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return BlocListener<AuthBloc, AuthState>(
                  listener: (_, state) {
                    state.mapOrNull(loaded: (l) {
                      context
                          .read<SettingsBloc>()
                          .add(SettingsLoadingBackUpDate());
                    }, initial: (l) {
                      context
                          .read<SettingsBloc>()
                          .add(SettingsLoadingBackUpDate());
                    });
                  },
                  child: state.maybeWhen(
                    loaded: (date) => _header(
                      "settings_account_section".tr(),
                      bloc: context,
                      subtitle: date,
                      hasTrailing: true,
                    ),
                    loading: () => _header("settings_account_section".tr(),
                        bloc: context, hasTrailing: true),
                    orElse: () => const SizedBox(),
                  ));
            },
          ),
          const Divider(),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ListTile(
                leading: const Icon(Icons.whatshot_rounded),
                title: Text(
                  state.maybeWhen(
                    loaded: (_) => "settings_account_label".tr(),
                    orElse: () => "login_login_title".tr(),
                  ),
                ),
                onTap: () {
                  state.maybeWhen(
                    loaded: (_) {
                      Navigator.of(context)
                          .pushNamed(KanPracticePages.accountManagementPage);
                    },
                    orElse: () {
                      Navigator.of(context)
                          .pushNamed(KanPracticePages.loginPage);
                    },
                  );
                },
              );
            },
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (user) => ListTile(
                  leading: const Icon(Icons.cloud),
                  title: Text("login_manage_backup_title".tr()),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      KanPracticePages.backUpPage,
                      arguments: user.uid,
                    );
                  },
                ),
                orElse: () => const SizedBox(),
              );
            },
          ),
          _header("settings_general".tr()),
          const Divider(),
          ListTile(
            leading: Icon(Icons.local_play_rounded,
                color: KPColors.getSecondaryColor(context)),
            title: Text("pro_version".tr()),
            trailing: BlocBuilder<PurchasesBloc, PurchasesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  updatedToPro: () => Icon(Icons.check,
                      color: KPColors.getSecondaryColor(context)),
                  orElse: () => const SizedBox(),
                );
              },
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(KanPracticePages.storePage),
          ),
          ListTile(
            leading: const Icon(Icons.insert_chart_outlined_rounded,
                color: Colors.teal),
            title: Text("settings_general_statistics".tr()),
            onTap: () => Navigator.of(context)
                .pushNamed(KanPracticePages.statisticsPage),
          ),
          ListTile(
            leading: const Icon(Icons.toggle_on),
            title: Text("settings_enhancements_label".tr()),
            onTap: () => Navigator.of(context)
                .pushNamed(KanPracticePages.settingsTogglePage),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: Text("settings_daily_test_options".tr()),
            onTap: () async {
              await Navigator.of(context)
                  .pushNamed(KanPracticePages.settingsDailyOptions)
                  .then((_) {
                context
                    .read<GenericTestBloc>()
                    .add(const GenericTestEventIdle(mode: Tests.daily));
                context
                    .read<GrammarTestBloc>()
                    .add(const GrammarTestEventIdle(mode: Tests.daily));
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.adjust_rounded),
            title: Text("settings_number_of_word_in_test".tr()),
            trailing: Text("$_wordsInTest",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: KPColors.midGrey)),
            onTap: () async {
              final newValue = await ChangeWordsInTest.show(context);
              if (newValue != null) {
                setState(() => _wordsInTest = newValue);
                getIt<PreferencesService>()
                    .saveData(SharedKeys.numberOfWordInTest, _wordsInTest);
              }
            },
          ),
          ListTile(
              leading: const Icon(Icons.notifications_active_rounded),
              title: Text("settings_notifications_label".tr()),
              onTap: () {
                AppSettings.openNotificationSettings();
              }),
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: Text('settings_toggle_theme'.tr()),
            onTap: () {
              ChangeAppTheme.show(context);
            },
          ),
          _header("settings_information_section".tr()),
          const Divider(),
          BlocConsumer<BackupBloc, BackupState>(
            listener: (context, state) async {
              state.mapOrNull(notesRetrieved: (n) async {
                await Utils.showVersionNotes(context, notes: n.notes);
              });
            },
            builder: (context, state) {
              return state.maybeWhen(
                versionRetrieved: (_, __) => const SizedBox(),
                orElse: () => ListTile(
                  leading: const Icon(Icons.star, color: Colors.green),
                  title: Text("settings_general_versionNotes".tr()),
                  onTap: () {
                    context.read<BackupBloc>().add(
                          const BackupGetVersion(showNotes: true),
                        );
                  },
                ),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.handyman),
              title: Text("settings_information_developer_label".tr()),
              onTap: () => DevInfo.callModalSheet(context)),
          ListTile(
              leading: const Icon(Icons.copyright_rounded),
              title: Text("settings_information_about_label".tr()),
              onTap: () => CopyrightInfo.callModalSheet(context)),
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
      ),
    );
  }

  ListTile _header(String title,
      {BuildContext? bloc, String? subtitle, bool hasTrailing = false}) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: KPColors.midGrey))
          : null,
      trailing: hasTrailing
          ? IconButton(
              onPressed: () {
                (bloc ?? context)
                    .read<SettingsBloc>()
                    .add(SettingsLoadingBackUpDate());
              },
              icon: const Icon(Icons.sync))
          : null,
    );
  }
}
