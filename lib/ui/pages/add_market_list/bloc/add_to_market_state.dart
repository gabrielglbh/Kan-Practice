part of 'add_to_market_bloc.dart';

abstract class AddToMarketState extends Equatable {
  const AddToMarketState();

  @override
  List<Object> get props => [];
}

class AddToMarketStateInitial extends AddToMarketState {}

class AddToMarketStateFailure extends AddToMarketState {
  final String message;

  const AddToMarketStateFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AddToMarketStateLoading extends AddToMarketState {}

class AddToMarketStateSuccess extends AddToMarketState {}
