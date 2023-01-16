import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/load_grammar_test/load_grammar_test_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
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
  const KPTestBottomSheet({Key? key, this.folder}) : super(key: key);

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
    getIt<LoadTestBloc>().add(const LoadTestEventIdle(mode: Tests.daily));
    getIt<LoadGrammarTestBloc>()
        .add(const LoadGrammarTestEventIdle(mode: Tests.daily));
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
                    style: Theme.of(context).textTheme.headline6),
              ),
              BlocBuilder<LoadTestBloc, LoadTestState>(
                builder: (context, state) {
                  bool wordsToReview = false;
                  if (state is LoadTestStateIdle) {
                    wordsToReview = state.wordsToReview.any((w) => w > 0);
                  }
                  return BlocBuilder<LoadGrammarTestBloc, LoadGrammarTestState>(
                    builder: (context, grammarState) {
                      if (grammarState is LoadGrammarTestStateIdle) {
                        return _body(
                          hasWords: wordsToReview ||
                              grammarState.grammarToReview.any((w) => w > 0),
                        );
                      } else {
                        return _body();
                      }
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.3,
        ),
        children: widget.folder != null
            ? [
                _testBasedButtons(context, Tests.blitz),
                _testBasedButtons(context, Tests.time),
                _testBasedButtons(context, Tests.less),
                _testBasedButtons(context, Tests.categories),
                _testBasedButtons(context, Tests.daily, hasWords: hasWords)
              ]
            : List.generate(
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
              ),
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
      final locale =
          EasyLocalization.of(context)?.currentLocale?.languageCode ?? 'en';
      final now = DateTime.now();
      final nextDay = DateFormat.MMMMd(locale)
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
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock_rounded, size: 15, color: Colors.white),
                    Icon(Icons.arrow_forward_rounded,
                        size: 15, color: Colors.white),
                    Icon(Icons.lock_open_rounded,
                        size: 15, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
            title2: nextDay,
            onTap: null,
            color: KPColors.midGrey,
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
                await KPBlitzBottomSheet.show(
                  context,
                  folder: widget.folder,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.time:
                await KPBlitzBottomSheet.show(
                  context,
                  folder: widget.folder,
                  remembranceTest: true,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.numbers:
                await KPNumberTestBottomSheet.show(context)
                    .then((_) => _checkReviewWords());
                break;
              case Tests.less:
                await KPBlitzBottomSheet.show(
                  context,
                  folder: widget.folder,
                  lessPctTest: true,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.categories:
                await KPKanListCategorySelectionBottomSheet.show(
                  context,
                  folder: widget.folder,
                ).then((_) => _checkReviewWords());
                break;
              case Tests.folder:
                await FolderSelectionBottomSheet.show(context)
                    .then((_) => _checkReviewWords());
                break;
              case Tests.daily:
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
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: KPColors.secondaryDarkerColor,
              ),
            ),
          )
      ],
    );
  }
}
