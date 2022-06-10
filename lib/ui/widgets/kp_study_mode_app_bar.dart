import 'package:flutter/material.dart';

class StudyModeAppBar extends StatelessWidget {
  final String title;
  final String studyMode;
  const StudyModeAppBar(
      {Key? key, required this.title, required this.studyMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.headline5),
            Text(studyMode, style: Theme.of(context).textTheme.bodyText2)
          ],
        ));
  }
}
