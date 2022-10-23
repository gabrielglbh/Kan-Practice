import 'package:kanpractice/domain/word/word.dart';

class AddWordArgs {
  final String listName;
  final Word? word;
  const AddWordArgs({required this.listName, this.word});
}
