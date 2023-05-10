import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_language_flag.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  static Future<String?> show(BuildContext context) async {
    String? language;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const LanguageBottomSheet()).then((value) {
      language = value;
    });
    return language;
  }

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String get _currentLocale =>
      WidgetsBinding.instance.window.locale.languageCode;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("add_market_list_language_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 3),
                margin: const EdgeInsets.all(KPMargins.margin8),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: KPMargins.margin4),
                  itemCount:
                      CountryLanguages.countryLanguage[_currentLocale]!.length,
                  itemBuilder: (context, index) {
                    LanguageObj language = CountryLanguages
                        .countryLanguage[_currentLocale]!
                        .elementAt(index);
                    return ListTile(
                      onTap: () => Navigator.of(context).pop(language.code),
                      title: Text(language.name),
                      leading: KPLanguageFlag(language: language.code),
                    );
                  },
                ),
              ),
            ],
          ),
        ]);
      },
    );
  }
}
