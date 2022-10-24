part of 'add_word_bloc.dart';

abstract class AddWordEvent extends Equatable {
  const AddWordEvent();

  @override
  List<Object> get props => [];
}

class AddWordEventIdle extends AddWordEvent {}

class AddWordEventCreate extends AddWordEvent {
  final Word word;
  final bool exitMode;

  const AddWordEventCreate({required this.word, required this.exitMode});

  @override
  List<Object> get props => [word, exitMode];
}

class AddWordEventUpdate extends AddWordEvent {
  final String listName;
  final String wordPk;
  final Map<String, dynamic> parameters;

  const AddWordEventUpdate(this.listName, this.wordPk,
      {required this.parameters});

  @override
  List<Object> get props => [listName, wordPk, parameters];
}
