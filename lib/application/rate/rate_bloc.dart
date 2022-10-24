import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/market/i_market_repository.dart';

part 'rate_event.dart';
part 'rate_state.dart';

@lazySingleton
class RateBloc extends Bloc<RateEvent, RateState> {
  final IMarketRepository _marketRepository;

  RateBloc(this._marketRepository) : super(RateStateIdle()) {
    on<RateEventUpdate>((event, emit) async {
      emit(RateStateLoading());
      final res = await _marketRepository.rateList(event.id, event.rate);
      if (res.isNotEmpty) {
        emit(RateStateFailure(res));
      } else {
        emit(RateStateSuccess(event.rate));
      }
    });
  }
}
