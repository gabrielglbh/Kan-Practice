import 'package:flutter/material.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/widgets/kp_word_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class WordsOnTestList extends StatelessWidget {
  final Map<String, List<Map<Word, double>>>? list;
  final bool tappable;
  const WordsOnTestList(
      {super.key, required this.list, required this.tappable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: ListView.builder(
        itemCount: list?.keys.toList().length,
        itemBuilder: (context, index) {
          String? listName = list?.keys.toList()[index];
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: KPMargins.margin8),
                child: Text("$listName (${list?[listName]?.length}):",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: 2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list?[listName]?.length,
                itemBuilder: (context, inner) {
                  Word? word = list?[listName]?[inner].keys.first;
                  double? testScore = list?[listName]?[inner].values.first;
                  return Container(
                    width: KPSizes.defaultSizeWordItemOnResultTest,
                    margin: const EdgeInsets.only(
                        left: KPMargins.margin4,
                        right: KPMargins.margin4,
                        bottom: KPMargins.margin4,
                        top: KPMargins.margin4),
                    decoration: BoxDecoration(
                      color: Utils.getColorBasedOnWinRate(testScore ?? 0),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(KPRadius.radius8)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0.5),
                            blurRadius: KPRadius.radius4)
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(KPRadius.radius8)),
                          onTap: tappable
                              ? () async {
                                  await KPWordBottomSheet.show(
                                      context, (word?.listName ?? ""), word);
                                }
                              : null,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: KPMargins.margin2),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text((word?.word ?? ""),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: KPColors.accentLight)),
                              ))),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
