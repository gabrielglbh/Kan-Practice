part of 'word_details_bloc.dart';

abstract class WordDetailsEvent extends Equatable {
  const WordDetailsEvent();

  @override
  List<Object> get props => [];
}

class WordDetailsEventLoading extends WordDetailsEvent {
  final Kanji kanji;

  const WordDetailsEventLoading(this.kanji);

  @override
  List<Object> get props => [kanji];
}

class WordDetailsEventDelete extends WordDetailsEvent {
  final Kanji? kanji;

  const WordDetailsEventDelete(this.kanji);

  @override
  List<Object> get props => [];
}
