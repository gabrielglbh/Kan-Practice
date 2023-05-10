import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPLanguageFlag extends StatelessWidget {
  final String language;
  final double height;
  const KPLanguageFlag({
    super.key,
    required this.language,
    this.height = KPMargins.margin24,
  });

  @override
  Widget build(BuildContext context) {
    return LanguageFlag(
      language: Language.values.firstWhere(
        (f) => f.name == language,
        orElse: () => Language.en,
      ),
      height: height,
    );
  }
}
