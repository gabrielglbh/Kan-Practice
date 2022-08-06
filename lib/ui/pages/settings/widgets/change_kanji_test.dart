import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:easy_localization/easy_localization.dart';

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
  int _kanjiInTest = CustomSizes.numberOfKanjiInTest;

  @override
  void initState() {
    _kanjiInTest =
        StorageManager.readData(StorageManager.numberOfKanjiInTest) ??
            CustomSizes.numberOfKanjiInTest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: false,
        onClosing: () => {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(CustomRadius.radius16),
                topLeft: Radius.circular(CustomRadius.radius16))),
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(Margins.margin8),
                child: Column(
                  children: [
                    const KPDragContainer(),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: Margins.margin8),
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
    setState(() => _kanjiInTest = val ?? CustomSizes.numberOfKanjiInTest);
    Navigator.of(context).pop(_kanjiInTest);
  }

  Widget _selection(BuildContext context) {
    return Column(
      children: [
        RadioListTile<int>(
            title: const Text("30"),
            value: 30,
            groupValue: _kanjiInTest,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<int>(
            title: const Text("40"),
            value: 40,
            groupValue: _kanjiInTest,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<int>(
            title: const Text("50"),
            value: 50,
            groupValue: _kanjiInTest,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<int>(
            title: const Text("60"),
            value: 60,
            groupValue: _kanjiInTest,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
      ],
    );
  }
}
