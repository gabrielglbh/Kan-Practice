import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/sentence_generator/sentence_generator_bloc.dart';
import 'package:kanpractice/application/services/text_to_speech_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';

class ContextLoader extends StatelessWidget {
  final String word;
  final StudyModes mode;
  final Widget Function(String?) child;
  const ContextLoader({
    super.key,
    required this.word,
    required this.child,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SentenceGeneratorBloc, SentenceGeneratorState>(
      listener: (context, state) {
        state.mapOrNull(succeeded: (s) async {
          /// Execute the TTS when passing to the next word
          if (mode == StudyModes.listening) {
            await getIt<TextToSpeechService>().speakWord(s.sentence);
          }
        }, error: (_) async {
          await getIt<TextToSpeechService>().speakWord(word);
        });
      },
      builder: (context, state) {
        return state.maybeWhen(
          succeeded: (sentence, _, __) => child(sentence),
          loading: () => const SizedBox(
            height: KPMargins.margin64 * 2,
            child: KPProgressIndicator(),
          ),
          orElse: () => child(null),
        );
      },
    );
  }
}
