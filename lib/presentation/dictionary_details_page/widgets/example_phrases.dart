import 'package:flutter/material.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/custom_expansion_tile.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/scrollable_text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExamplePhrases extends StatelessWidget {
  final List<KanjiExample> data;
  const ExamplePhrases({Key? key, required this.data}) : super(key: key);

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

  Widget _displayExamplePhrases(BuildContext context, List<KanjiExample> data) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
        child: CustomExpansionTile(
            label: "${"jisho_resultData_phrases_label".tr()} (${data.length})",
            children: _listViewOfExamples(context, data)));
  }

  List<Widget> _listViewOfExamples(
      BuildContext context, List<KanjiExample> data) {
    List<Widget> res = [];
    for (int i = 0; i < data.length; i++) {
      res.add(Padding(
        padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableText(
                label: data[i].kanji,
                initial: true,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w500)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Margins.margin4),
              child: ScrollableText(
                  label: "(${data[i].kana})",
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            ScrollableText(
                label: data[i].english,
                style: Theme.of(context).textTheme.bodyText2),
            const Padding(
              padding: EdgeInsets.only(
                  right: Margins.margin64,
                  left: Margins.margin64,
                  top: Margins.margin8),
              child: Divider(thickness: 2),
            )
          ],
        ),
      ));
    }
    return res;
  }
}
