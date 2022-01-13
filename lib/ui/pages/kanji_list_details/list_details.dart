import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/bloc/details_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_list_details/widgets/kanji_item.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/widgets/blitz/BlitzBottomSheet.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/CustomSearchBar.dart';
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

class _KanjiListDetailsState extends State<KanjiListDetails> with SingleTickerProviderStateMixin {
  final KanjiListDetailBloc _bloc = KanjiListDetailBloc();
  final ScrollController _scrollController = ScrollController();

  FocusNode? _searchBarFn;
  TabController? _tabController;
  StudyModes _selectedMode = StudyModes.writing;
  LearningMode _learningMode = LearningMode.spatial;

  /// Loading offset for normal pagination
  int _loadingTimes = 0;
  /// Loading offset for search bar list pagination
  int _loadingTimesForSearch = 0;
  /// Saves the last state of the query
  String _query = "";
  /// Saves the last name of the current visited list
  String _listName = "";
  bool _searchHasFocus = false;

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _tabController = TabController(length: StudyModes.values.length, vsync: this);
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
    _bloc.close();
    super.dispose();
  }

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      /// If the query is empty, use the pagination for search bar
      if (_query.isNotEmpty) {
        _loadingTimesForSearch += 1;
        _addSearchingEvent(_query, offset: _loadingTimesForSearch);
      }
      /// Else use the normal pagination
      else {
        _loadingTimes += 1;
        _addLoadingEvent(offset: _loadingTimes);
      }
    }
  }

  _tabControllerManagement() {
    _searchBarFn?.unfocus();
    setState(() {
      _selectedMode = StudyModes.values[_tabController?.index ?? 0];
    });
  }

  _focusListener() => setState(() {
    _searchHasFocus = (_searchBarFn?.hasFocus ?? false);
    /// Everytime the user loses focus on the search bar, empty the query
    /// in order to paginate properly
    if (!_searchHasFocus) _query = "";
  });

  _onModeChange(StudyModes newMode) {
    _searchBarFn?.unfocus();
    setState(() {
      switch (newMode) {
        case StudyModes.writing:
          _selectedMode = StudyModes.writing; break;
        case StudyModes.reading:
          _selectedMode = StudyModes.reading; break;
        case StudyModes.recognition:
          _selectedMode = StudyModes.recognition; break;
        case StudyModes.listening:
          _selectedMode = StudyModes.listening; break;
      }
    });
    _tabController?.animateTo(newMode.index,
        duration: Duration(milliseconds: CustomAnimations.ms300),
        curve: Curves.easeInOut);
  }

  _updateSelectedModePageView(double pv) {
    switch (_selectedMode) {
      case StudyModes.writing:
        if (pv < 0) _onModeChange(StudyModes.reading);
        break;
      case StudyModes.reading:
        if (pv < 0) _onModeChange(StudyModes.recognition);
        else if (pv > 0) _onModeChange(StudyModes.writing);
        break;
      case StudyModes.recognition:
        if (pv < 0) _onModeChange(StudyModes.listening);
        else if (pv > 0) _onModeChange(StudyModes.reading);
        break;
      case StudyModes.listening:
        if (pv > 0) _onModeChange(StudyModes.recognition);
        break;
    }
  }

  _addLoadingEvent({int offset = 0}) {
    /// If the loading occurs with an offset of 0, it means it is another
    /// fresh load, so we need to update the _loadingTimes offset to 0
    if (offset == 0) _loadingTimes = 0;
    return _bloc..add(KanjiEventLoading(_listName, offset: offset));
  }

  _addSearchingEvent(String query, {int offset = 0}) =>
      _bloc..add(KanjiEventSearching(query, _listName, offset));

  _updateName(String name) {
    if (name.isNotEmpty) _bloc..add(UpdateKanList(name, _listName));
  }

  _updateKanListName() {
    TextEditingController _nameController = TextEditingController();
    FocusNode _nameControllerFn = FocusNode();
    showDialog(context: context, builder: (context) {
      return CustomDialog(
        title: Text("list_details_updateKanListName_title".tr()),
        content: CustomTextForm(
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
        positiveButtonText: "list_details_updateKanListName_positive".tr(),
        onPositive: () => _updateName(_nameController.text)
      );
    });
  }

  Future<void> _goToPractice(KanjiListDetailStateLoadedPractice state) async {
    switch (state.mode) {
      case StudyModes.writing:
        await Navigator.of(context).pushNamed(KanPracticePages.writingStudyPage,
            arguments: ModeArguments(studyList: state.list, isTest: false, mode: StudyModes.writing))
            .then((value) => _addLoadingEvent());
        break;
      case StudyModes.reading:
        await Navigator.of(context).pushNamed(KanPracticePages.readingStudyPage,
            arguments: ModeArguments(studyList: state.list, isTest: false, mode: StudyModes.reading))
            .then((value) => _addLoadingEvent());
        break;
      case StudyModes.recognition:
        await Navigator.of(context).pushNamed(KanPracticePages.recognitionStudyPage,
            arguments: ModeArguments(studyList: state.list, isTest: false, mode: StudyModes.recognition))
            .then((value) => _addLoadingEvent());
        break;
      case StudyModes.listening:
        await Navigator.of(context).pushNamed(KanPracticePages.listeningStudyPage,
            arguments: ModeArguments(studyList: state.list, isTest: false, mode: StudyModes.listening))
            .then((value) => _addLoadingEvent());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_searchHasFocus) {
          _addLoadingEvent();
          _searchBarFn?.unfocus();
          return false;
        } else return true;
      },
      child: BlocProvider<KanjiListDetailBloc>(
        create: (_) => _addLoadingEvent(),
        child: Scaffold(
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - CustomSizes.appBarHeight - Margins.margin32,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomSearchBar(
                    hint: "list_details_searchBar_hint".tr(),
                    focus: _searchBarFn,
                    onQuery: (String query) {
                      /// Everytime the user queries, reset the query itself and
                      /// the pagination index
                      _query = query;
                      _loadingTimesForSearch = 0;
                      _addSearchingEvent(query);
                    },
                    onExitSearch: () => _addLoadingEvent(),
                  ),
                  Expanded(
                    child: BlocListener<KanjiListDetailBloc, KanjiListDetailState>(
                      listener: (context, state) async {
                        if (state is KanjiListDetailStateLoadedPractice) {
                          await _goToPractice(state);
                        } else if (state is KanjiListDetailStateFailure) {
                          if (state.error.isNotEmpty)
                            GeneralUtils.getSnackBar(context, state.error);
                        }
                      },
                      child: BlocBuilder<KanjiListDetailBloc, KanjiListDetailState>(
                        builder: (context, state) {
                          if (state is KanjiListDetailStateLoaded) {
                            _listName = state.name;
                            return _body(state);
                          }
                          else if (state is KanjiListDetailStateLoading ||
                              state is KanjiListDetailStateSearching ||
                              state is KanjiListDetailStateLoadedPractice)
                            return CustomProgressIndicator();
                          else if (state is KanjiListDetailStateFailure)
                            return EmptyList(
                                showTryButton: true,
                                onRefresh: () => _addLoadingEvent(),
                                message: "list_details_load_failed".tr()
                            );
                          else
                            return Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: CustomSizes.appBarHeight,
      title: BlocBuilder<KanjiListDetailBloc, KanjiListDetailState>(
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
          onPressed: () async => await BlitzBottomSheet.show(
              context, practiceList: _listName
          ),
          icon: Icon(Icons.flash_on_rounded),
        ),
        IconButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(KanPracticePages.addKanjiPage,
                arguments: AddKanjiArgs(listName: _listName))
                .then((code) => _addLoadingEvent(offset: _loadingTimes));
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  Column _body(KanjiListDetailStateLoaded state) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Margins.margin8),
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
            })
          ),
        ),
        Expanded(
          child: GestureDetector(
            onHorizontalDragEnd: (details) {
              double? pv = details.primaryVelocity;
              if (pv != null) _updateSelectedModePageView(pv);
            },
            child: _kanjiList(state),
          )
        ),
        CustomButton(
          title1: "${"list_details_practice_button_label_ext".tr()}",
          title2: "${"list_details_practice_button_label".tr()} • ${
              _learningMode == LearningMode.spatial
                  ? LearningMode.spatial.name : LearningMode.random.name}",
          onTap: () => _bloc..add(KanjiEventLoadUpPractice(_learningMode, _listName, _selectedMode))
        ),
      ],
    );
  }

  Widget _tabBarElement(String mode) {
    return Container(
      height: CustomSizes.defaultSizeLearningModeBar,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(mode, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _kanjiList(KanjiListDetailStateLoaded state) {
    if (state.list.isEmpty)
      return EmptyList(
        showTryButton: true,
        onRefresh: () => _addLoadingEvent(),
        message: "list_details_empty".tr()
      );
    return GridView.builder(
      key: PageStorageKey<String>('kanjiListController'),
      itemCount: state.list.length,
      controller: _scrollController,
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
          onShowModal: () => _searchBarFn?.unfocus(),
          onTap: () async {
            await Navigator.of(context).pushNamed(KanPracticePages.addKanjiPage,
                arguments: AddKanjiArgs(listName: _listName, kanji: kanji))
                .then((code) {
              if (code == 0) _addLoadingEvent();
            });
          },
          onRemoval: () => _addLoadingEvent(),
        );
      },
    );
  }
}
