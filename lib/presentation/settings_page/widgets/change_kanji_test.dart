import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/infrastructure/preferences/preferences_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ChangeKanjiInTest extends StatefulWidget {
  const ChangeKanjiInTest({Key? key}) : super(key: key);

  static Future<int?> show(BuildContext context) async {
    int? value;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (context) => const ChangeKanjiInTest()).then((v) => value = v);
    return value;
  }

  @override
  State<ChangeKanjiInTest> createState() => _ChangeKanjiInTestState();
}

class _ChangeKanjiInTestState extends State<ChangeKanjiInTest> {
  int _kanjiInTest = KPSizes.numberOfKanjiInTest;

  @override
  void initState() {
    _kanjiInTest = getIt<PreferencesRepositoryImpl>()
            .readData(SharedKeys.numberOfKanjiInTest) ??
        KPSizes.numberOfKanjiInTest;
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
                          child: Text("change_kanji_in_test_selection".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5),
                        )),
                    _selection(context)
                  ],
                ),
              ),
            ],
          );
        });
  }

  _onTileSelected(int? val) {
    setState(() => _kanjiInTest = val ?? KPSizes.numberOfKanjiInTest);
    Navigator.of(context).pop(_kanjiInTest);
  }

  Widget _selection(BuildContext context) {
    return Column(
      children: [
        RadioListTile<int>(
            title: const Text("30"),
            value: 30,
            groupValue: _kanjiInTest,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<int>(
            title: const Text("40"),
            value: 40,
            groupValue: _kanjiInTest,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<int>(
            title: const Text("50"),
            value: 50,
            groupValue: _kanjiInTest,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<int>(
            title: const Text("60"),
            value: 60,
            groupValue: _kanjiInTest,
            activeColor: KPColors.secondaryColor,
            onChanged: _onTileSelected),
      ],
    );
  }
}
