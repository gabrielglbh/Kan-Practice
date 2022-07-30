import 'package:json_annotation/json_annotation.dart';

part 'rel_folder_kanlist.g.dart';

@JsonSerializable()
class RelFolderKanList {
  final String folder;
  final String kanList;

  RelFolderKanList({required this.folder, required this.kanList});

  /// Empty [RelFolderKanList]
  static final RelFolderKanList empty =
      RelFolderKanList(folder: "", kanList: "");

  factory RelFolderKanList.fromJson(Map<String, dynamic> json) =>
      _$RelFolderKanListFromJson(json);
  Map<String, dynamic> toJson() => _$RelFolderKanListToJson(this);
}
