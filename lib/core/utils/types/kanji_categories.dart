import 'package:easy_localization/easy_localization.dart';

enum KanjiCategory {
  noun, pronoun, verb, adjective, adverb, expression, counter, preposition, conjunction, interjection
}

extension KanjiCategoryExt on KanjiCategory {
  String get category {
    switch (this) {
      case KanjiCategory.noun:
        return "kanji_category_noun".tr();
      case KanjiCategory.pronoun:
        return "kanji_category_pronoun".tr();
      case KanjiCategory.verb:
        return "kanji_category_verb".tr();
      case KanjiCategory.adjective:
        return "kanji_category_adjective".tr();
      case KanjiCategory.adverb:
        return "kanji_category_adverb".tr();
      case KanjiCategory.expression:
        return "kanji_category_expression".tr();
      case KanjiCategory.counter:
        return "kanji_category_counter".tr();
      case KanjiCategory.preposition:
        return "kanji_category_preposition".tr();
      case KanjiCategory.conjunction:
        return "kanji_category_conjunction".tr();
      case KanjiCategory.interjection:
        return "kanji_category_interjection".tr();
    }
  }
}