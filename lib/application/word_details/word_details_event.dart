part of 'word_details_bloc.dart';

abstract class WordDetailsEvent extends Equatable {
  const WordDetailsEvent();

  @override
  List<Object> get props => [];
}

class WordDetailsEventLoading extends WordDetailsEvent {
  final Word word;
  final bool isArchive;

  const WordDetailsEventLoading(this.word, {this.isArchive = false});

  @override
  List<Object> get props => [word, isArchive];
}

class WordDetailsEventDelete extends WordDetailsEvent {
  final Word? word;

  const WordDetailsEventDelete(this.word);

  @override
  List<Object> get props => [];
}
