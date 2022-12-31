part of 'grammar_details_bloc.dart';

abstract class GrammarPointDetailsEvent extends Equatable {
  const GrammarPointDetailsEvent();

  @override
  List<Object> get props => [];
}

class GrammarPointDetailsEventLoading extends GrammarPointDetailsEvent {
  final GrammarPoint grammarPoint;

  const GrammarPointDetailsEventLoading(this.grammarPoint);

  @override
  List<Object> get props => [grammarPoint];
}

class GrammarPointDetailsEventDelete extends GrammarPointDetailsEvent {
  final GrammarPoint? grammarPoint;

  const GrammarPointDetailsEventDelete(this.grammarPoint);

  @override
  List<Object> get props => [];
}
