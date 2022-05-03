import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';

enum MarketFilters { mine, all, downloads, rating, words }

extension MarketFiltersExtensions on MarketFilters {
  String get label {
    switch (this) {
      case MarketFilters.all:
        return "filters_all".tr();
      case MarketFilters.downloads:
        return "market_filter_downloads".tr();
      case MarketFilters.rating:
        return "market_filter_rating".tr();
      case MarketFilters.words:
        return "market_filter_words".tr();
      case MarketFilters.mine:
        return "market_filter_mine".tr();
    }
  }

  String get filter {
    switch (this) {
      case MarketFilters.all:
        return MarketList.uploadedToMarketField;
      case MarketFilters.downloads:
        return MarketList.downloadField;
      case MarketFilters.rating:
        return MarketList.ratingField;
      case MarketFilters.words:
        return MarketList.numberOfWordsField;
      case MarketFilters.mine:
        return MarketList.uidField;
    }
  }
}

class MarketFiltersUtils {
  static MarketFilters getFilterFrom(String f) {
    if (f == MarketList.uploadedToMarketField) {
      return MarketFilters.all;
    } else if (f == MarketList.downloadField) {
      return MarketFilters.downloads;
    } else if (f == MarketList.ratingField) {
      return MarketFilters.rating;
    } else if (f == MarketList.uidField) {
      return MarketFilters.mine;
    } else {
      return MarketFilters.words;
    }
  }
}