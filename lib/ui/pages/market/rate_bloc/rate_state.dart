part of 'rate_bloc.dart';

abstract class RateState extends Equatable {
  const RateState();

  @override
  List<Object> get props => [];
}

class RateInitial extends RateState {}

class RateStateLoading extends RateState {}

class RateStateSuccess extends RateState {
  final double rating;

  const RateStateSuccess(this.rating);

  @override
  List<Object> get props => [rating];
}

class RateStateFailure extends RateState {
  final String message;

  const RateStateFailure(this.message);

  @override
  List<Object> get props => [message];
}
