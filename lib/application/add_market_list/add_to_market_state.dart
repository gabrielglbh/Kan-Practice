part of 'add_to_market_bloc.dart';

@freezed
class AddToMarketState with _$AddToMarketState {
  const factory AddToMarketState.loading() = AddToMarketLoading;
  const factory AddToMarketState.loaded() = AddToMarketLoaded;
  const factory AddToMarketState.initial() = AddToMarketInitial;
  const factory AddToMarketState.userRetrieved(String name) =
      AddToMarketUserRetrieved;
  const factory AddToMarketState.error(String message) = AddToMarketError;
}
