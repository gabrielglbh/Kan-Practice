part of 'lists_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class ListEventLoading extends ListEvent {
  /// Maintains the filter applied by the user for loading new lists
  final WordListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const ListEventLoading(
      {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class ListForTestEventLoading extends ListEvent {
  const ListForTestEventLoading();

  @override
  List<Object> get props => [];
}

class ListEventSearching extends ListEvent {
  final String query;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const ListEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class ListEventCreate extends ListEvent {
  final String name;

  /// Maintains the filter applied by the user for loading new lists
  final WordListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;
  final bool useLazyLoading;

  const ListEventCreate(this.name,
      {required this.filter, required this.order, this.useLazyLoading = true});

  @override
  List<Object> get props => [name, filter, order, useLazyLoading];
}

class ListEventDelete extends ListEvent {
  final WordList list;

  /// Maintains the filter applied by the user for loading new lists
  final WordListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const ListEventDelete(this.list, {required this.filter, required this.order});

  @override
  List<Object> get props => [list, filter, order];
}
