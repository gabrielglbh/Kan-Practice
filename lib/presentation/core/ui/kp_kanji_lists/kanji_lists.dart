import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_details/folder_details_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanji_lists/widgets/kanji_list_tile.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
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

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    if (widget.folder == null) {
      final filterText =
          getIt<PreferencesService>().readData(SharedKeys.filtersOnList) ??
              ListTableFields.lastUpdatedField;
      _currentAppliedFilter = KanListFiltersUtils.getFilterFrom(filterText);

      _currentAppliedOrder =
          getIt<PreferencesService>().readData(SharedKeys.orderOnList) ?? true;
    }
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
  }

  _addLoadingEvent({bool reset = false}) {
    if (widget.folder == null) {
      return context.read<ListBloc>()
        ..add(ListEventLoading(
            filter: _currentAppliedFilter,
            order: _currentAppliedOrder,
            reset: reset));
    }
    return context.read<FolderDetailsBloc>()
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [_filterChips(), _lists()],
    );
  }

  SizedBox _filterChips() {
    Icon icon = Icon(
        _currentAppliedOrder
            ? Icons.arrow_downward_rounded
            : Icons.arrow_upward_rounded,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black);

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
            return const Expanded(child: KPProgressIndicator());
          } else if (state is ListStateLoaded) {
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
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => _addLoadingEvent(reset: true),
        color: KPColors.secondaryColor,
        child: ListView.builder(
          key: const PageStorageKey<String>('kanListListsController'),
          controller: _scrollController,
          itemCount: lists.length,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(bottom: KPMargins.margin24),
          itemBuilder: (context, k) {
            return WordListTile(
              item: lists[k],
              onTap: widget.removeFocus,
              withinFolder: widget.withinFolder,
              onRemoval: () {
                if (widget.folder == null) {
                  context.read<ListBloc>().add(ListEventDelete(
                        lists[k],
                        filter: _currentAppliedFilter,
                        order: _currentAppliedOrder,
                      ));
                } else {
                  context.read<FolderDetailsBloc>().add(
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
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
