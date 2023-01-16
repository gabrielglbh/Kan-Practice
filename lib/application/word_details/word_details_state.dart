part of 'word_details_bloc.dart';

class WordDetailsState extends Equatable {
  const WordDetailsState();

  @override
  List<Object?> get props => [];
}

class WordDetailsStateIdle extends WordDetailsState {}

class WordDetailsStateLoading extends WordDetailsState {}

class WordDetailsStateRemoved extends WordDetailsState {}

class WordDetailsStateLoaded extends WordDetailsState {
  final Word word;

  const WordDetailsStateLoaded({this.word = Word.empty});

  @override
  List<Object> get props => [word];
}

class WordDetailsStateFailure extends WordDetailsState {
  final String error;

  const WordDetailsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
