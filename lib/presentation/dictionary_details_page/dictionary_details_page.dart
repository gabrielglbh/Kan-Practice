import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/dictionary_details/dictionary_details_bloc.dart';
import 'package:kanpractice/domain/dictionary_details/word_data.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/example_phrases.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/add_to_kanlist_bottom_sheet.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/single_word_result.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/word_result.dart';

class DictionaryDetailsPage extends StatelessWidget {
  final DictionaryDetailsArguments args;

  const DictionaryDetailsPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DictionaryDetailsBloc>()
        ..add(DictionaryDetailsLoadingEvent(word: args.word ?? "")),
      child: KPScaffold(
          appBarTitle: args.word ?? "?",
          centerTitle: true,
          appBarActions: [TTSIconButton(word: args.word)],
          child: Column(
            children: [
              Expanded(
                child:
                    BlocConsumer<DictionaryDetailsBloc, DictionaryDetailsState>(
                  listener: (context, state) {
                    state.mapOrNull(loaded: (_) {
                      if (args.word != null) {
                        context.read<DictionaryDetailsBloc>().add(
                            DictionaryDetailsEventAddToHistory(
                                word: args.word!));
                      }
                    });
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (data) => _content(context, data),
                      loading: () => const KPProgressIndicator(),
                      error: () => Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: KPMargins.margin16),
                          child: Text("jisho_no_match".tr(),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      orElse: () => const SizedBox(),
                    );
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
          )),
    );
  }

  Widget _content(BuildContext context, WordData data) {
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
                  visible: data.resultData != null,
                  child: SingleWordResult(
                    data: data.resultData,
                    phrase: data.resultPhrase,
                    fromDictionary: args.fromDictionary,
                  )),
              Visibility(
                  visible: data.resultPhrase.isNotEmpty,
                  child: WordResult(
                    word: args.word,
                    data: data.resultData,
                    phrase: data.resultPhrase,
                    fromDictionary: args.fromDictionary,
                  )),
              Visibility(
                  visible: data.example.isNotEmpty,
                  child: ExamplePhrases(data: data.example)),
              Container(
                height: KPMargins.margin32,
                color: Colors.transparent,
              )
            ],
          ),
        ),
        Visibility(
          visible: args.fromDictionary,
          child: KPButton(
            title2: "dict_jisho_add_word_label".tr(),
            icon: Icons.add,
            onTap: () {
              AddToKanListBottomSheet.show(context, args.word, data);
            },
          ),
        ),
      ],
    );
  }
}
