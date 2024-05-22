import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_practice/folder_practice_bloc.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class PracticeFolderBottomSheet extends StatefulWidget {
  final String folder;

  const PracticeFolderBottomSheet({super.key, required this.folder});

  /// Creates and calls the [BottomSheet] with the content for a regular folder practice
  static Future<void> show(BuildContext context, String folder) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => PracticeFolderBottomSheet(folder: folder));
  }

  @override
  State<PracticeFolderBottomSheet> createState() =>
      _PracticeFolderBottomSheetState();
}

class _PracticeFolderBottomSheetState extends State<PracticeFolderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return BlocProvider(
          create: (_) => getIt<FolderPracticeBloc>(),
          child: BlocListener<FolderPracticeBloc, FolderPracticeState>(
            listener: ((context, state) async {
              state.mapOrNull(loaded: (l) async {
                if (l.list.isEmpty) {
                  context
                      .read<SnackbarBloc>()
                      .add(SnackbarEventShow("study_modes_empty".tr()));
                } else {
                  await _decideOnMode(l.list, l.mode);
                }
              });
            }),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const KPDragContainer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: KPMargins.margin8,
                          horizontal: KPMargins.margin32),
                      child: Text(
                          "${"list_details_practice_button_label".tr()}: ${widget.folder}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: KPMargins.margin8,
                          horizontal: KPMargins.margin32),
                      child: Text("folder_practice_title".tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: KPMargins.margin16,
                            left: KPMargins.margin16,
                            bottom: KPMargins.margin8,
                          ),
                          child: GridView.builder(
                            itemCount: StudyModes.values.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 1.2),
                            itemBuilder: (context, index) {
                              return _modeBasedButtons(
                                  context, StudyModes.values[index]);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _modeBasedButtons(BuildContext context, StudyModes mode) {
    return KPButton(
      title1: mode.japMode,
      title2: mode.mode,
      color: mode.color,
      onTap: () async {
        context.read<FolderPracticeBloc>().add(
            FolderPracticeEventLoadList(folder: widget.folder, mode: mode));
      },
    );
  }

  Future<void> _decideOnMode(List<Word> list, StudyModes mode) async {
    Navigator.of(context).pop(); // Dismiss this bottom sheet
    await Navigator.of(context).pushNamed(
      mode.page,
      arguments: ModeArguments(
        studyList: list,
        isTest: false,
        testMode: Tests.blitz,
        studyModeHeaderDisplayName: widget.folder,
        mode: mode,
      ),
    );
  }
}
