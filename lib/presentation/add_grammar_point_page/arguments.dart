import 'package:kanpractice/domain/grammar_point/grammar_point.dart';

class AddGrammarPointArgs {
  final String listName;
  final GrammarPoint? grammarPoint;
  const AddGrammarPointArgs({required this.listName, this.grammarPoint});
}
