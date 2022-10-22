import 'package:flutter/material.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';

class SingleKanjiLookUpList extends StatelessWidget {
  final List<String>? kanjiList;
  final bool fromDictionary;
  const SingleKanjiLookUpList(
      {Key? key, required this.kanjiList, required this.fromDictionary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: KPSizes.defaultJishoAPIContainer,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kanjiList?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
            child: ActionChip(
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
              onPressed: () {
                Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                    arguments: DictionaryDetailsArguments(
                        kanji: kanjiList?[index],
                        fromDictionary: fromDictionary));
              },
              label: Text(kanjiList?[index] ?? ""),
            ),
          );
        },
      ),
    );
  }
}
