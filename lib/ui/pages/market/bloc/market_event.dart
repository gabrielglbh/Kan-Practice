part of 'market_bloc.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();

  @override
  List<Object> get props => [];
}

class MarketEventIdle extends MarketEvent {}

class MarketEventLoading extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const MarketEventLoading(
      {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class MarketEventSearching extends MarketEvent {
  final String query;
  final MarketFilters filter;
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const MarketEventSearching(this.query,
      {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class MarketEventDownload extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool order;
  final String id;
  final bool isFolder;

  const MarketEventDownload(this.id, this.isFolder, this.filter, this.order);

  @override
  List<Object> get props => [id, isFolder, filter, order];
}

class MarketEventRemove extends MarketEvent {
  /// Maintains the filter applied by the user for loading new lists
  final MarketFilters filter;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool order;
  final String id;
  final bool isFolder;

  const MarketEventRemove(this.id, this.isFolder, this.filter, this.order);

  @override
  List<Object> get props => [id, filter, order, isFolder];
}
