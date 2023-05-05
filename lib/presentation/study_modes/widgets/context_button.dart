import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/sentence_generator/sentence_generator_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ContextButton extends StatelessWidget {
  final String word;
  const ContextButton({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentenceGeneratorBloc, SentenceGeneratorState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const SizedBox(),
          succeeded: (_, __) => const SizedBox(),
          orElse: () => ElevatedButton(
            onPressed: () {
              final bloc = context.read<SentenceGeneratorBloc>();
              bloc.state.mapOrNull(
                initial: (_) {
                  bloc.add(SentenceGeneratorEventLoad(words: [word]));
                },
                error: (_) {
                  bloc.add(SentenceGeneratorEventLoad(words: [word]));
                },
              );
            },
            child: SizedBox(
              height: KPMargins.margin26,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lightbulb_rounded,
                    color: Colors.white,
                    size: KPMargins.margin18,
                  ),
                  const SizedBox(width: KPMargins.margin4),
                  Flexible(
                    child: Text("provide_context".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
