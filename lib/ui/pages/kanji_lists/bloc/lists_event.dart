part of 'lists_bloc.dart';

abstract class KanjiListEvent extends Equatable {
  const KanjiListEvent();

  @override
  List<Object> get props => [];
}

class KanjiListEventLoading extends KanjiListEvent {
  /// Maintains the filter applied by the user for loading new lists
  final String filter;
  /// Maintains the order applied by the user for loading new lists
  final bool order;
  final int offset;

  const KanjiListEventLoading({required this.filter, required this.order, this.offset = 0});

  @override
  List<Object> get props => [filter, order, offset];
}

class KanjiListEventSearching extends KanjiListEvent {
  final String query;

  const KanjiListEventSearching(this.query);

  @override
  List<Object> get props => [query];
}

class KanjiListEventCreate extends KanjiListEvent {
  final String name;
  /// Maintains the filter applied by the user for loading new lists
  final String filter;
  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const KanjiListEventCreate(this.name, {required this.filter, required this.order});

  @override
  List<Object> get props => [name, filter, order];
}

class KanjiListEventDelete extends KanjiListEvent {
  final KanjiList list;
  /// Maintains the filter applied by the user for loading new lists
  final String filter;
  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const KanjiListEventDelete(this.list, {required this.filter, required this.order});

  @override
  List<Object> get props => [list, filter, order];
}