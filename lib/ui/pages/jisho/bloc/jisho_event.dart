part of 'jisho_bloc.dart';

abstract class JishoEvent extends Equatable {
  const JishoEvent();

  @override
  List<Object> get props => [];
}

class JishoLoadingEvent extends JishoEvent {
  final String kanji;

  const JishoLoadingEvent({required this.kanji});

  @override
  List<Object> get props => [kanji];
}