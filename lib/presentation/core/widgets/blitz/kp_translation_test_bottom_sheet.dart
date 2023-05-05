import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class KPTranslationTestBottomSheet extends StatefulWidget {
  const KPTranslationTestBottomSheet({Key? key}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const KPTranslationTestBottomSheet());
  }

  @override
  State<KPTranslationTestBottomSheet> createState() =>
      _KPTranslationTestBottomSheetState();
}

class _KPTranslationTestBottomSheetState
    extends State<KPTranslationTestBottomSheet> {
  final _wordsInTest = KPSizes.numberOfWordInTest - 10;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("translation_bottom_sheet_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text(
                    "$_wordsInTest "
                    "${"translation_bottom_sheet_content".tr()}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("translation_test_disclaimer".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: KPMargins.margin32),
              Icon(Tests.translation.icon, size: KPMargins.margin64),
              const SizedBox(height: KPMargins.margin32),
              KPButton(
                title1: "translation_bottom_sheet_begin_ext".tr(),
                title2: "translation_bottom_sheet_begin".tr(),
                onTap: () async {
                  Navigator.of(context).pop(); // Dismiss this bottom sheet
                  Navigator.of(context).pop(); // Dismiss the tests bottom sheet
                  await Navigator.of(context).pushNamed(
                    KanPracticePages.translationsTestPage,
                    arguments: ModeArguments(
                      studyList: [],
                      isTest: true,
                      mode: StudyModes.recognition,
                      testMode: Tests.translation,
                      studyModeHeaderDisplayName: "test_mode_translation".tr(),
                      testHistoryDisplasyName:
                          "translation_bottom_sheet_label".tr(),
                      isTranslationTest: true,
                    ),
                  );
                },
              ),
              const SizedBox(height: KPMargins.margin8),
            ],
          ),
        ]);
      },
    );
  }
}
