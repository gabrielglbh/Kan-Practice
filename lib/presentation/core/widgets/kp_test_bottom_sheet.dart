import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/generic_test/generic_test_bloc.dart';
import 'package:kanpractice/application/grammar_test/grammar_test_bloc.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/widgets/blitz/kp_number_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_kanlist_category_selection_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/blitz/daily_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/home_page/widgets/folder_selection_bottom_sheet.dart';
import 'package:kanpractice/presentation/home_page/widgets/kanlist_selection_bottom_sheet.dart';

class KPTestBottomSheet extends StatefulWidget {
  final String? folder;
  const KPTestBottomSheet({super.key, this.folder});

  @override
  State<KPTestBottomSheet> createState() => _KPTestBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, {String? folder}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => KPTestBottomSheet(folder: folder));
  }
}

class _KPTestBottomSheetState extends State<KPTestBottomSheet> {
  _checkReviewWords() {
    context
        .read<GenericTestBloc>()
        .add(const GenericTestEventIdle(mode: Tests.daily));
    context
        .read<GrammarTestBloc>()
        .add(const GrammarTestEventIdle(mode: Tests.daily));
  }

  @override
  void initState() {
    _checkReviewWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.2),
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
                child: Text("test_selection_label".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              BlocBuilder<GenericTestBloc, GenericTestState>(
                builder: (context, state) {
                  bool wordsToReview;
                  wordsToReview = state.mapOrNull(initial: (wTR) {
                        return wTR.wordsToReview.any((w) => w > 0);
                      }) ??
                      false;

                  return BlocBuilder<GrammarTestBloc, GrammarTestState>(
                    builder: (context, grammarState) {
                      return grammarState.maybeWhen(
                        initial: (grammarToReview) {
                          return _body(
                            hasWords: wordsToReview ||
                                grammarToReview.any((w) => w > 0),
                          );
                        },
                        orElse: () => _body(),
                      );
                    },
                  );
                },
              ),
              Container(height: KPMargins.margin16)
            ],
          ),
        ]);
      },
    );
  }

  Widget _body({bool hasWords = false}) {
    final folder = [
      _testBasedButtons(context, Tests.blitz),
      _testBasedButtons(context, Tests.time),
      _testBasedButtons(context, Tests.less),
      _testBasedButtons(context, Tests.categories),
      _testBasedButtons(context, Tests.daily, hasWords: hasWords)
    ];
    final normal = List.generate(
      Tests.values.length,
      (index) {
        if (Tests.values[index] == Tests.daily) {
          return _testBasedButtons(
            context,
            Tests.daily,
            hasWords: hasWords,
          );
        }
        return _testBasedButtons(context, Tests.values[index]);
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: kIsWeb ? 1.6 : 1.3,
        ),
        children: widget.folder != null ? folder : normal,
      ),
    );
  }

  Widget _testBasedButtons(
    BuildContext context,
    Tests mode, {
    bool hasWords = false,
  }) {
    bool hasNoDailyTests = !hasWords && mode == Tests.daily;
    if (hasNoDailyTests) {
      final now = DateTime.now();
      final nextDay = DateFormat.MMMMd(Utils.currentLocale)
          .format(DateTime(now.year, now.month, now.day + 1));
      return Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          KPButton(
            customIcon: Column(
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    mode.name,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onInverseSurface),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_rounded,
                        size: 15,
                        color: Theme.of(context).colorScheme.onInverseSurface),
                    Icon(Icons.arrow_forward_rounded,
                        size: 15,
                        color: Theme.of(context).colorScheme.onInverseSurface),
                    Icon(Icons.lock_open_rounded,
                        size: 15,
                        color: Theme.of(context).colorScheme.onInverseSurface),
                  ],
                ),
              ],
            ),
            title2: nextDay,
            onTap: null,
            color: Theme.of(context).colorScheme.inverseSurface,
            textColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          Positioned(
            top: KPMargins.margin2,
            right: KPMargins.margin2,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: KPColors.subtleLight,
              ),
              child: const Icon(
                Icons.sports_gymnastics_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          )
        ],
      );
    }

    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        KPButton(
          icon: mode.icon,
          title2: mode.nameAbbr,
          onTap: () async {
            switch (mode) {
              case Tests.lists:
                await KanListSelectionBottomSheet.show(context)
                    .then((_) => _checkReviewWords());
                break;
              case Tests.blitz:
                if (!mounted) return;
                await KPBlitzBottomSheet.show(
                  context,
                  folder: widget.folder,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.time:
                if (!mounted) return;
                await KPBlitzBottomSheet.show(
                  context,
                  folder: widget.folder,
                  remembranceTest: true,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.numbers:
                if (!mounted) return;
                await KPNumberTestBottomSheet.show(context)
                    .then((_) => _checkReviewWords());
                break;
              case Tests.less:
                if (!mounted) return;
                await KPBlitzBottomSheet.show(
                  context,
                  folder: widget.folder,
                  lessPctTest: true,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.categories:
                if (!mounted) return;
                await KPKanListCategorySelectionBottomSheet.show(
                  context,
                  folder: widget.folder,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.folder:
                if (!mounted) return;
                await FolderSelectionBottomSheet.show(context)
                    .then((_) => _checkReviewWords());
                break;
              case Tests.daily:
                if (!mounted) return;
                await DailyBottomSheet.show(context)
                    .then((_) => _checkReviewWords());
                break;
            }
          },
        ),
        if (hasWords)
          Positioned(
            top: KPMargins.margin4,
            right: KPMargins.margin4,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.tertiaryFixedDim,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    width: 2,
                  )),
            ),
          )
      ],
    );
  }
}
