import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/dictionary_details/dictionary_details_bloc.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/example_phrases.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/add_to_kanlist_bottom_sheet.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/single_kanji_result.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/word_result.dart';

class DictionaryDetailsPage extends StatelessWidget {
  final DictionaryDetailsArguments args;

  const DictionaryDetailsPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
        appBarTitle: args.kanji ?? "?",
        centerTitle: true,
        appBarActions: [TTSIconButton(kanji: args.kanji)],
        child: Column(
          children: [
            Expanded(
              child: BlocProvider<DictionaryDetailsBloc>(
                create: (_) => DictionaryDetailsBloc()
                  ..add(DictionaryDetailsLoadingEvent(kanji: args.kanji ?? "")),
                child:
                    BlocConsumer<DictionaryDetailsBloc, DictionaryDetailsState>(
                  listener: (context, state) {
                    if (state is DictionaryDetailsStateLoaded &&
                        args.kanji != null) {
                      context.read<DictionaryDetailsBloc>().add(
                          DictionaryDetailsEventAddToHistory(
                              word: args.kanji!));
                    }
                  },
                  builder: (context, state) {
                    if (state is DictionaryDetailsStateLoading) {
                      return const KPProgressIndicator();
                    } else if (state is DictionaryDetailsStateFailure) {
                      return _nothingFound();
                    } else if (state is DictionaryDetailsStateLoaded) {
                      return _content(context, state);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            _poweredByDictionaryDetails(),
          ],
        ));
  }

  Widget _content(BuildContext context, DictionaryDetailsStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Visibility(
                visible: args.fromDictionary,
                child: KPButton(
                  title2: "dict_DictionaryDetails_add_kanji_label".tr(),
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
            child: Text("DictionaryDetails_no_match".tr(),
                textAlign: TextAlign.center)));
  }

  Widget _poweredByDictionaryDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
      child: Chip(
        backgroundColor: Colors.green[200],
        label: Text("DictionaryDetails_resultData_powered_by".tr(),
            style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
