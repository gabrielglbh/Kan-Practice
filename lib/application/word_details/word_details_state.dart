part of 'word_details_bloc.dart';

class WordDetailsState extends Equatable {
  const WordDetailsState();

  @override
  List<Object?> get props => [];
}

class WordDetailsStateLoading extends WordDetailsState {}

class WordDetailsStateRemoved extends WordDetailsState {}

class WordDetailsStateLoaded extends WordDetailsState {
  final Word kanji;

  const WordDetailsStateLoaded({this.kanji = Word.empty});

  @override
  List<Object> get props => [kanji];
}

class WordDetailsStateFailure extends WordDetailsState {
  final String error;

  const WordDetailsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
