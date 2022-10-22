import 'package:kanpractice/domain/word/word.dart';

class AddWordArgs {
  final String listName;
  final Word? kanji;
  const AddWordArgs({required this.listName, this.kanji});
}
