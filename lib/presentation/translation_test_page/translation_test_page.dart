import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:kanpractice/application/sentence_generator/sentence_generator_bloc.dart';
import 'package:kanpractice/application/services/text_to_speech_service.dart';
import 'package:kanpractice/application/services/translate_service.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_learning_header_animation.dart';
import 'package:kanpractice/presentation/core/widgets/kp_learning_text_box.dart';
import 'package:kanpractice/presentation/core/widgets/kp_list_percentage_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_study_mode_app_bar.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_validation_buttons.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/study_modes/utils/study_mode_update_handler.dart';
import 'package:kanpractice/presentation/study_modes/widgets/context_widget.dart';

class TranslationTestPage extends StatefulWidget {
  final ModeArguments args;
  const TranslationTestPage({Key? key, required this.args}) : super(key: key);

  @override
  State<TranslationTestPage> createState() => _TranslationTestPageState();
}

class _TranslationTestPageState extends State<TranslationTestPage> {
  int _macro = 0;
  final _max = KPSizes.numberOfPredictedWords;
  bool _showTranslation = false;
  bool _hasFinished = false;

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// For translating the hiragana
  KanaKit? _kanaKit;

  @override
  void initState() {
    _kanaKit = const KanaKit();
    context.read<StudyModeBloc>().add(StudyModeEventResetTracking());
    context
        .read<SentenceGeneratorBloc>()
        .add(const SentenceGeneratorEventLoad());
    super.initState();
  }

  Future<void> _updateUIOnSubmit(double score) async {
    if (_hasFinished) {
      await _handleFinishedPractice();
    } else {
      final code = await _calculateWordScore(score);

      /// If everything went well, and we have words left in the list,
      /// update _macro to the next one.
      if (code == 0) {
        if (_macro < _max) {
          setState(() {
            _macro++;
            _showTranslation = false;
          });

          if (!mounted) return;
          context
              .read<SentenceGeneratorBloc>()
              .add(const SentenceGeneratorEventLoad());
        }

        /// If we ended the list, update the statistics to DB and exit
        else {
          await _handleFinishedPractice();
        }
      }
    }
  }

  Future<void> _handleFinishedPractice() async {
    _hasFinished = true;

    double testScore = 0;
    for (var s in _testScores) {
      testScore += s;
    }
    final score = testScore / _max;
    await StudyModeUpdateHandler.handle(context, widget.args,
        testScore: score, testScores: _testScores);
  }

  Future<int> _calculateWordScore(double score) async {
    _testScores.add(score);
    return 0;
  }

  String _getProperAlphabet(String sentence) {
    /// Based on the states, update the hiragana version
    String r = "[${(_kanaKit?.isHiragana(sentence) ?? "")}]";
    if (_showTranslation) {
      return r;
    } else {
      return "";
    }
  }

  Future<String> _getProperMeaning(String sentence) async {
    /// Based on the states, update the meaning
    if (_showTranslation) {
      return await getIt<TranslateService>().translate(
        sentence,
        EasyLocalization.of(context)?.locale.languageCode ?? "en",
      );
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      onWillPop: () async {
        return StudyModeUpdateHandler.handle(
          context,
          widget.args,
          onPop: true,
          lastIndex: _macro,
        );
      },
      appBarTitle: StudyModeAppBar(
          title: widget.args.studyModeHeaderDisplayName,
          studyMode: widget.args.mode.mode),
      centerTitle: true,
      child: Column(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                KPListPercentageIndicator(value: (_macro + 1) / _max),
                KPLearningHeaderAnimation(
                  id: _macro,
                  child: BlocConsumer<SentenceGeneratorBloc,
                      SentenceGeneratorState>(
                    listener: (context, state) {
                      state.mapOrNull(
                        succeeded: (s) async {
                          await getIt<TextToSpeechService>()
                              .speakWord(s.sentence);
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        succeeded: (sentence) => _body(sentence),
                        loading: () => const SizedBox(
                          height: KPMargins.margin64 * 2,
                          child: KPProgressIndicator(),
                        ),
                        orElse: () => GestureDetector(
                          onTap: () {
                            context
                                .read<SentenceGeneratorBloc>()
                                .add(const SentenceGeneratorEventLoad());
                          },
                          child:
                              Text("load_failed_try_again_button_label".tr()),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          KPValidationButtons(
            trigger: _showTranslation,
            submitLabel: "done_button_label".tr(),
            action: (score) async => await _updateUIOnSubmit(score),
            onSubmit: () => setState(() => _showTranslation = true),
          ),
        ],
      ),
    );
  }

  Widget _body(String sentence) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Visibility(
            visible: _showTranslation,
            child: KPLearningTextBox(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: KPColors.secondaryColor),
              bottom: KPMargins.margin4,
              text: _getProperAlphabet(sentence),
            ),
          ),
          TTSIconButton(
            word: sentence,
            iconSize: KPMargins.margin64 + KPMargins.margin4,
          ),
          ContextWidget(
            word: sentence,
            showWord: true,
            sentence: sentence,
            mode: StudyModes.recognition,
          ),
          Visibility(
            visible: _showTranslation,
            child: FutureBuilder(
              future: _getProperMeaning(sentence),
              builder: (_, AsyncSnapshot<String> snapshot) {
                return KPLearningTextBox(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  text: snapshot.data ?? '',
                  top: KPMargins.margin8,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
