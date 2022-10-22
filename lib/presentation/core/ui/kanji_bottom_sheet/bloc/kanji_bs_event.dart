part of 'kanji_bs_bloc.dart';

abstract class KanjiBSEvent extends Equatable {
  const KanjiBSEvent();

  @override
  List<Object> get props => [];
}

class KanjiBSEventLoading extends KanjiBSEvent {
  final Kanji kanji;

  const KanjiBSEventLoading(this.kanji);

  @override
  List<Object> get props => [kanji];
}

class KanjiBSEventDelete extends KanjiBSEvent {
  final Kanji? kanji;

  const KanjiBSEventDelete(this.kanji);

  @override
  List<Object> get props => [];
}