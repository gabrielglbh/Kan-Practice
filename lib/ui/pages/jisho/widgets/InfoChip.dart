import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class InfoChip extends StatelessWidget {
  final String? label;
  const InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Margins.margin4),
      child: Chip(
        backgroundColor: CustomColors.secondarySubtleColor,
        label: Text(label ?? ""),
      ),
    );
  }
}
