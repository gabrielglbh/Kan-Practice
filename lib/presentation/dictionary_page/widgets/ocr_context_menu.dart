import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/services/translate_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';

class OCRContextMenu extends StatelessWidget {
  final Offset anchor;
  final String selectedText;
  const OCRContextMenu(
      {super.key, required this.anchor, required this.selectedText});

  final _height = 200.0;

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
              color: KPColors.getAlterAccent(context),
              borderRadius: BorderRadius.circular(KPRadius.radius16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: KPMargins.margin16),
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
                    height: 1,
                    indent: KPMargins.margin8,
                    endIndent: KPMargins.margin8,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(KPMargins.margin16),
                      child: FutureBuilder(
                        future: getIt<TranslateService>().translate(
                            selectedText,
                            EasyLocalization.of(context)
                                    ?.currentLocale
                                    ?.languageCode ??
                                'en'),
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
