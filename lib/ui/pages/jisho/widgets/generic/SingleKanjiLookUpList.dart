import 'package:flutter/material.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class SingleKanjiLookUpList extends StatelessWidget {
  final List<String>? kanjiList;
  const SingleKanjiLookUpList({required this.kanjiList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomSizes.defaultJishoAPIContainer,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kanjiList?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin4),
            child: ActionChip(
              padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
              onPressed: () {
                Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                    arguments: JishoArguments(kanji: kanjiList?[index]));
              },
              label: Text(kanjiList?[index] ?? ""),
            ),
          );
        },
      ),
    );
  }
}
