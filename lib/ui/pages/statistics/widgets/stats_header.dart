import 'package:flutter/material.dart';

class StatsHeader extends StatelessWidget {
  final String title;
  final String value;
  const StatsHeader({super.key, required this.title, this.value = ""});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: RichText(
      text: TextSpan(children: [
        TextSpan(text: title, style: Theme.of(context).textTheme.headline6),
        TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.normal))
      ]),
    ));
  }
}
