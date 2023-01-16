import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/dictionary_details/dictionary_details_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/example_phrases.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/add_to_kanlist_bottom_sheet.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/single_word_result.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/word_result.dart';

class DictionaryDetailsPage extends StatefulWidget {
  final DictionaryDetailsArguments args;

  const DictionaryDetailsPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DictionaryDetailsPage> createState() => _DictionaryDetailsPageState();
}

class _DictionaryDetailsPageState extends State<DictionaryDetailsPage> {
  @override
  void initState() {
    getIt<DictionaryDetailsBloc>()
        .add(DictionaryDetailsLoadingEvent(word: widget.args.word ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
        appBarTitle: widget.args.word ?? "?",
        centerTitle: true,
        appBarActions: [TTSIconButton(word: widget.args.word)],
        child: Column(
          children: [
            Expanded(
              child:
                  BlocConsumer<DictionaryDetailsBloc, DictionaryDetailsState>(
                listener: (context, state) {
                  if (state is DictionaryDetailsStateLoaded &&
                      widget.args.word != null) {
                    getIt<DictionaryDetailsBloc>().add(
                        DictionaryDetailsEventAddToHistory(
                            word: widget.args.word!));
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
            Padding(
              padding: const EdgeInsets.only(bottom: KPMargins.margin8),
              child: Chip(
                backgroundColor: Colors.green[200],
                label: Text("jisho_resultData_powered_by".tr(),
                    style: const TextStyle(color: KPColors.accentLight)),
              ),
            ),
          ],
        ));
  }

  Widget _content(BuildContext context, DictionaryDetailsStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              /// All info is based on the value of state.data.
              /// If resultData is null, it means that the word searched is actually a
              /// compound one.
              /// Example, in the other hand, will be visible for single or compound
              /// word.
              Visibility(
                  visible: state.data.resultData != null,
                  child: SingleWordResult(
                    data: state.data.resultData,
                    phrase: state.data.resultPhrase,
                    fromDictionary: widget.args.fromDictionary,
                  )),
              Visibility(
                  visible: state.data.resultPhrase.isNotEmpty,
                  child: WordResult(
                    word: widget.args.word,
                    data: state.data.resultData,
                    phrase: state.data.resultPhrase,
                    fromDictionary: widget.args.fromDictionary,
                  )),
              Visibility(
                  visible: state.data.example.isNotEmpty,
                  child: ExamplePhrases(data: state.data.example)),
              Container(
                height: KPMargins.margin32,
                color: Colors.transparent,
              )
            ],
          ),
        ),
        Visibility(
          visible: widget.args.fromDictionary,
          child: KPButton(
            title2: "dict_jisho_add_word_label".tr(),
            icon: Icons.add,
            onTap: () {
              AddToKanListBottomSheet.show(
                  context, widget.args.word, state.data);
            },
          ),
        ),
      ],
    );
  }

  Widget _nothingFound() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
        child: Text("jisho_no_match".tr(), textAlign: TextAlign.center),
      ),
    );
  }
}
