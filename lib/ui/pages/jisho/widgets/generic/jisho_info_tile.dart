import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';

class JishoInfoTile extends StatelessWidget {
  final List<Widget> children;
  final bool needsHeight;
  const JishoInfoTile({
    Key? key,
    required this.children,
    this.needsHeight = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: needsHeight ? CustomSizes.defaultJishoAPIContainer : null,
          margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
          padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
          ),
        ),
        const Divider()
      ],
    );
  }
}
