import 'package:kanpractice/core/database/models/kanji.dart';

class AddWordArgs {
  final String listName;
  final Kanji? kanji;
  const AddWordArgs({required this.listName, this.kanji});
}
