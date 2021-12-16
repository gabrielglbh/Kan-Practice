import 'package:flutter/material.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

class ExamplePhrases extends StatelessWidget {
  final List<KanjiExample> data;
  const ExamplePhrases({required this.data});

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
      margin: EdgeInsets.only(top: Margins.margin8),
      padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        iconColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black : Colors.white,
        textColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black : Colors.white,
        title: Text("${"jisho_resultData_phrases_label".tr()} (${data.length})",
            style: TextStyle(fontSize: FontSizes.fontSize18,
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
            )),
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: _listViewOfExamples(data)
          ),
        ],
      )
    );
  }

  Widget _listViewOfExamples(List<KanjiExample> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("• ${data[i].kanji}", maxLines: 2,
                    style: TextStyle(fontSize: FontSizes.fontSize16)
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Margins.margin4),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text("  ${data[i].kana}", maxLines: 2,
                      style: TextStyle(fontSize: FontSizes.fontSize16, fontStyle: FontStyle.italic)
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("  ${data[i].english}", maxLines: 2,
                    style: TextStyle(fontSize: FontSizes.fontSize16)
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
