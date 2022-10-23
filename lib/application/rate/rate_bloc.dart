import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/infrastructure/market/market_repository_impl.dart';
import 'package:kanpractice/injection.dart';

part 'rate_event.dart';
part 'rate_state.dart';

@lazySingleton
class RateBloc extends Bloc<RateEvent, RateState> {
  RateBloc() : super(RateInitial()) {
    on<RateEventIdle>((event, emit) {});

    on<RateEventUpdate>((event, emit) async {
      emit(RateStateLoading());
      final res =
          await getIt<MarketRepositoryImpl>().rateList(event.id, event.rate);
      if (res.isNotEmpty) {
        emit(RateStateFailure(res));
      } else {
        emit(RateStateSuccess(event.rate));
      }
    });
  }
}
