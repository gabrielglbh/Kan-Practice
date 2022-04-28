import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/firebase/queries/market.dart';

part 'add_to_market_event.dart';
part 'add_to_market_state.dart';

class AddToMarketBloc extends Bloc<AddToMarketEvent, AddToMarketState> {
  AddToMarketBloc() : super(AddToMarketStateInitial()) {
    on<AddToMarketEventIdle>((event, emit) {});

    on<AddToMarketEventOnUpload>((event, emit) async {
      emit(AddToMarketStateLoading());
      if (event.listName == "add_to_market_select_list".tr() || event.description.trim().isEmpty) {
        emit(AddToMarketStateFailure("add_to_market_validation_failed".tr()));
      } else {
        final list = await ListQueries.instance.getList(event.listName);
        final kanji = await KanjiQueries.instance.getAllKanjiFromList(event.listName);
        if (kanji.isEmpty) {
          emit(AddToMarketStateFailure("add_to_market_kanji_empty".tr()));
        } else {
          final res = await MarketRecords.instance.uploadToMarketPlace(list, kanji, event.description);
          if (res == 0) {
            emit(AddToMarketStateSuccess());
          } else if (res == -2) {
            emit(AddToMarketStateFailure("add_to_market_authentication_failed".tr()));
          } else if (res == -3) {
            emit(AddToMarketStateFailure("add_to_market_already_uploaded".tr()));
          } else {
            emit(AddToMarketStateFailure("add_to_market_something_wrong".tr()));
          }
        }
      }
    });
  }
}
