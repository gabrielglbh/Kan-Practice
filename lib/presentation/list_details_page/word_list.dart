import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details/list_details_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/kanji_item.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/practice_on_list_bottom_sheet.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class WordListWidget extends StatefulWidget {
  final WordList list;
  final String query;
  final Function() onStartTutorial;
  final FocusNode? searchBarFn;
  const WordListWidget({
    Key? key,
    required this.list,
    required this.query,
    required this.onStartTutorial,
    this.searchBarFn,
  }) : super(key: key);

  @override
  State<WordListWidget> createState() => _WordListWidgetState();
}

class _WordListWidgetState extends State<WordListWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  TabController? _tabController;
  StudyModes _selectedMode = StudyModes.writing;
  bool _aggrStats = false;

  /// Saves the last name of the current visited list
  String _listName = "";

  @override
  void initState() {
    _tabController =
        TabController(length: StudyModes.values.length, vsync: this);
    _tabController?.addListener(_tabControllerManagement);
    _scrollController.addListener(_scrollListener);
    _listName = widget.list.name;
    _aggrStats = getIt<PreferencesService>()
        .readData(SharedKeys.kanListListVisualization);
    getIt<ListDetailBloc>().add(
      ListDetailEventLoading(_listName, reset: true),
    );
    super.initState();
  }

  @override
  void dispose() {
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
      if (widget.query.isNotEmpty) {
        _addSearchingEvent(widget.query);
      }

      /// Else use the normal pagination
      else {
        _addLoadingEvent();
      }
    }
  }

  _tabControllerManagement() {
    widget.searchBarFn?.unfocus();
    setState(() {
      _selectedMode = StudyModes.values[_tabController?.index ?? 0];
    });
  }

  _onModeChange(StudyModes newMode) {
    widget.searchBarFn?.unfocus();
    setState(() {
      _selectedMode = newMode;
    });
    _tabController?.animateTo(newMode.index,
        duration: const Duration(milliseconds: KPAnimations.ms300),
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
        if (pv < 0) {
          _onModeChange(StudyModes.speaking);
        } else if (pv > 0) {
          _onModeChange(StudyModes.recognition);
        }
        break;
      case StudyModes.speaking:
        if (pv > 0) _onModeChange(StudyModes.listening);
        break;
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return getIt<ListDetailBloc>()
        .add(ListDetailEventLoading(_listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return getIt<ListDetailBloc>()
        .add(ListDetailEventSearching(query, _listName, reset: reset));
  }

  Future<void> _goToPractice(ListDetailStateLoadedPractice state) async {
    await Navigator.of(context)
        .pushNamed(state.mode.page,
            arguments: ModeArguments(
                studyList: state.list,
                isTest: false,
                mode: state.mode,
                testMode: Tests.blitz,
                studyModeHeaderDisplayName: _listName))
        .then(
          (value) => _addLoadingEvent(reset: true),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ListDetailBloc, ListDetailState>(
      listener: (context, state) async {
        if (state is ListDetailStateLoadedPractice) {
          await _goToPractice(state);
        } else if (state is ListDetailStateFailure) {
          if (state.error.isNotEmpty) {
            Utils.getSnackBar(context, state.error);
          }
        } else if (state is ListDetailStateLoaded) {
          if (getIt<PreferencesService>()
                  .readData(SharedKeys.haveSeenKanListDetailCoachMark) ==
              false) {
            widget.onStartTutorial();
          }
        }
      },
      builder: (context, state) {
        if (state is ListDetailStateLoaded) {
          _listName = state.name;
          return _body(state);
        } else if (state is ListDetailStateLoading ||
            state is ListDetailStateSearching ||
            state is ListDetailStateIdle ||
            state is ListDetailStateLoadedPractice) {
          return const KPProgressIndicator();
        } else if (state is ListDetailStateFailure) {
          return KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed".tr());
        } else {
          return Container();
        }
      },
    );
  }

  Column _body(ListDetailStateLoaded state) {
    return Column(
      children: [
        if (!_aggrStats)
          Padding(
            padding: const EdgeInsets.only(bottom: KPMargins.margin8),
            child: TabBar(
                controller: _tabController,
                tabs: List.generate(StudyModes.values.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      StudyModes.values[index].icon,
                      color: StudyModes.values[index].color,
                    ),
                  );
                })),
          ),
        _aggrStats
            ? Expanded(child: _kanjiList(state))
            : Expanded(
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
            title2: "list_details_practice_button_label".tr(),
            onTap: () async {
              if (_aggrStats) {
                return await PracticeListBottomSheet.show(
                        context, _listName, state.list)
                    .then(
                  (value) => _addLoadingEvent(reset: true),
                );
              }
              getIt<ListDetailBloc>()
                  .add(ListDetailEventLoadUpPractice(_listName, _selectedMode));
            }),
      ],
    );
  }

  Widget _kanjiList(ListDetailStateLoaded state) {
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
        Word? kanji = state.list[k];
        return KanjiItem(
          aggregateStats: _aggrStats,
          index: k,
          kanji: kanji,
          list: widget.list,
          listName: _listName,
          selectedMode: _selectedMode,
          onShowModal: () => widget.searchBarFn?.unfocus(),
          onTap: () async {
            await Navigator.of(context)
                .pushNamed(KanPracticePages.addKanjiPage,
                    arguments: AddWordArgs(listName: _listName, word: kanji))
                .then((code) {
              if (code == 0) _addLoadingEvent(reset: true);
            });
          },
          onRemoval: () => _addLoadingEvent(reset: true),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
