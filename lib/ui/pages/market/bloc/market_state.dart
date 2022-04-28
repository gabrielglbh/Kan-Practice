part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class MarketStateLoading extends MarketState {}

class MarketStateSearching extends MarketState {}

class MarketStateLoaded extends MarketState {
  final List<MarketList> lists;

  const MarketStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class MarketStateDownloadSuccess extends MarketState {
  final String message;

  const MarketStateDownloadSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MarketStateDownloadFailure extends MarketState {
  final String message;

  const MarketStateDownloadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class MarketStateFailure extends MarketState {}