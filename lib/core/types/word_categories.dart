import 'package:easy_localization/easy_localization.dart';

enum WordCategory {
  noun,
  pronoun,
  verb,
  adjective,
  adverb,
  expression,
  counter,
  preposition,
  conjunction,
  interjection
}

extension KanjiCategoryExt on WordCategory {
  String get category {
    switch (this) {
      case WordCategory.noun:
        return "kanji_category_noun".tr();
      case WordCategory.pronoun:
        return "kanji_category_pronoun".tr();
      case WordCategory.verb:
        return "kanji_category_verb".tr();
      case WordCategory.adjective:
        return "kanji_category_adjective".tr();
      case WordCategory.adverb:
        return "kanji_category_adverb".tr();
      case WordCategory.expression:
        return "kanji_category_expression".tr();
      case WordCategory.counter:
        return "kanji_category_counter".tr();
      case WordCategory.preposition:
        return "kanji_category_preposition".tr();
      case WordCategory.conjunction:
        return "kanji_category_conjunction".tr();
      case WordCategory.interjection:
        return "kanji_category_interjection".tr();
    }
  }
}
