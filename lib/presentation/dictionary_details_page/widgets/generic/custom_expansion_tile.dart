import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class CustomExpansionTile extends StatelessWidget {
  final String label;
  final List<Widget> children;
  final EdgeInsets paddingHorizontal;
  const CustomExpansionTile(
      {Key? key,
      required this.label,
      required this.children,
      this.paddingHorizontal = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.zero,
      tilePadding: paddingHorizontal,
      iconColor: KPColors.secondaryColor,
      textColor: KPColors.secondaryColor,
      title: Text(label,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
      children: children,
    );
  }
}
