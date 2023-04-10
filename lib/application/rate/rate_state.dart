part of 'rate_bloc.dart';

@freezed
class RateState with _$RateState {
  const factory RateState.initial() = RateInitial;
  const factory RateState.loading() = RateLoading;
  const factory RateState.succeeded(double rating) = RateSucceeded;
  const factory RateState.error(String message) = RateError;
}
