part of 'lists_bloc.dart';

abstract class ListsEvent extends Equatable {
  const ListsEvent();

  @override
  List<Object> get props => [];
}

class ListsEventLoading extends ListsEvent {
  /// Maintains the filter applied by the user for loading new lists
  final WordListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const ListsEventLoading(
      {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class ListForTestEventLoading extends ListsEvent {
  const ListForTestEventLoading();

  @override
  List<Object> get props => [];
}

class ListsEventSearching extends ListsEvent {
  final String query;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const ListsEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class ListsEventCreate extends ListsEvent {
  final String name;

  /// Maintains the filter applied by the user for loading new lists
  final WordListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;
  final bool useLazyLoading;

  const ListsEventCreate(this.name,
      {required this.filter, required this.order, this.useLazyLoading = true});

  @override
  List<Object> get props => [name, filter, order, useLazyLoading];
}

class ListsEventDelete extends ListsEvent {
  final WordList list;

  /// Maintains the filter applied by the user for loading new lists
  final WordListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const ListsEventDelete(this.list,
      {required this.filter, required this.order});

  @override
  List<Object> get props => [list, filter, order];
}
