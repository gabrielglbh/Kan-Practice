import 'package:kanpractice/core/database/models/kanji.dart';

class AddKanjiArgs {
  final String listName;
  final Kanji? kanji;
  const AddKanjiArgs({required this.listName, this.kanji});
}
