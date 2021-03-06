import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/kanlist_tile.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class KanjiLists extends StatefulWidget {
  final Function() removeFocus;
  final Function() onScrolledToBottom;
  const KanjiLists(
      {Key? key, required this.removeFocus, required this.onScrolledToBottom})
      : super(key: key);

  @override
  _KanjiListsState createState() => _KanjiListsState();
}

class _KanjiListsState extends State<KanjiLists>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  /// This variable keeps track of the actual filter applied. The value is
  /// saved into the shared preferences when a filter is applied.
  /// This value is then restored upon new session.
  KanListFilters _currentAppliedFilter = KanListFilters.all;

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    final filterText = StorageManager.readData(StorageManager.filtersOnList) ??
        KanListTableFields.lastUpdatedField;
    _currentAppliedFilter = KanListFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder =
        StorageManager.readData(StorageManager.orderOnList) ?? true;
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
    return BlocProvider.of<KanjiListBloc>(context)
      ..add(KanjiListEventLoading(
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
    _currentAppliedFilter = KanListFilters.values[index];

    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent(reset: true);

    /// Stores the new filter and order applied to shared preferences
    StorageManager.saveData(
        StorageManager.filtersOnList, _currentAppliedFilter.filter);
    StorageManager.saveData(StorageManager.orderOnList, _currentAppliedOrder);
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
        height: CustomSizes.defaultSizeFiltersList,
        child: ListView.builder(
            itemCount: KanListFilters.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Margins.margin2),
                child: ChoiceChip(
                  label: Text(KanListFilters.values[index].label),
                  avatar: _currentAppliedFilter.index != index ? null : icon,
                  pressElevation: Margins.margin4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: Margins.margin8),
                  onSelected: (bool selected) => _onFilterSelected(index),
                  selected: _currentAppliedFilter.index == index,
                ),
              );
            }));
  }

  BlocBuilder _lists() {
    return BlocBuilder<KanjiListBloc, KanjiListState>(
      builder: (context, state) {
        if (state is KanjiListStateFailure) {
          return KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "kanji_lists_load_failed".tr());
        } else if (state is KanjiListStateLoading ||
            state is KanjiListStateSearching) {
          return const Expanded(child: KPProgressIndicator());
        } else if (state is KanjiListStateLoaded) {
          return state.lists.isEmpty
              ? Expanded(
                  child: KPEmptyList(
                      onRefresh: () => _addLoadingEvent(reset: true),
                      showTryButton: true,
                      message: "kanji_lists_empty".tr()))
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _addLoadingEvent(reset: true),
                    color: CustomColors.secondaryColor,
                    child: ListView.builder(
                        key: const PageStorageKey<String>(
                            'kanListListsController'),
                        controller: _scrollController,
                        itemCount: state.lists.length,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding:
                            const EdgeInsets.only(bottom: Margins.margin24),
                        itemBuilder: (context, k) {
                          return KanListTile(
                            item: state.lists[k],
                            onTap: widget.removeFocus,
                            mode: VisualizationModeExt.mode(
                                StorageManager.readData(StorageManager
                                        .kanListGraphVisualization) ??
                                    VisualizationMode.radialChart),
                            onRemoval: () {
                              BlocProvider.of<KanjiListBloc>(context)
                                  .add(KanjiListEventDelete(
                                state.lists[k],
                                filter: _currentAppliedFilter,
                                order: _currentAppliedOrder,
                              ));
                              _resetScroll();
                            },
                          );
                        }),
                  ),
                );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
