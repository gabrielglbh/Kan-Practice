part of 'add_to_market_bloc.dart';

abstract class AddToMarketEvent extends Equatable {
  const AddToMarketEvent();

  @override
  List<Object> get props => [];
}

class AddToMarketEventIdle extends AddToMarketEvent {}

class AddToMarketEventOnUpload extends AddToMarketEvent {
  final MarketListType type;
  final String name;
  final String language;
  final String description;
  final String author;
  final String listNameForMarket;

  const AddToMarketEventOnUpload(
    this.type,
    this.name,
    this.description,
    this.author,
    this.listNameForMarket,
    this.language,
  );

  @override
  List<Object> get props => [
        type,
        name,
        description,
        author,
        listNameForMarket,
        language,
      ];
}
