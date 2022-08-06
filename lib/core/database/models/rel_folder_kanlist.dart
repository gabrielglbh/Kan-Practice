import 'package:json_annotation/json_annotation.dart';

part 'rel_folder_kanlist.g.dart';

@JsonSerializable()
class RelFolderKanList {
  final String folder;
  final String kanListName;

  RelFolderKanList({required this.folder, required this.kanListName});

  /// Empty [RelFolderKanList]
  static final RelFolderKanList empty =
      RelFolderKanList(folder: "", kanListName: "");

  factory RelFolderKanList.fromJson(Map<String, dynamic> json) =>
      _$RelFolderKanListFromJson(json);
  Map<String, dynamic> toJson() => _$RelFolderKanListToJson(this);
}
