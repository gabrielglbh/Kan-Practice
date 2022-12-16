import 'package:kanpractice/domain/grammar/grammar.dart';

class AddGrammarArgs {
  final String listName;
  final Grammar? grammar;
  const AddGrammarArgs({required this.listName, this.grammar});
}
