import 'package:flutter/material.dart';
import 'package:kanpractice/domain/dictionary_details/word_example.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/custom_expansion_tile.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/scrollable_text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExamplePhrases extends StatelessWidget {
  final List<WordExample> data;
  const ExamplePhrases({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _displayExamplePhrases(context, data),
        ],
      ),
    );
  }

  Widget _displayExamplePhrases(BuildContext context, List<WordExample> data) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
        child: CustomExpansionTile(
            label: "${"jisho_resultData_phrases_label".tr()} (${data.length})",
            children: _listViewOfExamples(context, data)));
  }

  List<Widget> _listViewOfExamples(
      BuildContext context, List<WordExample> data) {
    List<Widget> res = [];
    for (int i = 0; i < data.length; i++) {
      res.add(Padding(
        padding: EdgeInsets.only(top: i != 0 ? KPMargins.margin16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableText(
                label: data[i].word,
                initial: true,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: KPMargins.margin4),
              child: ScrollableText(
                  label: "(${data[i].kana})",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            ScrollableText(
                label: data[i].english,
                style: Theme.of(context).textTheme.bodyMedium),
            const Padding(
              padding: EdgeInsets.only(
                  right: KPMargins.margin64,
                  left: KPMargins.margin64,
                  top: KPMargins.margin8),
              child: Divider(thickness: 2),
            )
          ],
        ),
      ));
    }
    return res;
  }
}
