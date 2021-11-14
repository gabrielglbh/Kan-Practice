import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/bloc/details_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/widgets/kanji_item.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/BlitzBottomSheet.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';

enum LearningMode { random, spatial }
extension on LearningMode {
  IconData get icon {
    switch (this) {
      case LearningMode.random:
        return Icons.shuffle;
      case LearningMode.spatial:
        return Icons.spa_rounded;
    }
  }
}

class KanjiListDetails extends StatefulWidget {
  final KanjiList list;
  const KanjiListDetails({required this.list});

  @override
  _KanjiListDetailsState createState() => _KanjiListDetailsState();
}

class _KanjiListDetailsState extends State<KanjiListDetails> {
  KanjiListDetailBloc _bloc = KanjiListDetailBloc();
  PageController _controller = PageController();
  StudyModes _selectedMode = StudyModes.writing;
  LearningMode _learningMode = LearningMode.spatial;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadUpPractice(KanjiListDetailStateLoaded state) async {
    if (state.list.length != 0) {
      /// Enable spatial learning, first elements are the ones with less %
      List<Kanji> list = [];
      switch (_learningMode) {
        case LearningMode.spatial:
          list = await KanjiQueries.instance.getAllKanjiForPractice(widget.list.name, _selectedMode);
          break;
        case LearningMode.random:
          state.list.shuffle();
          list = state.list;
          break;
      }

      switch (_selectedMode) {
        case StudyModes.writing:
          await Navigator.of(context).pushNamed(writingStudyPage,
              arguments: ModeArguments(studyList: list, isTest: false, mode: StudyModes.writing))
              .then((value) => _bloc..add(KanjiEventLoading(widget.list.name)));
          break;
        case StudyModes.reading:
          await Navigator.of(context).pushNamed(readingStudyPage,
              arguments: ModeArguments(studyList: list, isTest: false, mode: StudyModes.reading))
              .then((value) => _bloc..add(KanjiEventLoading(widget.list.name)));
          break;
        case StudyModes.recognition:
          await Navigator.of(context).pushNamed(recognitionStudyPage,
              arguments: ModeArguments(studyList: list, isTest: false, mode: StudyModes.recognition))
              .then((value) => _bloc..add(KanjiEventLoading(widget.list.name)));
          break;
      }
    }
    else GeneralUtils.getSnackBar(context, "Add new Kanji to study first!");
  }

  _onChangePage(int newPage) {
    setState(() {
      if (newPage == 0) _selectedMode = StudyModes.writing;
      else if (newPage == 1) _selectedMode = StudyModes.reading;
      else _selectedMode = StudyModes.recognition;
    });
    _controller.animateToPage(newPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  _updateSelectedModePageView(double pv) {
    // Swiping in right direction.
    if (pv < 0) {
      switch (_selectedMode) {
        case StudyModes.writing:
          _onChangePage(1);
          break;
        case StudyModes.reading:
          _onChangePage(2);
          break;
        case StudyModes.recognition:
        default:
          break;
      }
    }
    // Swiping in left direction.
    if (pv > 0) {
      switch (_selectedMode) {
        case StudyModes.reading:
          _onChangePage(0);
          break;
        case StudyModes.recognition:
          _onChangePage(1);
          break;
        case StudyModes.writing:
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((_bloc.state as KanjiListDetailStateLoaded).list.length == 0) {
          await ListQueries.instance.updateList(widget.list.name, {
            totalWinRateWritingField: -1,
            totalWinRateReadingField: -1,
            totalWinRateRecognitionField: -1
          });
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(widget.list.name, overflow: TextOverflow.ellipsis),
          ),
          actions: [
            IconButton(
              icon: Icon(_learningMode == LearningMode.spatial
                  ? LearningMode.spatial.icon
                  : LearningMode.random.icon),
              onPressed: () => setState(() {
                if (_learningMode == LearningMode.spatial) _learningMode = LearningMode.random;
                else _learningMode = LearningMode.spatial;
              }),
            ),
            IconButton(
              onPressed: () async => await BlitzBottomSheet.callBlitzModeBottomSheet(
                context, practiceList: widget.list.name
              ),
              icon: Icon(Icons.flash_on_rounded),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(addKanjiPage,
                    arguments: AddKanjiArgs(list: widget.list))
                    .then((code) {
                  _bloc..add(KanjiEventLoading(widget.list.name));
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: BlocProvider(
          create: (_) => _bloc..add(KanjiEventLoading(widget.list.name)),
          child: BlocBuilder<KanjiListDetailBloc, KanjiListDetailState>(
            builder: (context, state) {
              if (state is KanjiListDetailStateLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          double? pv = details.primaryVelocity;
                          if (pv != null) _updateSelectedModePageView(pv);
                        },
                        child: _kanjiList(state),
                      )
                    ),
                    Divider(),
                    Container(
                      height: 50,
                      child: PageView(
                        controller: _controller,
                        children: [
                          _pageViewHeader(StudyModes.writing.mode),
                          _pageViewHeader(StudyModes.reading.mode),
                          _pageViewHeader(StudyModes.recognition.mode),
                        ],
                        onPageChanged: (newPage) => _onChangePage(newPage),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 32),
                      child: CustomButton(
                        title1: "練習",
                        title2: "Practice",
                        width: MediaQuery.of(context).size.width / 2,
                        onTap: () async => await _loadUpPractice(state)
                      ),
                    )
                  ],
                );
              }
              else if (state is KanjiListDetailStateLoading)
                return CustomProgressIndicator();
              else if (state is KanjiListDetailStateFailure)
                return EmptyList(message: "Failed to retrieve kanjis");
              else
                return Container();
            },
          ),
        ),
      ),
    );
  }

  Row _pageViewHeader(String mode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Visibility(
          visible: _selectedMode != StudyModes.writing,
          child: Icon(Icons.keyboard_arrow_left_rounded)
        ),
        Column(
          children: [
            Text("$mode %", textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
            Text(_learningMode == LearningMode.spatial
                ? "Spatial Learning" : "Random Learning",
                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Visibility(
          visible: _selectedMode != StudyModes.recognition,
          child: Icon(Icons.keyboard_arrow_right_rounded),
        ),
      ],
    );
  }

  Widget _kanjiList(KanjiListDetailStateLoaded state) {
    if (state.list.isEmpty) return EmptyList(message: "No available kanji.");
    return GridView.builder(
      key: PageStorageKey<String>('kanjiListController'),
      itemCount: state.list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 2
      ),
      itemBuilder: (context, k) {
        Kanji? kanji = state.list[k];
        return KanjiItem(
          kanji: kanji,
          listName: widget.list.name,
          selectedMode: _selectedMode,
          onTap: () async {
            await Navigator.of(context).pushNamed(addKanjiPage,
                arguments: AddKanjiArgs(list: widget.list, kanji: kanji))
                .then((code) {
              if (code == 0) _bloc..add(KanjiEventLoading(widget.list.name));
            });
          },
          onRemoval: () => _bloc..add(KanjiEventLoading(widget.list.name)),
        );
      },
    );
  }
}
