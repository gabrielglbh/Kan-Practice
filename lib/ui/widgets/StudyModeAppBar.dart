import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class StudyModeAppBar extends StatelessWidget {
  final String title;
  final String studyMode;
  const StudyModeAppBar({required this.title, required this.studyMode});

  @override
  Widget build(BuildContext context) {
    return FittedBox(fit: BoxFit.fitWidth, child: Column(
      children: [
        Text(title, style: TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
        Text(studyMode, style: TextStyle(fontSize: FontSizes.fontSize14))
      ],
    ));
  }
}
