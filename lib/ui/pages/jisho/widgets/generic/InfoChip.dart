import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';

enum ChipType {
  common, uncommon, unknown, jlpt, stroke
}

extension ChipTypeExt on ChipType {
  String get label {
    switch (this) {
      case ChipType.common:
        return "jisho_phraseData_common".tr();
      case ChipType.uncommon:
        return "jisho_phraseData_uncommon".tr();
      case ChipType.unknown:
        return "jisho_phraseData_unknown".tr();
      case ChipType.jlpt:
        return "jisho_resultData_jlpt".tr();
      case ChipType.stroke:
        return "jisho_resultData_strokes".tr();
    }
  }

  Color get color {
    switch (this) {
      case ChipType.common:
        return Colors.blueAccent.shade400;
      case ChipType.uncommon:
        return Colors.blueAccent.shade200;
      case ChipType.unknown:
        return Colors.blueAccent.shade100;
      case ChipType.jlpt:
        return CustomColors.secondarySubtleColor;
      case ChipType.stroke:
        return Colors.orangeAccent.shade200;
    }
  }
}

class InfoChip extends StatelessWidget {
  final String? label;
  final ChipType type;
  const InfoChip({required this.label, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Margins.margin4),
      child: Chip(
        backgroundColor: type.color,
        label: Text(type.label == label
            ? type.label : "${type.label} ${label ?? ""}"
        ),
      ),
    );
  }
}
