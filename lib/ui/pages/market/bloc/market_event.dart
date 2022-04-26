part of 'market_bloc.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();
}

class MarketEventLoading extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;
  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const MarketEventLoading({required this.filter, required this.order});

  @override
  List<Object> get props => [filter, order];
}

class MarketEventSearching extends MarketEvent {
  final String query;

  const MarketEventSearching(this.query);

  @override
  List<Object> get props => [query];
}
