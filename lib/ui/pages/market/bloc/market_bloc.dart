import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/firebase/queries/market.dart';
import 'package:kanpractice/core/types/market_filters.dart';

part 'market_event.dart';
part 'market_state.dart';

/// Used on market.dart and manage_market_list.dart.
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc() : super(MarketStateLoading()) {
    /// Maintain the list for pagination purposes
    List<MarketList> _list = [];
    /// Maintain the list for pagination purposes on search
    List<MarketList> _searchList = [];

    /// Maintain the offset of the documents from Firebase
    String _lastRetrievedDocumentId = "";
    /// Maintain the offset of the documents from Firebase when searching
    String _lastRetrievedDocumentIdWhenSearching = "";

    on<MarketEventLoading>((event, emit) async {
      try {
        _lastRetrievedDocumentIdWhenSearching = "";
        if (event.reset) {
          emit(MarketStateLoading());
          _list.clear();
          _lastRetrievedDocumentId = "";
        }
        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to _list the elements for the next iteration.
        List<MarketList> fullList = List.of(_list);
        final List<MarketList> pagination = await MarketRecords.instance.getLists(
          filter: event.filter,
          descending: event.order,
          offsetDocumentId: _lastRetrievedDocumentId,
          onLastQueriedDocument: (id) => _lastRetrievedDocumentId = id,
          filterByMine: event.filter == MarketFilters.mine
        );
        fullList.addAll(pagination);
        _list.addAll(pagination);
        emit(MarketStateLoaded(lists: fullList));
      } on Exception {
        emit(MarketStateFailure());
      }
    });

    on<MarketEventSearching>((event, emit) async {
      try {
        _lastRetrievedDocumentId = "";
        if (event.reset) {
          emit(MarketStateLoading());
          _searchList.clear();
          _lastRetrievedDocumentIdWhenSearching = "";
        }
        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to _list the elements for the next iteration.
        List<MarketList> fullList = List.of(_searchList);
        final List<MarketList> pagination = await MarketRecords.instance.getListsBasedOnQuery(
            event.query,
            filter: event.filter,
            descending: event.order,
            offsetDocumentId: _lastRetrievedDocumentIdWhenSearching,
            onLastQueriedDocument: (id) => _lastRetrievedDocumentIdWhenSearching = id,
            filterByMine: event.filter == MarketFilters.mine
        );
        fullList.addAll(pagination);
        _searchList.addAll(pagination);
        emit(MarketStateLoaded(lists: fullList));
      } on Exception {
        emit(MarketStateFailure());
      }
    });

    on<MarketEventDownload>((event, emit) async {
      emit(MarketStateLoading());
      final res = await MarketRecords.instance.downloadFromMarketPlace(event.id);
      if (res.isEmpty) {
        emit(MarketStateDownloadSuccess("market_downloaded_successfully".tr()));
      } else {
        emit(MarketStateDownloadFailure(res));
      }
      /// Reset lists for proper pagination
      _list.clear();
      _searchList.clear();
      _lastRetrievedDocumentId = "";
      _lastRetrievedDocumentIdWhenSearching = "";
      /// For every time we want to retrieve data, we need to instantiate
      /// a new list in order for Equatable to trigger and perform a change
      /// of state. After, add to _list the elements for the next iteration.
      List<MarketList> fullList = List.of(_list);
      final List<MarketList> pagination = await MarketRecords.instance.getLists(
          filter: event.filter,
          descending: event.order,
          offsetDocumentId: _lastRetrievedDocumentId,
          onLastQueriedDocument: (id) => _lastRetrievedDocumentId = id,
          filterByMine: event.filter == MarketFilters.mine
      );
      fullList.addAll(pagination);
      _list.addAll(pagination);
      emit(MarketStateLoaded(lists: fullList));
    });

    on<MarketEventRemove>((event, emit) async {
      emit(MarketStateLoading());
      final res = await MarketRecords.instance.removeFromMarketPlace(event.id);
      if (res.isEmpty) {
        emit(MarketStateDownloadSuccess("market_removed_successfully".tr()));
      } else {
        emit(MarketStateDownloadFailure(res));
      }
      /// Reset lists for proper pagination
      _list.clear();
      _searchList.clear();
      _lastRetrievedDocumentId = "";
      _lastRetrievedDocumentIdWhenSearching = "";
      /// For every time we want to retrieve data, we need to instantiate
      /// a new list in order for Equatable to trigger and perform a change
      /// of state. After, add to _list the elements for the next iteration.
      List<MarketList> fullList = List.of(_list);
      final List<MarketList> pagination = await MarketRecords.instance.getLists(
          filter: event.filter,
          descending: event.order,
          offsetDocumentId: _lastRetrievedDocumentId,
          onLastQueriedDocument: (id) => _lastRetrievedDocumentId = id,
          filterByMine: event.filter == MarketFilters.mine
      );
      fullList.addAll(pagination);
      _list.addAll(pagination);
      emit(MarketStateLoaded(lists: fullList));
    });
  }
}
