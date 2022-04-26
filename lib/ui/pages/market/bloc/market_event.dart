part of 'market_bloc.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();
}

class MarketEventLoading extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;
  /// Maintains the order applied by the user for loading new lists
  final bool order;
  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const MarketEventLoading({required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class MarketEventSearching extends MarketEvent {
  final String query;
  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const MarketEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}
