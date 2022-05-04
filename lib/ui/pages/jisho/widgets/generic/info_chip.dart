import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/chip_type.dart';
import 'package:kanpractice/ui/consts.dart';

class InfoChip extends StatelessWidget {
  final String? label;
  final ChipType type;
  const InfoChip({
    Key? key,
    required this.label,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Margins.margin4),
      child: Chip(
        backgroundColor: type.color,
        label: Text(type.label == label
            ? type.label : "${type.label} ${label ?? ""}"
        ),
      ),
    );
  }
}
