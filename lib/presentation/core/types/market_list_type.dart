import 'package:easy_localization/easy_localization.dart';

enum MarketListType { list, folder }

extension MarketListTypeExt on MarketListType {
  String get name {
    switch (this) {
      case MarketListType.list:
        return "market_list_to_upload".tr();
      case MarketListType.folder:
        return "market_folder_to_upload".tr();
    }
  }
}
