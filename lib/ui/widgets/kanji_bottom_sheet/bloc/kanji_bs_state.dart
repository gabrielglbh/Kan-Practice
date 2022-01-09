part of 'kanji_bs_bloc.dart';

class KanjiBSState extends Equatable {
  const KanjiBSState();

  @override
  List<Object?> get props => [];
}

class KanjiBSStateLoading extends KanjiBSState {}

class KanjiBSStateRemoved extends KanjiBSState {}

class KanjiBSStateLoaded extends KanjiBSState {
  final Kanji kanji;

  const KanjiBSStateLoaded({this.kanji = Kanji.empty});

  @override
  List<Object> get props => [kanji];
}

class KanjiBSStateFailure extends KanjiBSState {
  final String error;

  const KanjiBSStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}