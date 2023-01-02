import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPGrammarWordChip extends StatefulWidget {
  final bool controller;
  final Function() onPressed;
  const KPGrammarWordChip(
      {super.key, required this.controller, required this.onPressed});

  @override
  State<KPGrammarWordChip> createState() => _KPGrammarWordChipState();
}

class _KPGrammarWordChipState extends State<KPGrammarWordChip> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(widget.controller
          ? 'word_change_graphs'.tr()
          : 'grammar_change_graphs'.tr()),
      backgroundColor: KPColors.getSecondaryColor(context),
      avatar: Icon(
        widget.controller
            ? ListDetailsType.words.icon
            : ListDetailsType.grammar.icon,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
      onPressed: widget.onPressed,
    );
  }
}
