import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final String label;
  final List<Widget> children;
  final EdgeInsets paddingHorizontal;
  const CustomExpansionTile(
      {super.key,
      required this.label,
      required this.children,
      this.paddingHorizontal = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: paddingHorizontal,
        iconColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.primary,
        title: Text(label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
        children: children,
      ),
    );
  }
}
