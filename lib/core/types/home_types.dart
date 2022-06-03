import 'package:easy_localization/easy_localization.dart';

enum HomeType { kanlist, market }

extension HomeTypeExt on HomeType {
  String get appBarTitle {
    switch (this) {
      case HomeType.kanlist:
        return "KanPractice";
      case HomeType.market:
        return "market_place_title".tr();
    }
  }

  String get searchBarHint {
    switch (this) {
      case HomeType.kanlist:
        return "kanji_lists_searchBar_hint".tr();
      case HomeType.market:
        return "market_lists_searchBar_hint".tr();
    }
  }
}
