import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/market/market_bloc.dart';
import 'package:kanpractice/presentation/core/types/market_filters.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/market_page/widgets/market_list_tile.dart';

class MarketPage extends StatefulWidget {
  final Function() onScrolledToBottom;
  final Function() removeFocus;
  const MarketPage(
      {Key? key, required this.removeFocus, required this.onScrolledToBottom})
      : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  MarketFilters _currentAppliedFilter = MarketFilters.all;

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    final filterText =
        getIt<PreferencesService>().readData(SharedKeys.filtersOnMarket) ??
            Market.uploadedToMarketField;
    _currentAppliedFilter = MarketFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder =
        getIt<PreferencesService>().readData(SharedKeys.orderOnMarket) ?? true;
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

  _resetScroll() {
    /// Scroll to the top
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  _addLoadingEvent({bool reset = false}) {
    return getIt<MarketBloc>()
      ..add(MarketEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset));
  }

  _onFilterSelected(int index) {
    /// If the filter is exactly the same "MINE", do not update the list
    if (MarketFilters.mine == MarketFilters.values[index] &&
        _currentAppliedFilter == MarketFilters.mine) {
      return;
    }

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
    _currentAppliedFilter = MarketFilters.values[index];

    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent(reset: true);

    /// Stores the new filter and order applied to shared preferences
    getIt<PreferencesService>()
        .saveData(SharedKeys.filtersOnMarket, _currentAppliedFilter.filter);
    getIt<PreferencesService>()
        .saveData(SharedKeys.orderOnMarket, _currentAppliedOrder);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _filterChips(),
        BlocConsumer<MarketBloc, MarketState>(listener: (context, state) {
          if (state is MarketStateSuccess) {
            Utils.getSnackBar(context, state.message);
          } else if (state is MarketStateFailure) {
            Utils.getSnackBar(context, state.message);
          }
        }, builder: (context, state) {
          if (state is MarketStateLoading || state is MarketStateSearching) {
            return Column(
              children: [
                const KPProgressIndicator(),
                const SizedBox(height: KPMargins.margin16),
                Text('can_take_a_while_loading'.tr()),
              ],
            );
          } else {
            return _lists(state);
          }
        }),
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
            itemCount: MarketFilters.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin2),
                child: ChoiceChip(
                  label: Text(MarketFilters.values[index].label),
                  avatar: _currentAppliedFilter == MarketFilters.mine
                      ? null
                      : _currentAppliedFilter.index != index
                          ? null
                          : icon,
                  pressElevation: KPMargins.margin4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
                  onSelected: (bool selected) => _onFilterSelected(index),
                  selected: _currentAppliedFilter.index == index,
                ),
              );
            }));
  }

  Widget _lists(MarketState state) {
    if (state is MarketStateFailure) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "market_load_failed".tr());
    } else if (state is MarketStateLoaded) {
      return state.lists.isEmpty
          ? Expanded(
              child: KPEmptyList(
                  onRefresh: () => _addLoadingEvent(reset: true),
                  showTryButton: true,
                  message: "market_empty".tr()))
          : Expanded(
              child: RefreshIndicator(
                onRefresh: () async => _addLoadingEvent(reset: true),
                color: KPColors.secondaryColor,
                child: ListView.builder(
                    key: const PageStorageKey<String>('marketListsController'),
                    controller: _scrollController,
                    itemCount: state.lists.length,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.only(bottom: KPMargins.margin24),
                    itemBuilder: (context, k) {
                      return MarketListTile(
                        list: state.lists[k],
                        isManaging: _currentAppliedFilter == MarketFilters.mine,
                        onDownload: (listId, isFolder) {
                          getIt<MarketBloc>().add(MarketEventDownload(
                            listId,
                            isFolder,
                            _currentAppliedFilter,
                            _currentAppliedOrder,
                          ));
                        },
                        onRemove: (listId, isFolder) {
                          getIt<MarketBloc>().add(MarketEventRemove(
                            listId,
                            isFolder,
                            _currentAppliedFilter,
                            _currentAppliedOrder,
                          ));
                        },
                      );
                    }),
              ),
            );
    } else {
      return Container();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
