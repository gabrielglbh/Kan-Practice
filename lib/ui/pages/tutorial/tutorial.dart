import 'package:flutter/material.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/tutorial/widgets/BulletPageView.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/CustomCachedNetworkImage.dart';

enum TutorialView {
  kanList, dictionary, list, details, jisho, practicing, options
}

extension TestPagesExt on TutorialView {
  String get tutorial {
    switch (this) {
      case TutorialView.kanList:
        return "tutorial_kanlist".tr();
      case TutorialView.dictionary:
        return "tutorial_dictionary".tr();
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
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Fkanlist.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Fkanlist.png?alt=media";
      case TutorialView.dictionary:
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Fdictionary.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Fdictionary.png?alt=media";
      case TutorialView.list:
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Flist.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Flist.png?alt=media";
      case TutorialView.details:
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Fdetails.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Fdetails.png?alt=media";
      case TutorialView.jisho:
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Fjisho.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Fjisho.png?alt=media";
      case TutorialView.practicing:
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Fpractice.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Fpractice.png?alt=media";
      case TutorialView.options:
        if (lightMode) return "$_baseUri/tutorial%2Flight%2Foptions.png?alt=media";
        else return "$_baseUri/tutorial%2Fdark%2Foptions.png?alt=media";
    }
  }
}

class TutorialPage extends StatefulWidget {
  final bool? alreadyShown;
  TutorialPage({this.alreadyShown});

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  bool _showSkip = true;

  _onEnd(BuildContext context) {
    if (widget.alreadyShown == null) {
      StorageManager.saveData(StorageManager.hasDoneTutorial, true);
      Navigator.of(context).pushReplacementNamed(KanPracticePages.kanjiListPage);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        actions: [
          TextButton(
            onPressed: () => _onEnd(context),
            child: Text(_showSkip ? "tutorial_skip".tr() : "tutorial_done".tr(),
              style: TextStyle(color: CustomColors.secondaryColor),
            )
          )
        ],
      ),
      body: BulletPageView(
        bullets: TutorialView.values.length,
        onChanged: (newPage) => setState(() => _showSkip = newPage != TutorialView.values.length - 1),
        pageViewChildren: List.generate(TutorialView.values.length, (view) =>
          _tutorialPage(context, TutorialView.values[view])
        ),
      )
    );
  }

  Column _tutorialPage(BuildContext context, TutorialView view) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(Margins.margin8),
            child: SingleChildScrollView(child: Text(view.tutorial, textAlign: TextAlign.center)),
          )
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(Margins.margin8),
            margin: EdgeInsets.symmetric(horizontal: Margins.margin8),
            child: CustomCachedNetworkImage(
              url: view.asset(lightMode: Theme.of(context).brightness == Brightness.light),
              errorMessage: "image_not_loaded".tr(),
            ),
          ),
        ),
      ],
    );
  }
}
