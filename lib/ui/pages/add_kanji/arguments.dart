import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';

class AddKanjiArgs {
  final KanjiList list;
  final Kanji? kanji;
  const AddKanjiArgs({required this.list, this.kanji});
}