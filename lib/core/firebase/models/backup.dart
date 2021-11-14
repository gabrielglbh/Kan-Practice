import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';

class BackUp {
  final List<KanjiList> lists;
  final List<Kanji> kanji;
  final int lastUpdated;

  static final String kanjiLabel = "kanji";
  static final String listLabel = "lists";
  static final String updatedLabel = "lastUpdated";

  const BackUp({required this.lists, required this.kanji, required this.lastUpdated});

  /// Empty instance of [BackUp]
  static const BackUp empty = BackUp(lists: [], kanji: [], lastUpdated: 0);

  /// Creates a JSON map from all of its attributes: [lists], [kanji] and [tests]
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> lists = [];
    List<Map<String, dynamic>> kanji = [];
    this.lists.forEach((l) => lists.add(l.toJson()));
    this.kanji.forEach((k) => kanji.add(k.toJson()));

    return {
      listLabel: lists,
      kanjiLabel: kanji,
      updatedLabel: lastUpdated
    };
  }

  /// Converts the [json] map into Plain Objects of [Kanji]
  List<Kanji> kanjiFromJson(Map<String, dynamic> json) {
    List<dynamic> jsonKanji = json[kanjiLabel];
    List<Kanji> parsedKanji= [];
    for(int y = 0; y < jsonKanji.length; y++) parsedKanji.add(Kanji.fromJson(jsonKanji[y]));
    return parsedKanji;
  }

  /// Converts the [json] map into Plain Objects of [KanjiList]
  List<KanjiList> kanjiListFromJson(Map<String, dynamic> json) {
    List<dynamic> jsonKanjiLists = json[listLabel];
    List<KanjiList> parsedKanjiLists= [];
    for(int y = 0; y < jsonKanjiLists.length; y++) parsedKanjiLists.add(KanjiList.fromJson(jsonKanjiLists[y]));
    return parsedKanjiLists;
  }
}