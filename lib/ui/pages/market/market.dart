import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/market/bloc/market_bloc.dart';
import 'package:kanpractice/ui/pages/market/widgets/market_list_tile.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_search_bar.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final MarketBloc _bloc = MarketBloc();
  final ScrollController _scrollController = ScrollController();
  FocusNode? _searchBarFn;

  MarketFilters _currentAppliedFilter = MarketFilters.all;

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;
  bool _searchHasFocus = false;

  /// Saves the last state of the query
  String _query = "";

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _searchBarFn?.addListener(_focusListener);
    _scrollController.addListener(_scrollListener);

    final filterText = StorageManager.readData(StorageManager.filtersOnMarket)
        ?? MarketList.uploadedToMarketField;
    _currentAppliedFilter = MarketFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder = StorageManager.readData(StorageManager.orderOnMarket) ?? true;
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn?.removeListener(_focusListener);
    _searchBarFn?.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _focusListener() => setState(() => _searchHasFocus = (_searchBarFn?.hasFocus ?? false));

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
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

  _addLoadingEvent({bool reset = false}) {
    return _bloc..add(MarketEventLoading(filter: _currentAppliedFilter,
        order: _currentAppliedOrder, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return _bloc..add(MarketEventSearching(query, filter: _currentAppliedFilter,
        order: _currentAppliedOrder, reset: reset));
  }

  _onFilterSelected(int index) {
    /// If the filter is exactly the same "MINE", do not update the list
    if (MarketFilters.mine == MarketFilters.values[index] && _currentAppliedFilter == MarketFilters.mine) {
      return;
    }
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
    return KPScaffold(
      onWillPop: () async {
        if (_searchHasFocus) {
          _addLoadingEvent(reset: true);
          _searchBarFn?.unfocus();
          return false;
        } else {
          return true;
        }
      },
      appBarTitle: "market_place_title".tr(),
      appBarActions: [
        IconButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(KanPracticePages.marketAddListPage);
          },
          icon: const Icon(Icons.add)
        )
      ],
      child: BlocProvider<MarketBloc>(
        create: (_) => _addLoadingEvent(),
        child: BlocListener<MarketBloc, MarketState>(
          listener: (context, state) {
            if (state is MarketStateDownloadSuccess) {
              GeneralUtils.getSnackBar(context, state.message);
            } else if (state is MarketStateDownloadFailure) {
              GeneralUtils.getSnackBar(context, state.message);
            }
          },
          child: BlocBuilder<MarketBloc, MarketState>(
            builder: (context, state) {
              if (state is MarketStateLoading || state is MarketStateSearching) {
                return const KPProgressIndicator();
              } else {
                return Column(
                  children: [
                    KPSearchBar(
                      hint: "market_lists_searchBar_hint".tr(),
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
                    _filterChips(state),
                    _lists(state)
                  ],
                );
              }
            }
          ),
        )
      )
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
              padding: const EdgeInsets.only(bottom: Margins.margin16),
              itemBuilder: (context, k) {
                return MarketListTile(
                  list: state.lists[k],
                  isManaging: _currentAppliedFilter == MarketFilters.mine,
                  onDownload: (listId) {
                    _bloc.add(MarketEventDownload(listId, _currentAppliedFilter, _currentAppliedOrder));
                  },
                  onRemove: (listId) {
                    _bloc.add(MarketEventRemove(listId, _currentAppliedFilter, _currentAppliedOrder));
                  },
                  onRating: () {

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
