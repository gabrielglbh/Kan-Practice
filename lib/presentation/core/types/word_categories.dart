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

extension WordCategoryExt on WordCategory {
  String get category {
    switch (this) {
      case WordCategory.noun:
        return "word_category_noun".tr();
      case WordCategory.pronoun:
        return "word_category_pronoun".tr();
      case WordCategory.verb:
        return "word_category_verb".tr();
      case WordCategory.adjective:
        return "word_category_adjective".tr();
      case WordCategory.adverb:
        return "word_category_adverb".tr();
      case WordCategory.expression:
        return "word_category_expression".tr();
      case WordCategory.counter:
        return "word_category_counter".tr();
      case WordCategory.preposition:
        return "word_category_preposition".tr();
      case WordCategory.conjunction:
        return "word_category_conjunction".tr();
      case WordCategory.interjection:
        return "word_category_interjection".tr();
    }
  }
}
