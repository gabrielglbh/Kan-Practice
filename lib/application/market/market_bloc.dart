import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/market_filters.dart';
import 'package:kanpractice/domain/market/i_market_repository.dart';
import 'package:kanpractice/domain/market/market.dart';

part 'market_event.dart';
part 'market_state.dart';

part 'market_bloc.freezed.dart';

@lazySingleton
class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final IMarketRepository _marketRepository;

  MarketBloc(this._marketRepository) : super(const MarketState.initial()) {
    /// Maintain the list for pagination purposes
    List<Market> list = [];

    /// Maintain the list for pagination purposes on search
    List<Market> searchList = [];

    /// Maintain the offset of the documents from Firebase
    String lastRetrievedDocumentId = "";

    /// Maintain the offset of the documents from Firebase when searching
    String lastRetrievedDocumentIdWhenSearching = "";

    /// Reset lists for proper pagination and retrieves new list
    Future<List<Market>> resetCache(MarketFilters filter, bool order) async {
      list.clear();
      searchList.clear();
      lastRetrievedDocumentId = "";
      lastRetrievedDocumentIdWhenSearching = "";

      List<Market> fullList = List.of(list);

      final List<Market> pagination = await _marketRepository.getMarket(
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
          emit(const MarketState.loading());
          list.clear();
          lastRetrievedDocumentId = "";
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Market> fullList = List.of(list);
        final List<Market> pagination = await _marketRepository.getMarket(
            filter: event.filter,
            descending: event.order,
            offsetDocumentId: lastRetrievedDocumentId,
            onLastQueriedDocument: (id) => lastRetrievedDocumentId = id,
            filterByMine: event.filter == MarketFilters.mine);
        fullList.addAll(pagination);
        list.addAll(pagination);
        emit(MarketState.loaded(fullList));
      } catch (err) {
        emit(MarketState.error(err.toString()));
      }
    });

    on<MarketEventSearching>((event, emit) async {
      try {
        lastRetrievedDocumentId = "";
        if (event.reset) {
          emit(const MarketState.loading());
          searchList.clear();
          lastRetrievedDocumentIdWhenSearching = "";
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Market> fullList = List.of(searchList);
        final List<Market> pagination = await _marketRepository.getMarket(
            query: event.query,
            filter: event.filter,
            descending: event.order,
            offsetDocumentId: lastRetrievedDocumentIdWhenSearching,
            onLastQueriedDocument: (id) =>
                lastRetrievedDocumentIdWhenSearching = id,
            filterByMine: event.filter == MarketFilters.mine);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        emit(MarketState.loaded(fullList));
      } catch (err) {
        emit(MarketState.error(err.toString()));
      }
    });

    on<MarketEventDownload>((event, emit) async {
      emit(const MarketState.loading());
      String res = "";
      if (!event.isFolder) {
        res = await _marketRepository.downloadListFromMarketPlace(event.id);
      } else {
        res = await _marketRepository.downloadFolderFromMarketPlace(event.id);
      }

      if (res.isEmpty) {
        emit(MarketState.succeeded("market_downloaded_successfully".tr()));
      } else {
        emit(MarketState.error(res));
      }
      final fullList = await resetCache(event.filter, event.order);
      emit(MarketState.loaded(fullList));
    });

    on<MarketEventRemove>((event, emit) async {
      emit(const MarketState.loading());
      String res = "";
      if (!event.isFolder) {
        res = await _marketRepository.removeListFromMarketPlace(event.id);
      } else {
        res = await _marketRepository.removeFolderFromMarketPlace(event.id);
      }

      if (res.isEmpty) {
        emit(MarketState.succeeded("market_removed_successfully".tr()));
      } else {
        emit(MarketState.error(res));
      }
      final fullList = await resetCache(event.filter, event.order);
      emit(MarketState.loaded(fullList));
    });
  }
}
