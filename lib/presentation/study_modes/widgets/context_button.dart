import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/purchases/purchases_bloc.dart';
import 'package:kanpractice/application/sentence_generator/sentence_generator_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_pro_icon.dart';

class ContextButton extends StatelessWidget {
  final String word;
  const ContextButton({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentenceGeneratorBloc, SentenceGeneratorState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const SizedBox(),
          succeeded: (_, __, ___) => const SizedBox(),
          orElse: () => BlocBuilder<PurchasesBloc, PurchasesState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (state is PurchasesUpdatedToPro) {
                    final bloc = context.read<SentenceGeneratorBloc>();
                    bloc.state.mapOrNull(
                      initial: (_) {
                        bloc.add(SentenceGeneratorEventLoad(words: [word]));
                      },
                      error: (_) {
                        bloc.add(SentenceGeneratorEventLoad(words: [word]));
                      },
                    );
                  } else {
                    Navigator.of(context).pushNamed(KanPracticePages.storePage);
                  }
                },
                style: state is PurchasesUpdatedToPro
                    ? null
                    : ElevatedButton.styleFrom(
                        backgroundColor: KPColors.midGrey,
                      ),
                child: SizedBox(
                  height: KPMargins.margin26,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      state is PurchasesUpdatedToPro
                          ? const Icon(
                              Icons.psychology_outlined,
                              color: Colors.white,
                            )
                          : const KPProIcon(color: Colors.white),
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
              );
            },
          ),
        );
      },
    );
  }
}
