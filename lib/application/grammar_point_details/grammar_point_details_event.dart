part of 'grammar_point_details_bloc.dart';

abstract class GrammarPointDetailsEvent extends Equatable {
  const GrammarPointDetailsEvent();

  @override
  List<Object> get props => [];
}

class GrammarPointDetailsEventLoading extends GrammarPointDetailsEvent {
  final GrammarPoint grammarPoint;
  final bool isArchive;

  const GrammarPointDetailsEventLoading(this.grammarPoint,
      {this.isArchive = false});

  @override
  List<Object> get props => [grammarPoint, isArchive];
}

class GrammarPointDetailsEventDelete extends GrammarPointDetailsEvent {
  final GrammarPoint? grammarPoint;

  const GrammarPointDetailsEventDelete(this.grammarPoint);

  @override
  List<Object> get props => [];
}
