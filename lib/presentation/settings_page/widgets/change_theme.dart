import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/theme/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeAppTheme extends StatefulWidget {
  const ChangeAppTheme({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (context) => const ChangeAppTheme());
  }

  @override
  State<ChangeAppTheme> createState() => _ChangeAppThemeState();
}

class _ChangeAppThemeState extends State<ChangeAppTheme> {
  late ThemeMode _mode;

  @override
  void initState() {
    _mode = ThemeManager.instance.themeMode ?? ThemeMode.system;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: false,
        onClosing: () => {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(KPRadius.radius16),
                topLeft: Radius.circular(KPRadius.radius16))),
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(KPMargins.margin8),
                child: Column(
                  children: [
                    const KPDragContainer(),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: KPMargins.margin8),
                          child: Text("settings_toggle_theme".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall),
                        )),
                    _selection(context)
                  ],
                ),
              ),
            ],
          );
        });
  }

  _onTileSelected(ThemeMode? val) {
    setState(() => _mode = val ?? ThemeMode.system);
    ThemeManager.instance.switchMode(_mode);
    Navigator.of(context).pop();
  }

  Widget _selection(BuildContext context) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
            title: Text("settings_theme_system".tr()),
            value: ThemeMode.system,
            groupValue: _mode,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<ThemeMode>(
            title: Text("settings_theme_light".tr()),
            value: ThemeMode.light,
            groupValue: _mode,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<ThemeMode>(
            title: Text("settings_theme_dark".tr()),
            value: ThemeMode.dark,
            groupValue: _mode,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
      ],
    );
  }
}
