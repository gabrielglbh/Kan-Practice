import 'package:flutter/material.dart';

class StatsHeader extends StatelessWidget {
  final TextAlign? textAlign;
  final String title;
  final String value;
  final double verticalVisualDensity;
  const StatsHeader({
    super.key,
    required this.title,
    this.value = "",
    this.textAlign,
    this.verticalVisualDensity = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: VisualDensity(vertical: verticalVisualDensity),
        title: RichText(
          textAlign: textAlign ?? TextAlign.start,
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
