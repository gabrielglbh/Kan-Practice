import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/models/folder.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/models/rel_folder_kanlist.dart';
import 'package:kanpractice/core/database/models/test_data.dart';
import 'package:kanpractice/core/database/models/test_specific_data.dart';

part 'backup.g.dart';

@JsonSerializable()
class BackUp {
  final List<KanjiList> lists;
  final List<Kanji> kanji;
  final TestData testData;
  final List<TestSpecificData> testSpecData;
  final List<Folder> folders;
  final List<RelFolderKanList> relFolderKanList;
  final int lastUpdated;

  static const String kanjiLabel = "kanji";
  static const String listLabel = "lists";
  static const String testLabel = "testData";
  static const String testSpecLabel = "testSpecData";
  static const String folderLabel = "folders";
  static const String relFolderKanListLabel = "relFK";
  static const String updatedLabel = "lastUpdated";

  const BackUp(
      {required this.lists,
      required this.kanji,
      required this.testData,
      required this.testSpecData,
      required this.folders,
      required this.relFolderKanList,
      required this.lastUpdated});

  /// Empty instance of [BackUp]
  static const BackUp empty = BackUp(
    lists: [],
    kanji: [],
    testData: TestData.empty,
    testSpecData: [],
    folders: [],
    relFolderKanList: [],
    lastUpdated: 0,
  );

  factory BackUp.fromJson(Map<String, dynamic> json) => _$BackUpFromJson(json);
  Map<String, dynamic> toJson() => _$BackUpToJson(this);
}
