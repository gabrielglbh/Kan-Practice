import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class JishoHeader extends StatelessWidget {
  final String header;
  final bool guideline;
  const JishoHeader({Key? key, required this.header, this.guideline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: guideline,
          child: const Padding(
            padding: EdgeInsets.only(right: Margins.margin8),
            child: Icon(Icons.subdirectory_arrow_right_rounded),
          ),
        ),
        Text(header,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.bold))
      ],
    );
  }
}
