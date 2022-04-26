import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class CustomExpansionTile extends StatelessWidget {
  final String label;
  final List<Widget> children;
  final EdgeInsets paddingHorizontal;
  const CustomExpansionTile({
    Key? key,
    required this.label,
    required this.children,
    this.paddingHorizontal = EdgeInsets.zero
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.zero,
      tilePadding: paddingHorizontal,
      iconColor: CustomColors.secondaryColor,
      textColor: CustomColors.secondaryColor,
      title: Text(label, style: const TextStyle(fontSize: FontSizes.fontSize18,
          fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
      )),
      children: children,
    );
  }
}
