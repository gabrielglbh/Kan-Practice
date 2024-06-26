import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/chip_type.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class InfoChip extends StatelessWidget {
  final String? label;
  final ChipType type;
  const InfoChip({super.key, required this.label, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
      child: Chip(
        backgroundColor: type.color,
        side: BorderSide.none,
        label: Text(
          type.label == label ? type.label : "${type.label} ${label ?? ""}",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
