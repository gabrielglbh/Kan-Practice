import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class JishoInfoTile extends StatelessWidget {
  final List<Widget> children;
  const JishoInfoTile({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: CustomSizes.defaultJishoAPIContainer,
          margin: EdgeInsets.symmetric(vertical: Margins.margin8),
          padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children
          ),
        ),
        Divider()
      ],
    );
  }
}
