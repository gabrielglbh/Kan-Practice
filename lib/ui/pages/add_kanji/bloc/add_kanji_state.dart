part of 'add_kanji_bloc.dart';

class AddKanjiState extends Equatable {
  const AddKanjiState();

  @override
  List<Object?> get props => [];
}

class AddKanjiStateIdle extends AddKanjiState {}

class AddKanjiStateLoading extends AddKanjiState {}

class AddKanjiStateDoneCreating extends AddKanjiState {
  final bool exitMode;

  const AddKanjiStateDoneCreating({required this.exitMode});

  @override
  List<Object?> get props => [exitMode];
}

class AddKanjiStateDoneUpdating extends AddKanjiState {}

class AddKanjiStateFailure extends AddKanjiState {
  final String message;

  const AddKanjiStateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}