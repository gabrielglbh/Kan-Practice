import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/market/market.dart';

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
        return Market.uploadedToMarketField;
      case MarketFilters.downloads:
        return Market.downloadField;
      case MarketFilters.rating:
        return Market.ratingField;
      case MarketFilters.words:
        return Market.numberOfWordsField;
      case MarketFilters.mine:
        return Market.uidField;
    }
  }
}

class MarketFiltersUtils {
  static MarketFilters getFilterFrom(String f) {
    if (f == Market.uploadedToMarketField) {
      return MarketFilters.all;
    } else if (f == Market.downloadField) {
      return MarketFilters.downloads;
    } else if (f == Market.ratingField) {
      return MarketFilters.rating;
    } else if (f == Market.uidField) {
      return MarketFilters.mine;
    } else {
      return MarketFilters.words;
    }
  }
}
