import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';

class AddKanjiArgs {
  final String listName;
  final KanjiList list;
  final Kanji? kanji;
  const AddKanjiArgs({required this.listName, required this.list, this.kanji});
}