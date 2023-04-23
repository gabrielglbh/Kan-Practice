import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';

enum WordCategoryFilter {
  all,
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

extension WordCategoryFilterExt on WordCategoryFilter {
  String get category {
    switch (this) {
      case WordCategoryFilter.all:
        return "filters_all".tr();
      case WordCategoryFilter.noun:
        return "word_category_noun".tr();
      case WordCategoryFilter.pronoun:
        return "word_category_pronoun".tr();
      case WordCategoryFilter.verb:
        return "word_category_verb".tr();
      case WordCategoryFilter.adjective:
        return "word_category_adjective".tr();
      case WordCategoryFilter.adverb:
        return "word_category_adverb".tr();
      case WordCategoryFilter.expression:
        return "word_category_expression".tr();
      case WordCategoryFilter.counter:
        return "word_category_counter".tr();
      case WordCategoryFilter.preposition:
        return "word_category_preposition".tr();
      case WordCategoryFilter.conjunction:
        return "word_category_conjunction".tr();
      case WordCategoryFilter.interjection:
        return "word_category_interjection".tr();
    }
  }

  int get filter {
    switch (this) {
      case WordCategoryFilter.all:
        return -1;
      case WordCategoryFilter.noun:
        return WordCategory.noun.index;
      case WordCategoryFilter.pronoun:
        return WordCategory.pronoun.index;
      case WordCategoryFilter.verb:
        return WordCategory.verb.index;
      case WordCategoryFilter.adjective:
        return WordCategory.adjective.index;
      case WordCategoryFilter.adverb:
        return WordCategory.adverb.index;
      case WordCategoryFilter.expression:
        return WordCategory.expression.index;
      case WordCategoryFilter.counter:
        return WordCategory.counter.index;
      case WordCategoryFilter.preposition:
        return WordCategory.preposition.index;
      case WordCategoryFilter.conjunction:
        return WordCategory.conjunction.index;
      case WordCategoryFilter.interjection:
        return WordCategory.interjection.index;
    }
  }
}
