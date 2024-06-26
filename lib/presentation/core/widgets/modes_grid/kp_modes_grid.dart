import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/generic_test/generic_test_bloc.dart';
import 'package:kanpractice/application/grammar_test/grammar_test_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/modes_grid/grammar_grid.dart';
import 'package:kanpractice/presentation/core/widgets/modes_grid/word_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_word_grammar_bottom_navigation.dart';

class KPModesGrid extends StatefulWidget {
  /// List of [Word] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE or LESS % or DAILY).
  ///
  /// If it is not null, the list must come from (SELECTION OR CATEGORY TEST).
  final List<String>? selectionQuery;

  /// List of [GrammarPoint] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE or LESS % or DAILY).
  ///
  /// If it is not null, the list must come from (SELECTION TEST).
  final List<GrammarPoint>? grammarList;

  /// Name of the test being performed
  final String testName;

  /// ONLY VALID FOR BLITZ OR REMEMBRANCE TESTS.
  ///
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all words available will be taken into consideration.
  final String? practiceList;

  /// ONLY VALID FOR FOLDER TEST
  ///
  /// String defining the folder from which gather the words
  final String? folder;

  /// Type of test being performed
  final Tests type;

  const KPModesGrid({
    super.key,
    this.selectionQuery,
    this.grammarList,
    this.practiceList,
    this.folder,
    required this.type,
    required this.testName,
  });

  @override
  State<KPModesGrid> createState() => _KPModesGridState();
}

class _KPModesGridState extends State<KPModesGrid> {
  final PageController _pageController = PageController();
  ListDetailsType _page = ListDetailsType.words;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page?.round() != _page.index) {
        setState(() {
          _page = ListDetailsType.values[_pageController.page?.round() ?? 0];
        });
      }
    });
    context
        .read<GenericTestBloc>()
        .add(GenericTestEventIdle(mode: widget.type));
    context
        .read<GrammarTestBloc>()
        .add(GrammarTestEventIdle(mode: widget.type));
    super.initState();
  }

  Widget affectOnPractice() {
    return Visibility(
      visible:
          getIt<PreferencesService>().readData(SharedKeys.affectOnPractice) ==
              true,
      child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: KPMargins.margin8, horizontal: KPMargins.margin24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: KPMargins.margin16),
                child: Icon(Icons.auto_graph_rounded,
                    color: Colors.lightBlueAccent),
              ),
              Expanded(
                  child: Text(
                "settings_general_toggle".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              )),
              const Padding(
                padding: EdgeInsets.only(left: KPMargins.margin16),
                child: Icon(Icons.auto_graph_rounded,
                    color: Colors.lightBlueAccent),
              ),
            ],
          )),
    );
  }

  Widget controlledPace() {
    final controlledPace = getIt<PreferencesService>()
            .readData(SharedKeys.dailyTestOnControlledPace) ==
        true;
    return Visibility(
      visible: controlledPace && widget.type == Tests.daily,
      child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: KPMargins.margin8, horizontal: KPMargins.margin24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: KPMargins.margin16),
                child: Icon(Icons.sports_gymnastics_rounded,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              Expanded(
                  child: Text(
                "test_info_controlled_pace".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              )),
              Padding(
                padding: const EdgeInsets.only(left: KPMargins.margin16),
                child: Icon(Icons.sports_gymnastics_rounded,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        affectOnPractice(),
        controlledPace(),
        if (widget.type != Tests.categories)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    clipBehavior: Clip.none,
                    children: [
                      WordGrid(
                        type: widget.type,
                        folder: widget.folder,
                        testName: widget.testName,
                        practiceList: widget.practiceList,
                        selectionQuery: widget.selectionQuery,
                      ),
                      GrammarGrid(
                        type: widget.type,
                        folder: widget.folder,
                        testName: widget.testName,
                        practiceList: widget.practiceList,
                        selectionQuery: widget.selectionQuery,
                      )
                    ],
                  ),
                ),
                KPWordGrammarBottomNavigation(
                  currentPage: _page,
                  onPageChanged: (type) {
                    setState(() => _page = type);
                    _pageController.animateToPage(
                      type.page,
                      duration:
                          const Duration(milliseconds: KPAnimations.ms300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          )
        else
          WordGrid(
            type: widget.type,
            folder: widget.folder,
            testName: widget.testName,
            practiceList: widget.practiceList,
            selectionQuery: widget.selectionQuery,
          )
      ],
    );
  }
}
