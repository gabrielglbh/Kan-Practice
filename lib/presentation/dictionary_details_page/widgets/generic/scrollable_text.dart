import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ScrollableText extends StatelessWidget {
  final String? label;

  /// Whether to parse the text for nullables or put it raw
  final bool rawText;

  /// Whether to put a bullet point on the beginning of the text or not
  final bool initial;
  final TextStyle? style;
  final bool paddingTop;
  const ScrollableText(
      {Key? key,
      required this.label,
      this.initial = false,
      this.paddingTop = false,
      this.rawText = false,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingTop
          ? const EdgeInsets.only(top: Margins.margin8)
          : EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      child: Text(
          rawText ? label ?? "" : "${initial ? "• " : "  "}${label ?? ""}",
          maxLines: 10,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontStyle: FontStyle.italic)),
    );
  }
}
