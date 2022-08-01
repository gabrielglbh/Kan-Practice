import 'package:easy_localization/easy_localization.dart';

enum TabType { kanlist, folder }

extension TabTypesExt on TabType {
  String get searchBarHint {
    switch (this) {
      case TabType.kanlist:
        return "kanji_lists_searchBar_hint".tr();
      case TabType.folder:
        return "folder_searchBar_hint".tr();
    }
  }
}
