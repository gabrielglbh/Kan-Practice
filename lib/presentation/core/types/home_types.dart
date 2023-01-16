import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum HomeType { kanlist, dictionary, actions, market, settings }

extension HomeTypeExt on HomeType {
  String get appBarTitle {
    switch (this) {
      case HomeType.kanlist:
        return "KanPractice";
      case HomeType.market:
        return "market_place_title".tr();
      case HomeType.dictionary:
        return "dict_title".tr();
      case HomeType.actions:
        return '';
      case HomeType.settings:
        return "settings_title".tr();
    }
  }

  String get bottomBarLabel {
    switch (this) {
      case HomeType.kanlist:
        return "bottom_nav_kanlists".tr();
      case HomeType.market:
        return "bottom_nav_market".tr();
      case HomeType.dictionary:
        return "dict_title".tr();
      case HomeType.actions:
        return 'bottom_nav_actions'.tr();
      case HomeType.settings:
        return "settings_title".tr();
    }
  }

  String get searchBarHint {
    switch (this) {
      case HomeType.kanlist:
        return "word_lists_searchBar_hint".tr();
      case HomeType.market:
        return "market_lists_searchBar_hint".tr();
      case HomeType.dictionary:
        return '';
      case HomeType.actions:
        return '';
      case HomeType.settings:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeType.kanlist:
        return Icons.table_rows_rounded;
      case HomeType.market:
        return Icons.shopping_bag_rounded;
      case HomeType.dictionary:
        return Icons.menu_book_rounded;
      case HomeType.actions:
        return Icons.add;
      case HomeType.settings:
        return Icons.settings_rounded;
    }
  }

  int get page {
    switch (this) {
      case HomeType.kanlist:
        return 0;
      case HomeType.dictionary:
        return 1;
      case HomeType.market:
        return 2;
      case HomeType.settings:
        return 3;
      case HomeType.actions:
        return -1;
    }
  }
}
