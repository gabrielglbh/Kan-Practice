import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/tutorial/tutorial_manager.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/core/types/learning_mode.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/bloc/details_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/widgets/add_to_folder_bottom_sheet.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/widgets/kanji_item.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:kanpractice/ui/widgets/kp_search_bar.dart';
import 'package:kanpractice/ui/widgets/kp_text_form.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class KanjiListDetails extends StatefulWidget {
  final KanjiList list;
  const KanjiListDetails({Key? key, required this.list}) : super(key: key);

  @override
  State<KanjiListDetails> createState() => _KanjiListDetailsState();
}

class _KanjiListDetailsState extends State<KanjiListDetails>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  /// Tutorial Global Keys
  final GlobalKey vocabulary = GlobalKey();
  final GlobalKey addVocabulary = GlobalKey();
  final GlobalKey actions = GlobalKey();
  final GlobalKey changeName = GlobalKey();

  FocusNode? _searchBarFn;
  TabController? _tabController;
  StudyModes _selectedMode = StudyModes.writing;
  LearningMode _learningMode = LearningMode.spatial;

  /// Saves the last state of the query
  String _query = "";

  /// Saves the last name of the current visited list
  String _listName = "";

  bool _searchHasFocus = false;
  bool _onTutorial = false;

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _tabController =
        TabController(length: StudyModes.values.length, vsync: this);
    _tabController?.addListener(_tabControllerManagement);
    _searchBarFn?.addListener(_focusListener);
    _scrollController.addListener(_scrollListener);
    _listName = widget.list.name;
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn?.removeListener(_focusListener);
    _searchBarFn?.dispose();
    _tabController?.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      /// If the query is empty, use the pagination for search bar
      if (_query.isNotEmpty) {
        _addSearchingEvent(_query);
      }

      /// Else use the normal pagination
      else {
        _addLoadingEvent();
      }
    }
  }

  _tabControllerManagement() {
    _searchBarFn?.unfocus();
    setState(() {
      _selectedMode = StudyModes.values[_tabController?.index ?? 0];
    });
  }

  _focusListener() =>
      setState(() => _searchHasFocus = (_searchBarFn?.hasFocus ?? false));

  _onModeChange(StudyModes newMode) {
    _searchBarFn?.unfocus();
    setState(() {
      switch (newMode) {
        case StudyModes.writing:
          _selectedMode = StudyModes.writing;
          break;
        case StudyModes.reading:
          _selectedMode = StudyModes.reading;
          break;
        case StudyModes.recognition:
          _selectedMode = StudyModes.recognition;
          break;
        case StudyModes.listening:
          _selectedMode = StudyModes.listening;
          break;
      }
    });
    _tabController?.animateTo(newMode.index,
        duration: const Duration(milliseconds: CustomAnimations.ms300),
        curve: Curves.easeInOut);
  }

  _updateSelectedModePageView(double pv) {
    switch (_selectedMode) {
      case StudyModes.writing:
        if (pv < 0) _onModeChange(StudyModes.reading);
        break;
      case StudyModes.reading:
        if (pv < 0) {
          _onModeChange(StudyModes.recognition);
        } else if (pv > 0) {
          _onModeChange(StudyModes.writing);
        }
        break;
      case StudyModes.recognition:
        if (pv < 0) {
          _onModeChange(StudyModes.listening);
        } else if (pv > 0) {
          _onModeChange(StudyModes.reading);
        }
        break;
      case StudyModes.listening:
        if (pv > 0) _onModeChange(StudyModes.recognition);
        break;
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return BlocProvider.of<KanjiListDetailBloc>(context)
        .add(KanjiEventLoading(_listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return BlocProvider.of<KanjiListDetailBloc>(context)
        .add(KanjiEventSearching(query, _listName, reset: reset));
  }

  _updateName(BuildContext bloc, String name) {
    if (name.isNotEmpty) {
      BlocProvider.of<KanjiListDetailBloc>(bloc)
          .add(UpdateKanList(name, _listName));
    }
  }

  _updateKanListName(BuildContext bloc) {
    TextEditingController nameController = TextEditingController();
    FocusNode nameControllerFn = FocusNode();
    showDialog(
        context: bloc,
        builder: (context) {
          return KPDialog(
              title: Text("list_details_updateKanListName_title".tr()),
              content: KPTextForm(
                hint: _listName,
                maxLength: 32,
                header: 'list_details_updateKanListName_header'.tr(),
                controller: nameController,
                focusNode: nameControllerFn,
                autofocus: true,
                onEditingComplete: () {
                  Navigator.of(context).pop();
                  _updateName(bloc, nameController.text);
                },
              ),
              positiveButtonText:
                  "list_details_updateKanListName_positive".tr(),
              onPositive: () => _updateName(bloc, nameController.text));
        });
  }

  Future<void> _goToPractice(KanjiListDetailStateLoadedPractice state) async {
    switch (state.mode) {
      case StudyModes.writing:
        await Navigator.of(context)
            .pushNamed(KanPracticePages.writingStudyPage,
                arguments: ModeArguments(
                    studyList: state.list,
                    isTest: false,
                    mode: StudyModes.writing,
                    testMode: Tests.blitz,
                    display: widget.list.name))
            .then((value) => _addLoadingEvent(reset: true));
        break;
      case StudyModes.reading:
        await Navigator.of(context)
            .pushNamed(KanPracticePages.readingStudyPage,
                arguments: ModeArguments(
                    studyList: state.list,
                    isTest: false,
                    mode: StudyModes.reading,
                    testMode: Tests.blitz,
                    display: widget.list.name))
            .then((value) => _addLoadingEvent(reset: true));
        break;
      case StudyModes.recognition:
        await Navigator.of(context)
            .pushNamed(KanPracticePages.recognitionStudyPage,
                arguments: ModeArguments(
                    studyList: state.list,
                    isTest: false,
                    mode: StudyModes.recognition,
                    testMode: Tests.blitz,
                    display: widget.list.name))
            .then((value) => _addLoadingEvent(reset: true));
        break;
      case StudyModes.listening:
        await Navigator.of(context)
            .pushNamed(KanPracticePages.listeningStudyPage,
                arguments: ModeArguments(
                    studyList: state.list,
                    isTest: false,
                    mode: StudyModes.listening,
                    testMode: Tests.blitz,
                    display: widget.list.name))
            .then((value) => _addLoadingEvent(reset: true));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// BlocProvider is defined at route level in order for the whole context of the
    /// class to be accessible to the provider
    return KPScaffold(
      onWillPop: () async {
        if (_onTutorial) return false;
        if (_searchHasFocus) {
          _addLoadingEvent(reset: true);
          _searchBarFn?.unfocus();
          return false;
        } else {
          return true;
        }
      },
      appBarTitle: BlocBuilder<KanjiListDetailBloc, KanjiListDetailState>(
        builder: (context, state) {
          if (state is KanjiListDetailStateLoaded) {
            _listName = state.name;
            return FittedBox(
                fit: BoxFit.fitWidth,
                child: GestureDetector(
                  onTap: () async => await _updateKanListName(context),
                  child: Text(state.name,
                      key: changeName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appBarTheme.titleTextStyle),
                ));
          } else {
            return Container();
          }
        },
      ),
      appBarActions: [
        Row(
          key: actions,
          children: [
            IconButton(
              icon: Icon(_learningMode == LearningMode.spatial
                  ? LearningMode.spatial.icon
                  : LearningMode.random.icon),
              onPressed: () => setState(() {
                if (_learningMode == LearningMode.spatial) {
                  _learningMode = LearningMode.random;
                } else {
                  _learningMode = LearningMode.spatial;
                }
              }),
            ),
            IconButton(
              onPressed: () async => await KPBlitzBottomSheet.show(context,
                  practiceList: _listName),
              icon: const Icon(Icons.flash_on_rounded),
            ),
          ],
        ),
        IconButton(
          onPressed: () async {
            await AddToFolderBottomSheet.show(context, widget.list.name);
          },
          icon: const Icon(Icons.create_new_folder_rounded),
        ),
      ],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: KPSearchBar(
                  hint: "list_details_searchBar_hint".tr(),
                  focus: _searchBarFn,
                  onQuery: (String query) {
                    /// Everytime the user queries, reset the query itself and
                    /// the pagination index
                    _query = query;
                    _addSearchingEvent(query, reset: true);
                  },
                  onExitSearch: () {
                    /// Empty the query
                    _query = "";
                    _addLoadingEvent(reset: true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Margins.margin8),
                child: IconButton(
                  key: addVocabulary,
                  splashRadius: 26,
                  padding:
                      const EdgeInsets.symmetric(horizontal: Margins.margin8),
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushNamed(KanPracticePages.addKanjiPage,
                            arguments: AddKanjiArgs(listName: _listName))
                        .then((code) => _addLoadingEvent(reset: true));
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<KanjiListDetailBloc, KanjiListDetailState>(
              key: vocabulary,
              listener: (context, state) async {
                if (state is KanjiListDetailStateLoadedPractice) {
                  await _goToPractice(state);
                } else if (state is KanjiListDetailStateFailure) {
                  if (state.error.isNotEmpty) {
                    GeneralUtils.getSnackBar(context, state.error);
                  }
                } else if (state is KanjiListDetailStateLoaded) {
                  if (StorageManager.readData(
                          StorageManager.haveSeenKanListDetailCoachMark) ==
                      false) {
                    _onTutorial = true;
                    await TutorialCoach(
                            [vocabulary, addVocabulary, actions, changeName],
                            CoachTutorialParts.details)
                        .showTutorial(context,
                            onEnd: () => _onTutorial = false);
                  }
                }
              },
              builder: (context, state) {
                if (state is KanjiListDetailStateLoaded) {
                  _listName = state.name;
                  return _body(context, state);
                } else if (state is KanjiListDetailStateLoading ||
                    state is KanjiListDetailStateSearching ||
                    state is KanjiListDetailStateLoadedPractice) {
                  return const KPProgressIndicator();
                } else if (state is KanjiListDetailStateFailure) {
                  return KPEmptyList(
                      showTryButton: true,
                      onRefresh: () => _addLoadingEvent(reset: true),
                      message: "list_details_load_failed".tr());
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _body(BuildContext bloc, KanjiListDetailStateLoaded state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Margins.margin8),
          child: TabBar(
              controller: _tabController,
              tabs: List.generate(StudyModes.values.length, (index) {
                switch (StudyModes.values[index]) {
                  case StudyModes.writing:
                    return _tabBarElement(StudyModes.writing.mode);
                  case StudyModes.reading:
                    return _tabBarElement(StudyModes.reading.mode);
                  case StudyModes.recognition:
                    return _tabBarElement(StudyModes.recognition.mode);
                  case StudyModes.listening:
                    return _tabBarElement(StudyModes.listening.mode);
                }
              })),
        ),
        Expanded(
            child: GestureDetector(
          /// Dismiss keyboard if possible whenever a vertical or horizontal
          /// drag down occurs on screen
          onVerticalDragStart: (details) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onHorizontalDragStart: (details) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onHorizontalDragEnd: (details) {
            double? pv = details.primaryVelocity;
            if (pv != null) _updateSelectedModePageView(pv);
          },
          child: _kanjiList(state),
        )),
        KPButton(
            title1: "list_details_practice_button_label_ext".tr(),
            title2:
                "${"list_details_practice_button_label".tr()} • ${_learningMode == LearningMode.spatial ? LearningMode.spatial.name : LearningMode.random.name}",
            onTap: () => BlocProvider.of<KanjiListDetailBloc>(bloc).add(
                KanjiEventLoadUpPractice(
                    _learningMode, _listName, _selectedMode))),
      ],
    );
  }

  Widget _tabBarElement(String mode) {
    return Container(
      height: CustomSizes.defaultSizeLearningModeBar,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(mode,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }

  Widget _kanjiList(KanjiListDetailStateLoaded state) {
    if (state.list.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty".tr());
    }
    return GridView.builder(
      key: const PageStorageKey<String>('kanjiListController'),
      itemCount: state.list.length,
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 2),
      itemBuilder: (context, k) {
        Kanji? kanji = state.list[k];
        return KanjiItem(
          index: k,
          kanji: kanji,
          list: widget.list,
          listName: _listName,
          selectedMode: _selectedMode,
          onShowModal: () => _searchBarFn?.unfocus(),
          onTap: () async {
            await Navigator.of(context)
                .pushNamed(KanPracticePages.addKanjiPage,
                    arguments: AddKanjiArgs(listName: _listName, kanji: kanji))
                .then((code) {
              if (code == 0) _addLoadingEvent(reset: true);
            });
          },
          onRemoval: () => _addLoadingEvent(reset: true),
        );
      },
    );
  }
}
