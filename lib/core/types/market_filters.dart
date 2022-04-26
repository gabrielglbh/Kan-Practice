import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';

enum MarketFilters { all, downloads, rating }

extension MarketFiltersExtensions on MarketFilters {
  String get label {
    switch (this) {
      case MarketFilters.all:
        return "filters_all".tr();
      case MarketFilters.downloads:
        return "market_filter_rating".tr();
      case MarketFilters.rating:
        return "market_filter_downloads".tr();
    }
  }

  String get filter {
    switch (this) {
      case MarketFilters.all:
        return MarketList.updatedToMarketField;
      case MarketFilters.downloads:
        return MarketList.downloadField;
      case MarketFilters.rating:
        return MarketList.ratingField;
    }
  }
}

class MarketFiltersUtils {
  static MarketFilters getFilterFrom(String f) {
    if (f == MarketList.updatedToMarketField) {
      return MarketFilters.all;
    } else if (f == MarketList.downloadField) {
      return MarketFilters.downloads;
    } else {
      return MarketFilters.rating;
    }
  }
}