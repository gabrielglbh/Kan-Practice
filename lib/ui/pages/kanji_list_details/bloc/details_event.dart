part of 'details_bloc.dart';

abstract class KanjiListDetailEvent extends Equatable {
  const KanjiListDetailEvent();

  @override
  List<Object> get props => [];
}

class KanjiEventLoading extends KanjiListDetailEvent {
  final String list;

  const KanjiEventLoading(this.list);

  @override
  List<Object> get props => [list];
}