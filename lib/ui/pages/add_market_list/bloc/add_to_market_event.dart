part of 'add_to_market_bloc.dart';

abstract class AddToMarketEvent extends Equatable {
  const AddToMarketEvent();

  @override
  List<Object> get props => [];
}

class AddToMarketEventIdle extends AddToMarketEvent {}

class AddToMarketEventOnUpload extends AddToMarketEvent {
  final String listName;
  final String description;

  const AddToMarketEventOnUpload(this.listName, this.description);

  @override
  List<Object> get props => [listName, description];
}
