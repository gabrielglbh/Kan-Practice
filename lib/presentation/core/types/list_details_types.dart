import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum ListDetailsType { words, grammar }

extension ListDetailsTypeExt on ListDetailsType {
  String get bottomBarLabel {
    switch (this) {
      case ListDetailsType.words:
        return "list_details_words".tr();
      case ListDetailsType.grammar:
        return "list_details_grammar".tr();
    }
  }

  String get searchBarHint {
    switch (this) {
      case ListDetailsType.words:
        return "list_details_searchBar_hint".tr();
      case ListDetailsType.grammar:
        return "list_details_searchBar_hint_grammar".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case ListDetailsType.words:
        return Icons.font_download_outlined;
      case ListDetailsType.grammar:
        return Icons.book_rounded;
    }
  }

  int get page {
    switch (this) {
      case ListDetailsType.words:
        return 0;
      case ListDetailsType.grammar:
        return 1;
    }
  }
}
