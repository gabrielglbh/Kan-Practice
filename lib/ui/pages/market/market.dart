import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/market/bloc/market_bloc.dart';
import 'package:kanpractice/ui/pages/market/widgets/market_list_tile.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';

class MarketPlace extends StatefulWidget {
  final Function() onScrolledToBottom;
  const MarketPlace({Key? key, required this.onScrolledToBottom}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final ScrollController _scrollController = ScrollController();

  MarketFilters _currentAppliedFilter = MarketFilters.all;

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    final filterText = StorageManager.readData(StorageManager.filtersOnMarket)
        ?? MarketList.uploadedToMarketField;
    _currentAppliedFilter = MarketFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder = StorageManager.readData(StorageManager.orderOnMarket) ?? true;
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
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      widget.onScrolledToBottom();
    }
  }

  _resetScroll() {
    /// Scroll to the top
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  _addLoadingEvent({bool reset = false}) {
    return BlocProvider.of<MarketBloc>(context)..add(MarketEventLoading(filter: _currentAppliedFilter,
        order: _currentAppliedOrder, reset: reset));
  }

  _onFilterSelected(int index) {
    /// If the filter is exactly the same "MINE", do not update the list
    if (MarketFilters.mine == MarketFilters.values[index] && _currentAppliedFilter == MarketFilters.mine) {
      return;
    }

    _resetScroll();
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
    _currentAppliedFilter = MarketFilters.values[index];

    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent(reset: true);
    /// Stores the new filter and order applied to shared preferences
    StorageManager.saveData(StorageManager.filtersOnMarket, _currentAppliedFilter.filter);
    StorageManager.saveData(StorageManager.orderOnMarket, _currentAppliedOrder);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarketBloc, MarketState>(
      listener: (context, state) {
        if (state is MarketStateSuccess) {
          GeneralUtils.getSnackBar(context, state.message);
        } else if (state is MarketStateFailure) {
          GeneralUtils.getSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is MarketStateLoading || state is MarketStateSearching) {
          return const KPProgressIndicator();
        } else {
          return Column(
            children: [
              _filterChips(state),
              _lists(state)
            ],
          );
        }
      }
    );
  }

  SizedBox _filterChips(MarketState state) {
    Icon icon = Icon(_currentAppliedOrder
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded,
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black);

    return SizedBox(
      height: CustomSizes.defaultSizeFiltersList,
      child: ListView.builder(
        itemCount: MarketFilters.values.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin2),
            child: ChoiceChip(
              label: Text(MarketFilters.values[index].label),
              avatar: _currentAppliedFilter == MarketFilters.mine
                  ? null : _currentAppliedFilter.index != index ? null : icon,
              pressElevation: Margins.margin4,
              padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
              onSelected: (bool selected) => _onFilterSelected(index),
              selected: _currentAppliedFilter.index == index,
            ),
          );
        }
      )
    );
  }

  Widget _lists(MarketState state) {
    if (state is MarketStateFailure) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "market_load_failed".tr()
      );
    } else if (state is MarketStateLoaded) {
      return state.lists.isEmpty
          ? Expanded(child:
      KPEmptyList(
          onRefresh: () => _addLoadingEvent(reset: true),
          showTryButton: true,
          message: "market_empty".tr())
      )
          : Expanded(
        child: RefreshIndicator(
          onRefresh: () => _addLoadingEvent(reset: true),
          child: ListView.builder(
              key: const PageStorageKey<String>('marketListsController'),
              controller: _scrollController,
              itemCount: state.lists.length,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(bottom: Margins.margin24),
              itemBuilder: (context, k) {
                return MarketListTile(
                  list: state.lists[k],
                  isManaging: _currentAppliedFilter == MarketFilters.mine,
                  onDownload: (listId) {
                    BlocProvider.of<MarketBloc>(context).add(
                        MarketEventDownload(listId, _currentAppliedFilter, _currentAppliedOrder)
                    );
                  },
                  onRemove: (listId) {
                    BlocProvider.of<MarketBloc>(context).add(
                        MarketEventRemove(listId, _currentAppliedFilter, _currentAppliedOrder)
                    );
                  },
                );
              }
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
