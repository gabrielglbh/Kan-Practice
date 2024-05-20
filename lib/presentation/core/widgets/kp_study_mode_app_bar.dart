import 'package:flutter/material.dart';

class StudyModeAppBar extends StatelessWidget {
  final String title;
  final String studyMode;
  const StudyModeAppBar(
      {super.key, required this.title, required this.studyMode});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(studyMode, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ));
  }
}
