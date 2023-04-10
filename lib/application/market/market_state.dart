part of 'market_bloc.dart';

@freezed
class MarketState with _$MarketState {
  const factory MarketState.initial() = MarketInitial;
  const factory MarketState.loading() = MarketLoading;
  const factory MarketState.loaded(List<Market> lists) = MarketLoaded;
  const factory MarketState.succeeded(String message) = MarketSucceeded;
  const factory MarketState.error(String message) = MarketError;
}
