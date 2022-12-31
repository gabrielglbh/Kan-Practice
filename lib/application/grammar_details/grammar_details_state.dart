part of 'grammar_details_bloc.dart';

class GrammarPointDetailsState extends Equatable {
  const GrammarPointDetailsState();

  @override
  List<Object?> get props => [];
}

class GrammarPointDetailsStateIdle extends GrammarPointDetailsState {}

class GrammarPointDetailsStateLoading extends GrammarPointDetailsState {}

class GrammarPointDetailsStateRemoved extends GrammarPointDetailsState {}

class GrammarPointDetailsStateLoaded extends GrammarPointDetailsState {
  final GrammarPoint grammarPoint;

  const GrammarPointDetailsStateLoaded(
      {this.grammarPoint = GrammarPoint.empty});

  @override
  List<Object> get props => [grammarPoint];
}

class GrammarPointDetailsStateFailure extends GrammarPointDetailsState {
  final String error;

  const GrammarPointDetailsStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
