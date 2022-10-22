import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class JishoInfoTile extends StatelessWidget {
  final List<Widget> children;
  final bool needsHeight;
  const JishoInfoTile(
      {Key? key, required this.children, this.needsHeight = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: needsHeight ? KPSizes.defaultJishoAPIContainer : null,
          margin: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
          padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
        const Divider()
      ],
    );
  }
}
