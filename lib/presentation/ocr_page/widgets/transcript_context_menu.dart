import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/translate_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';

class TranscriptContextMenu extends StatelessWidget {
  final Offset anchor;
  final String selectedText;
  const TranscriptContextMenu(
      {super.key, required this.anchor, required this.selectedText});

  final _height = 132.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: anchor.dy - (_height + KPMargins.margin16),
          left: KPMargins.margin32,
          child: Container(
            width: MediaQuery.of(context).size.width - KPMargins.margin64,
            height: _height,
            decoration: BoxDecoration(
              color: KPColors.getPrimary(context),
              borderRadius: BorderRadius.circular(KPRadius.radius16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: KPMargins.margin8),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('ocr_search_in_jisho_part1'.tr()),
                        const SizedBox(width: KPMargins.margin4),
                        Flexible(
                          child: Text(
                            selectedText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: KPMargins.margin4),
                        Text('ocr_search_in_jisho_part2'.tr()),
                      ],
                    ),
                    visualDensity: const VisualDensity(vertical: -2),
                    trailing: const Icon(Icons.search_rounded),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        KanPracticePages.jishoPage,
                        arguments: DictionaryDetailsArguments(
                            word: selectedText, fromDictionary: true),
                      );
                    },
                  ),
                  const Divider(
                    indent: KPMargins.margin8,
                    endIndent: KPMargins.margin8,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: KPMargins.margin16),
                      child: FutureBuilder(
                        future: getIt<TranslateService>()
                            .translate(selectedText, Utils.currentLocale),
                        initialData: 'translation_loading'.tr(),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return SingleChildScrollView(
                            child: Text(
                              snapshot.data ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
