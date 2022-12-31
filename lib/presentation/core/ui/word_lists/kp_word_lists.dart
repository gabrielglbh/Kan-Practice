import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_details/folder_details_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/word_lists/widgets/word_list_tile.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_switch.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:easy_localization/easy_localization.dart';

class KPWordLists extends StatefulWidget {
  final Function() removeFocus;
  final Function() onScrolledToBottom;
  final String? folder;
  final bool withinFolder;
  const KPWordLists({
    Key? key,
    required this.removeFocus,
    required this.onScrolledToBottom,
    this.withinFolder = false,
    this.folder,
  }) : super(key: key);

  @override
  State<KPWordLists> createState() => _KPWordListsState();
}

class _KPWordListsState extends State<KPWordLists>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  /// This variable keeps track of the actual filter applied. The value is
  /// saved into the shared preferences when a filter is applied.
  /// This value is then restored upon new session.
  WordListFilters _currentAppliedFilter = WordListFilters.all;

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;
  bool _showGrammarGraphs = false;
  bool _showGrammarSwitchOnStack = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    final filterText =
        getIt<PreferencesService>().readData(SharedKeys.filtersOnList) ??
            ListTableFields.lastUpdatedField;
    _currentAppliedFilter = KanListFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder =
        getIt<PreferencesService>().readData(SharedKeys.orderOnList) ?? true;

    _showGrammarGraphs =
        getIt<PreferencesService>().readData(SharedKeys.showGrammarGraphs) ??
            false;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      widget.onScrolledToBottom();
    }
    setState(() => _showGrammarSwitchOnStack = _scrollController.offset >= 64);
  }

  _addLoadingEvent({bool reset = false}) {
    if (widget.folder == null) {
      return getIt<ListBloc>()
        ..add(ListEventLoading(
            filter: _currentAppliedFilter,
            order: _currentAppliedOrder,
            reset: reset));
    }
    return getIt<FolderDetailsBloc>()
      ..add(FolderDetailsEventLoading(
          folder: widget.folder!,
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset));
  }

  _resetScroll() {
    /// Scroll to the top
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  _onFilterSelected(int index) {
    _resetScroll();
    widget.removeFocus();

    /// If the user taps on the same filter twice, just change back and forth the
    /// order value.
    /// Else, means the user has changed the filter, therefore default the order to DESC
    if (_currentAppliedFilter.index == index) {
      setState(() => _currentAppliedOrder = !_currentAppliedOrder);
    } else {
      setState(() => _currentAppliedOrder = true);
    }

    /// Change the current applied filter based on the index selected on the ChoiceChip
    /// and change the value on _filterValues map to reflect the change on the UI
    _currentAppliedFilter = WordListFilters.values[index];

    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent(reset: true);

    /// Stores the new filter and order applied to shared preferences
    if (widget.folder == null) {
      getIt<PreferencesService>()
          .saveData(SharedKeys.filtersOnList, _currentAppliedFilter.filter);
      getIt<PreferencesService>()
          .saveData(SharedKeys.orderOnList, _currentAppliedOrder);
    }
  }

  _toggleGraphs(bool value) {
    getIt<PreferencesService>().saveData(SharedKeys.showGrammarGraphs, value);
    setState(() => _showGrammarGraphs = value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _filterChips(),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _lists(),
              if (_showGrammarSwitchOnStack)
                ActionChip(
                  label: Text(_showGrammarGraphs
                      ? 'word_change_graphs'.tr()
                      : 'grammar_change_graphs'.tr()),
                  backgroundColor: KPColors.getSecondaryColor(context),
                  onPressed: () {
                    _toggleGraphs(!_showGrammarGraphs);
                  },
                )
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _filterChips() {
    Icon icon = Icon(
        _currentAppliedOrder
            ? Icons.arrow_downward_rounded
            : Icons.arrow_upward_rounded,
        color: KPColors.getAlterAccent(context));

    return SizedBox(
        height: KPSizes.defaultSizeFiltersList,
        child: ListView.builder(
            itemCount: WordListFilters.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin2),
                child: ChoiceChip(
                  label: Text(WordListFilters.values[index].label),
                  avatar: _currentAppliedFilter.index != index ? null : icon,
                  pressElevation: KPMargins.margin4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
                  onSelected: (bool selected) => _onFilterSelected(index),
                  selected: _currentAppliedFilter.index == index,
                ),
              );
            }));
  }

  ListTile _grammarSwitch() {
    return ListTile(
      title: Text(
        'grammar_change_graphs'.tr(),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: KPColors.accentLight),
      ),
      trailing: KPSwitch(
        onChanged: _toggleGraphs,
        value: _showGrammarGraphs,
      ),
      visualDensity: const VisualDensity(vertical: -4),
      onTap: () {
        _toggleGraphs(!_showGrammarGraphs);
      },
    );
  }

  BlocBuilder _lists() {
    if (widget.folder == null) {
      return BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state is ListStateFailure) {
            return KPEmptyList(
                showTryButton: true,
                onRefresh: () => _addLoadingEvent(reset: true),
                message: "kanji_lists_load_failed".tr());
          } else if (state is ListStateLoading || state is ListStateSearching) {
            return const KPProgressIndicator();
          } else if (state is ListStateLoaded) {
            return state.lists.isEmpty
                ? KPEmptyList(
                    onRefresh: () => _addLoadingEvent(reset: true),
                    showTryButton: true,
                    message: "kanji_lists_empty".tr())
                : _content(state.lists);
          } else {
            return Container();
          }
        },
      );
    }
    return BlocBuilder<FolderDetailsBloc, FolderDetailsState>(
      builder: (context, state) {
        if (state is FolderDetailsStateFailure) {
          return KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "kanji_lists_load_failed".tr());
        } else if (state is FolderDetailsEventLoading ||
            state is FolderDetailsStateSearching) {
          return const Expanded(child: KPProgressIndicator());
        } else if (state is FolderDetailsStateLoaded) {
          return state.lists.isEmpty
              ? Expanded(
                  child: KPEmptyList(
                      onRefresh: () => _addLoadingEvent(reset: true),
                      showTryButton: true,
                      message: "kanji_lists_empty".tr()))
              : _content(state.lists);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _content(List<WordList> lists) {
    return RefreshIndicator(
      onRefresh: () => _addLoadingEvent(reset: true),
      color: KPColors.secondaryColor,
      child: CustomScrollView(
        key: const PageStorageKey<String>('kanListListsController'),
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverToBoxAdapter(child: _grammarSwitch()),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, k) {
              return WordListTile(
                item: lists[k],
                onTap: widget.removeFocus,
                withinFolder: widget.withinFolder,
                showGrammarGraphs: _showGrammarGraphs,
                onRemoval: () {
                  if (widget.folder == null) {
                    getIt<ListBloc>().add(ListEventDelete(
                      lists[k],
                      filter: _currentAppliedFilter,
                      order: _currentAppliedOrder,
                    ));
                  } else {
                    getIt<FolderDetailsBloc>().add(
                      FolderDetailsEventDelete(
                        widget.folder!,
                        lists[k],
                        filter: _currentAppliedFilter,
                        order: _currentAppliedOrder,
                      ),
                    );
                  }
                  _resetScroll();
                },
              );
            }, childCount: lists.length),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: KPMargins.margin48),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
