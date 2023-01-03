part of 'list_details_words_bloc.dart';

class ListDetailWordsState extends Equatable {
  const ListDetailWordsState();

  @override
  List<Object?> get props => [];
}

class ListDetailWordsStateIdle extends ListDetailWordsState {}

class ListDetailWordsStateLoading extends ListDetailWordsState {}

class ListDetailWordsStateSearching extends ListDetailWordsState {}

class ListDetailWordsStateLoadedPractice extends ListDetailWordsState {
  final StudyModes mode;
  final List<Word> list;

  const ListDetailWordsStateLoadedPractice(this.mode, this.list);

  @override
  List<Object> get props => [list, mode];
}

class ListDetailWordsStateLoaded extends ListDetailWordsState {
  final List<Word> list;
  final String name;

  const ListDetailWordsStateLoaded(this.list, this.name);

  @override
  List<Object> get props => [list, name];
}

class ListDetailWordsStateFailure extends ListDetailWordsState {
  final String error;

  const ListDetailWordsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
