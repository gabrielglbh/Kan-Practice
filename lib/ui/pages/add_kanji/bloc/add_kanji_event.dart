part of 'add_kanji_bloc.dart';

abstract class AddKanjiEvent extends Equatable {
  const AddKanjiEvent();

  @override
  List<Object> get props => [];
}

class AddKanjiEventIdle extends AddKanjiEvent {}

class AddKanjiEventCreate extends AddKanjiEvent {
  final Kanji kanji;
  final bool exitMode;

  const AddKanjiEventCreate({required this.kanji, required this.exitMode});

  @override
  List<Object> get props => [kanji, exitMode];
}

class AddKanjiEventUpdate extends AddKanjiEvent {
  final String listName;
  final String kanjiPk;
  final Map<String, dynamic> parameters;

  const AddKanjiEventUpdate(this.listName, this.kanjiPk,
      {required this.parameters});

  @override
  List<Object> get props => [listName, kanjiPk, parameters];
}
