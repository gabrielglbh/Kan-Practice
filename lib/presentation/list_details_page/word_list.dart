import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details_words/list_details_words_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/list_details_widgets/kp_word_item.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/practice_words_bottom_sheet.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class WordListWidget extends StatefulWidget {
  final WordList list;
  final String listName;
  final String query;
  final Function() onStartTutorial;
  final FocusNode? searchBarFn;
  const WordListWidget(
      {super.key,
      required this.list,
      required this.query,
      required this.onStartTutorial,
      this.searchBarFn,
      required this.listName});

  @override
  State<WordListWidget> createState() => _WordListWidgetState();
}

class _WordListWidgetState extends State<WordListWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  TabController? _tabController;
  StudyModes _selectedMode = StudyModes.writing;
  bool _aggrStats = false;

  @override
  void initState() {
    _tabController =
        TabController(length: StudyModes.values.length, vsync: this);
    _tabController?.addListener(_tabControllerManagement);
    _scrollController.addListener(_scrollListener);
    _aggrStats = getIt<PreferencesService>()
        .readData(SharedKeys.kanListListVisualization);
    context.read<ListDetailsWordsBloc>().add(
          ListDetailsWordsEventLoading(widget.listName, reset: true),
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
    return context
        .read<ListDetailsWordsBloc>()
        .add(ListDetailsWordsEventLoading(widget.listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return context.read<ListDetailsWordsBloc>().add(
        ListDetailsWordsEventSearching(query, widget.listName, reset: reset));
  }

  Future<void> _goToPractice(List<Word> words, StudyModes mode) async {
    await Navigator.of(context)
        .pushNamed(mode.page,
            arguments: ModeArguments(
                studyList: words,
                isTest: false,
                mode: mode,
                testMode: Tests.blitz,
                studyModeHeaderDisplayName: widget.listName))
        .then(
          (value) => _addLoadingEvent(reset: true),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ListDetailsWordsBloc, ListDetailsWordsState>(
      listener: (context, state) async {
        state.mapOrNull(
          practiceLoaded: (value) async {
            await _goToPractice(value.list, value.mode);
          },
          error: (error) {
            if (error.message.isNotEmpty) {
              Utils.getSnackBar(context, error.message);
            }
          },
          loaded: (_) {
            if (getIt<PreferencesService>()
                    .readData(SharedKeys.haveSeenKanListDetailCoachMark) ==
                false) {
              widget.onStartTutorial();
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (words, _) => Column(
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
                  ? Expanded(child: _wordList(words))
                  : Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          double? pv = details.primaryVelocity;
                          if (pv != null) _updateSelectedModePageView(pv);
                        },
                        child: _wordList(words),
                      ),
                    ),
              if (words.isNotEmpty)
                KPButton(
                  title1: "list_details_practice_button_label_ext".tr(),
                  title2: "list_details_practice_button_label".tr(),
                  onTap: () async {
                    if (_aggrStats) {
                      return await PracticeWordsBottomSheet.show(
                              context, widget.listName, words)
                          .then(
                        (value) => _addLoadingEvent(reset: true),
                      );
                    }
                    context.read<ListDetailsWordsBloc>().add(
                        ListDetailsWordsEventLoadUpPractice(
                            widget.listName, _selectedMode));
                  },
                ),
            ],
          ),
          error: (_) => KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed".tr()),
          orElse: () => const KPProgressIndicator(),
        );
      },
    );
  }

  Widget _wordList(List<Word> words) {
    if (words.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty".tr());
    }

    KPWordItem wordElem(int index, bool isBadge) {
      Word? word = words[index];
      return KPWordItem(
        aggregateStats: _aggrStats,
        index: index,
        word: word,
        listName: widget.listName,
        selectedMode: _selectedMode,
        onShowModal: () => widget.searchBarFn?.unfocus(),
        isBadge: isBadge,
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(KanPracticePages.addWordPage,
                  arguments: AddWordArgs(listName: widget.listName, word: word))
              .then((code) {
            if (code == 0) _addLoadingEvent(reset: true);
          });
        },
        onRemoval: () => _addLoadingEvent(reset: true),
      );
    }

    return ListView.separated(
      key: const PageStorageKey<String>('wordListController'),
      itemCount: words.length,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      controller: _scrollController,
      separatorBuilder: (_, __) => const Divider(height: KPMargins.margin4),
      itemBuilder: (context, k) => wordElem(k, false),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
