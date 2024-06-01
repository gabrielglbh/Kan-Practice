import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/timer.dart';

class StudyModeAppBar extends StatelessWidget {
  final String title;
  final String studyMode;
  final int elapsedTime;
  const StudyModeAppBar({
    super.key,
    required this.title,
    required this.studyMode,
    this.elapsedTime = -1,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(
                elapsedTime != -1
                    ? "$studyMode • ${elapsedTime.format()}"
                    : studyMode,
                style: Theme.of(context).textTheme.bodyMedium)
          ],
        ));
  }
}
