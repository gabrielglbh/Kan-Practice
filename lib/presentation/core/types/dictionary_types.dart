import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum DictionaryType { history, convolution, ocr }

extension DictionaryTypeExt on DictionaryType {
  String get title {
    switch (this) {
      case DictionaryType.ocr:
        return "ocr_scanner".tr();
      case DictionaryType.convolution:
        return "dictionary_convolution".tr();
      case DictionaryType.history:
        return "word_history_title".tr();
    }
  }

  String get explanation {
    switch (this) {
      case DictionaryType.ocr:
        return "ocr_scanner_explain".tr();
      case DictionaryType.convolution:
        return "dictionary_convolution_explain".tr();
      case DictionaryType.history:
        return "dictionary_history_explain".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case DictionaryType.ocr:
        return Icons.camera;
      case DictionaryType.convolution:
        return Icons.draw_rounded;
      case DictionaryType.history:
        return Icons.history_rounded;
    }
  }
}
