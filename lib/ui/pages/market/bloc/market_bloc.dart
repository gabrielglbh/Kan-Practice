import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/firebase/queries/market.dart';
import 'package:kanpractice/core/types/market_filters.dart';

part 'market_event.dart';
part 'market_state.dart';

/// Used on market.dart and manage_marketlist.dart.
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc() : super(MarketStateLoading()) {
    /// Maintain the list for pagination purposes
    List<MarketList> list = [];

    /// Maintain the list for pagination purposes on search
    List<MarketList> searchList = [];

    /// Maintain the offset of the documents from Firebase
    String lastRetrievedDocumentId = "";

    /// Maintain the offset of the documents from Firebase when searching
    String lastRetrievedDocumentIdWhenSearching = "";

    /// Reset lists for proper pagination and retrieves new list
    Future<List<MarketList>> _resetCache(
        MarketFilters filter, bool order) async {
      list.clear();
      searchList.clear();
      lastRetrievedDocumentId = "";
      lastRetrievedDocumentIdWhenSearching = "";

      List<MarketList> fullList = List.of(list);

      final List<MarketList> pagination = await MarketRecords.instance.getLists(
          filter: filter,
          descending: order,
          offsetDocumentId: lastRetrievedDocumentId,
          onLastQueriedDocument: (id) => lastRetrievedDocumentId = id,
          filterByMine: filter == MarketFilters.mine);
      fullList.addAll(pagination);
      list.addAll(pagination);
      return fullList;
    }

    on<MarketEventIdle>((event, emit) {});

    on<MarketEventLoading>((event, emit) async {
      try {
        lastRetrievedDocumentIdWhenSearching = "";
        if (event.reset) {
          emit(MarketStateLoading());
          list.clear();
          lastRetrievedDocumentId = "";
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<MarketList> fullList = List.of(list);
        final List<MarketList> pagination = await MarketRecords.instance
            .getLists(
                filter: event.filter,
                descending: event.order,
                offsetDocumentId: lastRetrievedDocumentId,
                onLastQueriedDocument: (id) => lastRetrievedDocumentId = id,
                filterByMine: event.filter == MarketFilters.mine);
        fullList.addAll(pagination);
        list.addAll(pagination);
        emit(MarketStateLoaded(lists: fullList));
      } catch (err) {
        emit(MarketStateFailure(err.toString()));
      }
    });

    on<MarketEventSearching>((event, emit) async {
      try {
        lastRetrievedDocumentId = "";
        if (event.reset) {
          emit(MarketStateLoading());
          searchList.clear();
          lastRetrievedDocumentIdWhenSearching = "";
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<MarketList> fullList = List.of(searchList);
        final List<MarketList> pagination = await MarketRecords.instance
            .getLists(
                query: event.query,
                filter: event.filter,
                descending: event.order,
                offsetDocumentId: lastRetrievedDocumentIdWhenSearching,
                onLastQueriedDocument: (id) =>
                    lastRetrievedDocumentIdWhenSearching = id,
                filterByMine: event.filter == MarketFilters.mine);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        emit(MarketStateLoaded(lists: fullList));
      } catch (err) {
        emit(MarketStateFailure(err.toString()));
      }
    });

    on<MarketEventDownload>((event, emit) async {
      emit(MarketStateLoading());
      final res =
          await MarketRecords.instance.downloadFromMarketPlace(event.id);
      if (res.isEmpty) {
        emit(MarketStateSuccess("market_downloaded_successfully".tr()));
      } else {
        emit(MarketStateFailure(res));
      }
      final fullList = await _resetCache(event.filter, event.order);
      emit(MarketStateLoaded(lists: fullList));
    });

    on<MarketEventRemove>((event, emit) async {
      emit(MarketStateLoading());
      final res = await MarketRecords.instance.removeFromMarketPlace(event.id);
      if (res.isEmpty) {
        emit(MarketStateSuccess("market_removed_successfully".tr()));
      } else {
        emit(MarketStateFailure(res));
      }
      final fullList = await _resetCache(event.filter, event.order);
      emit(MarketStateLoaded(lists: fullList));
    });
  }
}
