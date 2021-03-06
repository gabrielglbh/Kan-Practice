part of 'lists_bloc.dart';

abstract class KanjiListEvent extends Equatable {
  const KanjiListEvent();

  @override
  List<Object> get props => [];
}

class KanjiListEventLoading extends KanjiListEvent {
  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const KanjiListEventLoading(
      {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class KanjiListForTestEventLoading extends KanjiListEvent {
  const KanjiListForTestEventLoading();

  @override
  List<Object> get props => [];
}

class KanjiListEventSearching extends KanjiListEvent {
  final String query;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const KanjiListEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class KanjiListEventCreate extends KanjiListEvent {
  final String name;

  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;
  final bool useLazyLoading;

  const KanjiListEventCreate(this.name,
      {required this.filter, required this.order, this.useLazyLoading = true});

  @override
  List<Object> get props => [name, filter, order, useLazyLoading];
}

class KanjiListEventDelete extends KanjiListEvent {
  final KanjiList list;

  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const KanjiListEventDelete(this.list,
      {required this.filter, required this.order});

  @override
  List<Object> get props => [list, filter, order];
}
