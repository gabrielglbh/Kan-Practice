import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/pages/jisho/bloc/jisho_bloc.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/example_phrases.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/single_kanji_result.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/word_result.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/add_to_kanlist_bottom_sheet.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_tts_icon_button.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class JishoPage extends StatelessWidget {
  final JishoArguments args;

  const JishoPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
        appBarTitle: args.kanji ?? "?",
        centerTitle: true,
        appBarActions: [TTSIconButton(kanji: args.kanji)],
        child: Column(
          children: [
            Expanded(
              child: BlocProvider<JishoBloc>(
                create: (_) => JishoBloc()
                  ..add(JishoLoadingEvent(kanji: args.kanji ?? "")),
                child: BlocConsumer<JishoBloc, JishoState>(
                  listener: (context, state) {
                    if (state is JishoStateLoaded && args.kanji != null) {
                      context
                          .read<JishoBloc>()
                          .add(JishoEventAddToHistory(word: args.kanji!));
                    }
                  },
                  builder: (context, state) {
                    if (state is JishoStateLoading) {
                      return const KPProgressIndicator();
                    } else if (state is JishoStateFailure) {
                      return _nothingFound();
                    } else if (state is JishoStateLoaded) {
                      return _content(context, state);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            _poweredByJisho(),
          ],
        ));
  }

  Widget _content(BuildContext context, JishoStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Visibility(
                visible: args.fromDictionary,
                child: KPButton(
                  title2: "dict_jisho_add_kanji_label".tr(),
                  onTap: () {
                    AddToKanListBottomSheet.callAddToKanListBottomSheet(
                        context, args.kanji, state.data);
                  },
                ),
              ),

              /// All info is based on the value of state.data.
              /// If resultData is null, it means that the kanji searched is actually a
              /// compound one.
              /// Example, in the other hand, will be visible for single or compound
              /// kanji.
              Visibility(
                  visible: state.data.resultData != null,
                  child: SingleKanjiResult(
                    data: state.data.resultData,
                    phrase: state.data.resultPhrase,
                    fromDictionary: args.fromDictionary,
                  )),
              Visibility(
                  visible: state.data.resultPhrase.isNotEmpty,
                  child: WordResult(
                    kanji: args.kanji,
                    data: state.data.resultData,
                    phrase: state.data.resultPhrase,
                    fromDictionary: args.fromDictionary,
                  )),
              Visibility(
                  visible: state.data.example.isNotEmpty,
                  child: ExamplePhrases(data: state.data.example)),
              Container(
                height: Margins.margin32,
                color: Colors.transparent,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _nothingFound() {
    return Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: Text("jisho_no_match".tr(), textAlign: TextAlign.center)));
  }

  Widget _poweredByJisho() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
      child: Chip(
        backgroundColor: Colors.green[200],
        label: Text("jisho_resultData_powered_by".tr(),
            style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
