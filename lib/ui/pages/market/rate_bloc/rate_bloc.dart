import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/queries/market.dart';

part 'rate_event.dart';
part 'rate_state.dart';

class RateBloc extends Bloc<RateEvent, RateState> {
  RateBloc() : super(RateInitial()) {
    on<RateEventIdle>((event, emit) {});

    on<RateEventUpdate>((event, emit) async {
      emit(RateStateLoading());
      final res = await MarketRecords.instance.rateList(event.id, event.rate);
      if (res.isNotEmpty) {
        emit(RateStateFailure(res));
      } else {
        emit(RateStateSuccess(event.rate));
      }
    });
  }
}
