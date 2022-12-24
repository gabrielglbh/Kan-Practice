import 'package:flutter/material.dart';
import 'package:kanpractice/application/load_grammar_test/load_grammar_test_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode_grid/grammar_grid.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode_grid/word_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPTestStudyMode extends StatefulWidget {
  /// List of [Kanji] to make the test with.
  ///
  /// If [list] is null, the list must be loaded upon the mode selection (BLITZ or REMEMBRANCE or LESS % or DAILY).
  ///
  /// If it is not null, the list must come from (SELECTION OR CATEGORY TEST).
  final List<Word>? list;

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
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;

  /// ONLY VALID FOR FOLDER TEST
  ///
  /// String defining the folder from which gather the words
  final String? folder;

  /// Type of test being performed
  final Tests type;

  const KPTestStudyMode({
    Key? key,
    this.list,
    this.grammarList,
    this.practiceList,
    this.folder,
    required this.type,
    required this.testName,
  }) : super(key: key);

  @override
  State<KPTestStudyMode> createState() => _KPTestStudyModeState();
}

class _KPTestStudyModeState extends State<KPTestStudyMode> {
  final PageController _pageController = PageController();
  int _page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page?.round() != _page) {
        setState(() {
          _page = _pageController.page?.round() ?? 0;
        });
      }
    });
    getIt<LoadTestBloc>().add(LoadTestEventIdle(mode: widget.type));
    getIt<LoadGrammarTestBloc>()
        .add(LoadGrammarTestEventIdle(mode: widget.type));
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
                style: Theme.of(context).textTheme.bodyText1,
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
                    color: KPColors.getSubtle(context)),
              ),
              Expanded(
                  child: Text(
                "test_info_controlled_pace".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              )),
              Padding(
                padding: const EdgeInsets.only(left: KPMargins.margin16),
                child: Icon(Icons.sports_gymnastics_rounded,
                    color: KPColors.getSubtle(context)),
              ),
            ],
          )),
    );
  }

  Container _bullet(int index) {
    return Container(
      width: KPMargins.margin12,
      height: KPMargins.margin12,
      decoration: BoxDecoration(
        color: _page == index
            ? KPColors.getSecondaryColor(context)
            : KPColors.getSubtle(context),
        shape: BoxShape.circle,
      ),
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
            constraints: const BoxConstraints(maxHeight: 232),
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
                        list: widget.list,
                      ),
                      GrammarGrid(
                        type: widget.type,
                        folder: widget.folder,
                        testName: widget.testName,
                        practiceList: widget.practiceList,
                        list: widget.grammarList,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: KPMargins.margin4),
                SizedBox(
                  height: KPMargins.margin16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _bullet(0),
                      const SizedBox(width: KPMargins.margin12),
                      _bullet(1),
                    ],
                  ),
                ),
                const SizedBox(height: KPMargins.margin4),
              ],
            ),
          )
        else
          WordGrid(
            type: widget.type,
            folder: widget.folder,
            testName: widget.testName,
            practiceList: widget.practiceList,
            list: widget.list,
          )
      ],
    );
  }
}
