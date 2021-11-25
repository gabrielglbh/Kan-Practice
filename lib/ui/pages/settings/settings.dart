import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:kanpractice/ui/pages/settings/widgets/DevInfo.dart';
import 'package:kanpractice/ui/theme/theme_manager.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  const Settings();

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsBloc _settingsBloc = SettingsBloc();
  ThemeMode _mode = ThemeMode.light;

  @override
  void initState() {
    _mode = ThemeManager.instance.themeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("settings_title".tr())),
        actions: [
          IconButton(
            onPressed: () => _settingsBloc..add(SettingsLoadingBackUpDate(context)),
            icon: Icon(Icons.sync),
          )
        ],
      ),
      body: ListView(
        children: [
          _header("settings_general".tr()),
          Divider(),
          ListTile(
            leading: Icon(Icons.star, color: Colors.green),
            title: Text("settings_general_versionNotes".tr()),
            onTap: () async => await GeneralUtils.showVersionNotes(context),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.wb_sunny_rounded),
            title: Text("settings_general_theme".tr()),
            onTap: () async {
              _mode = ThemeManager.instance.themeMode;
              ThemeManager.instance.switchMode(_mode == ThemeMode.light);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.track_changes_rounded, color: CustomColors.secondarySubtleColor),
            title: Text("settings_general_testHistory".tr()),
            onTap: () async => Navigator.of(context).pushNamed(KanPracticePages.testHistoryPage),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school_rounded),
            title: Text("settings_tutorial_label".tr()),
            onTap: () async => Navigator.of(context).pushNamed(KanPracticePages.tutorialPage, arguments: true),
          ),
          BlocProvider(
            create: (_) => _settingsBloc..add(SettingsLoadingBackUpDate(context)),
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsStateBackUpDateLoaded) {
                  return _header("settings_account_section".tr(), subtitle: state.date);
                } else if (state is SettingsStateBackUpDateLoading) {
                  return _header("settings_account_section".tr());
                } else {
                  return Container();
                }
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.whatshot_rounded),
            title: Text("settings_account_label".tr()),
            onTap: () => Navigator.of(context).pushNamed(KanPracticePages.loginPage)
          ),
          _header("settings_information_section".tr()),
          Divider(),
          ListTile(
            leading: Icon(Icons.device_hub_rounded),
            title: Text("settings_information_contribute".tr()),
            trailing: Icon(Icons.link),
            onTap: () async {
              try {
                await launch("https://github.com/gabrielglbh/Kan-Practice");
              } catch (err) {
                GeneralUtils.getSnackBar(context, "settings_information_rating_failed".tr());
              }
            }
          ),Divider(),
          ListTile(
            leading: Icon(Icons.star_rate_rounded, color: Colors.orangeAccent),
            title: Text("settings_information_rating".tr()),
            trailing: Icon(Icons.link),
            onTap: () async {
              try {
                await launch("google_play_link".tr());
              } catch (err) {
                GeneralUtils.getSnackBar(context, "settings_information_rating_failed".tr());
              }
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.handyman),
            title: Text("settings_information_developer_label".tr()),
            onTap: () => DevInfo.callModalSheet(context)
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.apps),
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
                        applicationIcon: Container(
                          width: CustomSizes.appIcon, height: CustomSizes.appIcon,
                          child: Image.asset("assets/icon/icon.png")
                        ),
                      );
                  });
                }),
              );
            }
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(bottom: Margins.margin48),
            child: ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text("settings_information_terms_label".tr()),
              trailing: Icon(Icons.link),
              onTap: () async {
                try {
                  await launch("https://kanpractice.web.app");
                } catch (err) {
                  GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
                }
              }
            ),
          ),
        ],
      )
    );
  }

  ListTile _header(String title, {String? subtitle}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: FontSizes.fontSize26, fontWeight: FontWeight.bold)),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
