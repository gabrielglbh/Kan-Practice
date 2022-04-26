import 'package:flutter/material.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/custom_expansion_tile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/scrollable_text.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class ExamplePhrases extends StatelessWidget {
  final List<KanjiExample> data;
  const ExamplePhrases({
    Key? key,
    required this.data
  }) : super(key: key);

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
        children: _listViewOfExamples(data)
      )
    );
  }

  List<Widget> _listViewOfExamples(List<KanjiExample> data) {
    List<Widget> res = [];
    for (int i = 0; i < data.length; i++) {
      res.add(Padding(
        padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableText(label: data[i].kanji, initial: true,
              italic: false, fontSize: FontSizes.fontSize18),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Margins.margin4),
              child: ScrollableText(label: "(${data[i].kana})", fontSize: FontSizes.fontSize14),
            ),
            ScrollableText(label: data[i].english, italic: false),
            const Padding(
              padding: EdgeInsets.only(
                  right: Margins.margin64, left: Margins.margin64,
                  top: Margins.margin8
              ),
              child: Divider(thickness: 2),
            )
          ],
        ),
      ));
    }
    return res;
  }
}
