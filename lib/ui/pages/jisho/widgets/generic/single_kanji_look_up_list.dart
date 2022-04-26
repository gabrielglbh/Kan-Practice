import 'package:flutter/material.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class SingleKanjiLookUpList extends StatelessWidget {
  final List<String>? kanjiList;
  final bool fromDictionary;
  const SingleKanjiLookUpList({
    Key? key,
    required this.kanjiList,
    required this.fromDictionary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSizes.defaultJishoAPIContainer,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kanjiList?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin4),
            child: ActionChip(
              padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
              onPressed: () {
                Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                    arguments: JishoArguments(kanji: kanjiList?[index], fromDictionary: fromDictionary));
              },
              label: Text(kanjiList?[index] ?? ""),
            ),
          );
        },
      ),
    );
  }
}
