import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class ScrollableText extends StatelessWidget {
  final String? label;
  /// Whether to parse the text for nullables or put it raw
  final bool rawText;
  /// Whether to put a bullet point on the beginning of the text or not
  final bool initial;
  /// Whether to use italic style on the text or not
  final bool italic;
  final double fontSize;
  final bool paddingTop;
  const ScrollableText({required this.label, this.initial = false,
    this.italic = true, this.paddingTop = false, this.rawText = false,
    this.fontSize = FontSizes.fontSize16
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingTop ? EdgeInsets.only(top: Margins.margin8) : EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      child: Text(rawText ? label ?? ""
          : "${initial ? "• " : "  "}${label != null ? label : ""}",
        maxLines: 10, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize, fontStyle: italic ? FontStyle.italic : null)
      ),
    );
  }
}
