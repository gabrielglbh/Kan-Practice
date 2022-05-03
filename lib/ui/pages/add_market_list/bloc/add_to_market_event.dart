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
  final String author;
  final String listNameForMarket;

  const AddToMarketEventOnUpload(this.listName, this.description, this.author, this.listNameForMarket);

  @override
  List<Object> get props => [listName, description, author, listNameForMarket];
}
