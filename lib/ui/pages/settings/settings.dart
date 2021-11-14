import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:kanpractice/ui/pages/settings/widgets/DevInfo.dart';
import 'package:kanpractice/ui/theme/theme_manager.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

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
        toolbarHeight: appBarHeight,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Settings"),
        actions: [
          IconButton(
            onPressed: () => _settingsBloc..add(SettingsLoadingBackUpDate()),
            icon: Icon(Icons.sync),
          )
        ],
      ),
      body: ListView(
        children: [
          _header("Appearance"),
          Divider(),
          ListTile(
            leading: Icon(Icons.wb_sunny_rounded),
            title: Text("Switch Theme"),
            onTap: () async {
              _mode = ThemeManager.instance.themeMode;
              ThemeManager.instance.switchMode(_mode == ThemeMode.light);
            },
          ),
          _header("Progress"),
          Divider(),
          ListTile(
            leading: Icon(Icons.track_changes_rounded),
            title: Text("Test History"),
            onTap: () async => Navigator.of(context).pushNamed(testHistoryPage),
          ),
          BlocProvider(
            create: (_) => _settingsBloc..add(SettingsLoadingBackUpDate()),
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsStateBackUpDateLoaded) {
                  return _header("Manage Account", subtitle: state.date);
                } else if (state is SettingsStateBackUpDateLoading) {
                  return _header("Manage Account");
                } else {
                  return Container();
                }
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.whatshot_rounded),
            title: Text("Account"),
            onTap: () => Navigator.of(context).pushNamed(loginPage)
          ),
          _header("Information"),
          Divider(),
          ListTile(
            leading: Icon(Icons.star_rate_rounded, color: Colors.orangeAccent),
            title: Text("Rate the app!"),
            onTap: () async {
              try {
                await launch("https://play.google.com/store/apps/details?id=com.gabr.garc.kanpractice");
              } catch (err) {
                GeneralUtils.getSnackBar(context, "Could not launch app store");
              }
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.handyman),
            title: Text("Developer"),
            onTap: () => DevInfo.callModalSheet(context)
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text("Licenses"),
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) {
                  return FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      return LicensePage(
                        applicationName: "KanPractice",
                        applicationVersion: snapshot.data?.version,
                        applicationIcon: Container(width: 150, height: 150, child: Image.asset("assets/icon/icon.png")),
                      );
                  });
                }),
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy Policy & Conditions"),
            onTap: () async {
              try {
                await launch("https://kanpractice.web.app");
              } catch (err) {
                GeneralUtils.getSnackBar(context, "Could not launch website");
              }
            }
          ),
          Container(height: 48)
        ],
      )
    );
  }

  ListTile _header(String title, {String? subtitle}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}
