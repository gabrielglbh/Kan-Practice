import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/market/i_market_repository.dart';

part 'rate_event.dart';
part 'rate_state.dart';

part 'rate_bloc.freezed.dart';

@injectable
class RateBloc extends Bloc<RateEvent, RateState> {
  final IMarketRepository _marketRepository;

  RateBloc(this._marketRepository) : super(const RateState.initial()) {
    on<RateEventUpdate>((event, emit) async {
      emit(const RateState.loading());
      final res = await _marketRepository.rateList(event.id, event.rate);
      if (res.isNotEmpty) {
        emit(RateState.error(res));
      } else {
        emit(RateState.succeeded(event.rate));
      }
    });
  }
}
