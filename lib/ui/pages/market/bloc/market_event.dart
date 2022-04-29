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
  final MarketFilters filter;
  final bool order;
  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const MarketEventSearching(this.query, {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class MarketEventDownload extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;
  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool order;
  final String id;

  const MarketEventDownload(this.id, this.filter, this.order);

  @override
  List<Object> get props => [id, filter, order];
}

class MarketEventRemove extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;
  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool order;
  final String id;

  const MarketEventRemove(this.id, this.filter, this.order);

  @override
  List<Object> get props => [id, filter, order];
}
