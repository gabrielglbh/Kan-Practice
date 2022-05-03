import 'package:easy_localization/easy_localization.dart';

enum TutorialView {
  kanList, market, dictionary, list, details, jisho, practicing, options
}

extension TestPagesExt on TutorialView {
  String get tutorial {
    switch (this) {
      case TutorialView.kanList:
        return "tutorial_kanlist".tr();
      case TutorialView.dictionary:
        return "tutorial_dictionary".tr();
      case TutorialView.market:
        return "tutorial_market".tr();
      case TutorialView.list:
        return "tutorial_lists".tr();
      case TutorialView.details:
        return "tutorial_details".tr();
      case TutorialView.jisho:
        return "tutorial_jisho".tr();
      case TutorialView.practicing:
        return "tutorial_practicing".tr();
      case TutorialView.options:
        return "tutorial_options".tr();
    }
  }

  String asset({bool lightMode = true}) {
    String _baseUri = "https://firebasestorage.googleapis.com/v0/b/kanpractice.appspot.com/o";
    switch (this) {
      case TutorialView.kanList:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Fkanlist.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Fkanlist.png?alt=media";
        }
      case TutorialView.dictionary:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Fdictionary.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Fdictionary.png?alt=media";
        }
      case TutorialView.market:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Fmarket.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Fmarket.png?alt=media";
        }
      case TutorialView.list:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Flist.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Flist.png?alt=media";
        }
      case TutorialView.details:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Fdetails.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Fdetails.png?alt=media";
        }
      case TutorialView.jisho:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Fjisho.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Fjisho.png?alt=media";
        }
      case TutorialView.practicing:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Fpractice.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Fpractice.png?alt=media";
        }
      case TutorialView.options:
        if (lightMode) {
          return "$_baseUri/tutorial%2Flight%2Foptions.png?alt=media";
        } else {
          return "$_baseUri/tutorial%2Fdark%2Foptions.png?alt=media";
        }
    }
  }
}