import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';

class SingleWordLookUpList extends StatelessWidget {
  final List<String>? wordList;
  final bool fromDictionary;
  const SingleWordLookUpList(
      {super.key, required this.wordList, required this.fromDictionary});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: KPSizes.defaultJishoAPIContainer,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: wordList?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
            child: ActionChip(
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
              onPressed: () {
                Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                    arguments: DictionaryDetailsArguments(
                        word: wordList?[index],
                        fromDictionary: fromDictionary));
              },
              label: Text(wordList?[index] ?? ""),
            ),
          );
        },
      ),
    );
  }
}
