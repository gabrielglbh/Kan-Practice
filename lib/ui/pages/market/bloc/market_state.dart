part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();
}

class MarketInitial extends MarketState {
  @override
  List<Object> get props => [];
}
