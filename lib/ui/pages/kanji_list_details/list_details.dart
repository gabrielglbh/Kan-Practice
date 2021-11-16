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
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/CustomTextForm.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

enum LearningMode { random, spatial }
extension on LearningMode {
  String get name {
    switch (this) {
      case LearningMode.random:
        return "list_details_learningMode_random".tr();
      case LearningMode.spatial:
        return "list_details_learningMode_spatial".tr();
    }
  }
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

  String _listName = "";

  @override
  void initState() {
    _listName = widget.list.name;
    super.initState();
  }

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
          list = await KanjiQueries.instance.getAllKanjiForPractice(_listName, _selectedMode);
          break;
        case LearningMode.random:
          state.list.shuffle();
          list = state.list;
          break;
      }

      switch (_selectedMode) {
        case StudyModes.writing:
          await Navigator.of(context).pushNamed(KanPracticePages.writingStudyPage,
              arguments: ModeArguments(studyList: list, isTest: false, mode: StudyModes.writing))
              .then((value) => _bloc..add(KanjiEventLoading(_listName)));
          break;
        case StudyModes.reading:
          await Navigator.of(context).pushNamed(KanPracticePages.readingStudyPage,
              arguments: ModeArguments(studyList: list, isTest: false, mode: StudyModes.reading))
              .then((value) => _bloc..add(KanjiEventLoading(_listName)));
          break;
        case StudyModes.recognition:
          await Navigator.of(context).pushNamed(KanPracticePages.recognitionStudyPage,
              arguments: ModeArguments(studyList: list, isTest: false, mode: StudyModes.recognition))
              .then((value) => _bloc..add(KanjiEventLoading(_listName)));
          break;
      }
    }
    else GeneralUtils.getSnackBar(context, "list_details_loadUpPractice_failed".tr());
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

  _updateName(String name) {
    if (name.isNotEmpty) _bloc..add(UpdateKanList(name, _listName));
  }

  _updateKanListName() {
    TextEditingController _nameController = TextEditingController();
    FocusNode _nameControllerFn = FocusNode();
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        title: Text("list_details_updateKanListName_title".tr()),
        content: Container(
          height: 140,
          child: CustomTextForm(
            hint: _listName,
            header: 'list_details_updateKanListName_header'.tr(),
            controller: _nameController,
            focusNode: _nameControllerFn,
            autofocus: true,
            onEditingComplete: () {
              Navigator.of(context).pop();
              _updateName(_nameController.text);
            },
          ),
        ),
        positiveButtonText: "list_details_updateKanListName_positive".tr(),
        onPositive: () => _updateName(_nameController.text)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((_bloc.state as KanjiListDetailStateLoaded).list.length == 0) {
          await ListQueries.instance.updateList(_listName, {
            KanListTableFields.totalWinRateWritingField: -1,
            KanListTableFields.totalWinRateReadingField: -1,
            KanListTableFields.totalWinRateRecognitionField: -1
          });
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: CustomSizes.appBarHeight,
          title: BlocProvider(
            create: (_) => _bloc..add(KanjiEventLoading(_listName)),
            child: BlocBuilder<KanjiListDetailBloc, KanjiListDetailState>(
              builder: (context, state) {
                if (state is KanjiListDetailStateLoaded) {
                  _listName = state.name;
                  return FittedBox(
                    fit: BoxFit.fitWidth,
                    child: GestureDetector(
                      onTap: () async => await _updateKanListName(),
                      child: Text(state.name, overflow: TextOverflow.ellipsis),
                    )
                  );
                }
                else return Container();
              },
            ),
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
                context, practiceList: _listName
              ),
              icon: Icon(Icons.flash_on_rounded),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(KanPracticePages.addKanjiPage,
                    arguments: AddKanjiArgs(listName: _listName))
                    .then((code) {
                  _bloc..add(KanjiEventLoading(_listName));
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: BlocProvider(
          create: (_) => _bloc..add(KanjiEventLoading(_listName)),
          child: BlocBuilder<KanjiListDetailBloc, KanjiListDetailState>(
            builder: (context, state) {
              if (state is KanjiListDetailStateLoaded) {
                _listName = state.name;
                return _body(state);
              }
              else if (state is KanjiListDetailStateLoading)
                return CustomProgressIndicator();
              else if (state is KanjiListDetailStateFailure)
                return EmptyList(
                  onRefresh: () => _bloc..add(KanjiEventLoading(_listName)),
                  message: "list_details_load_failed".tr()
                );
              else
                return Container();
            },
          ),
        ),
      ),
    );
  }

  Column _body(KanjiListDetailStateLoaded state) {
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
          padding: EdgeInsets.only(bottom: 8),
          child: CustomButton(
            title1: "list_details_practice_button_label_ext".tr(),
            title2: "list_details_practice_button_label".tr(),
            width: MediaQuery.of(context).size.width / 2,
            onTap: () async => await _loadUpPractice(state)
          ),
        )
      ],
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
                ? LearningMode.spatial.name
                : LearningMode.random.name,
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
    if (state.list.isEmpty)
      return EmptyList(
        onRefresh: () => _bloc..add(KanjiEventLoading(_listName)),
        message: "list_details_empty".tr()
      );
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
          index: k,
          kanji: kanji,
          list: widget.list,
          listName: _listName,
          selectedMode: _selectedMode,
          onTap: () async {
            await Navigator.of(context).pushNamed(KanPracticePages.addKanjiPage,
                arguments: AddKanjiArgs(listName: _listName, kanji: kanji))
                .then((code) {
              if (code == 0) _bloc..add(KanjiEventLoading(_listName));
            });
          },
          onRemoval: () => _bloc..add(KanjiEventLoading(_listName)),
        );
      },
    );
  }
}
