part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class MarketStateIdle extends MarketState {}

class MarketStateLoading extends MarketState {}

class MarketStateSearching extends MarketState {}

class MarketStateLoaded extends MarketState {
  final List<Market> lists;

  const MarketStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class MarketStateSuccess extends MarketState {
  final String message;

  const MarketStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MarketStateFailure extends MarketState {
  final String message;

  const MarketStateFailure(this.message);

  @override
  List<Object> get props => [message];
}
