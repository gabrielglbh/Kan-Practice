import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:markdown/markdown.dart' as md;

enum MarkdownType { body, normal }

class KPMarkdown extends StatelessWidget {
  final MarkdownType type;
  final String data;
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final bool shrinkWrap;
  KPMarkdown({
    super.key,
    required this.data,
    this.shrinkWrap = false,
    this.type = MarkdownType.normal,
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  });

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight,
        minWidth: minWidth,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      child: type == MarkdownType.body
          ? MarkdownBody(
              data: data,
              extensionSet: md.ExtensionSet.gitHubFlavored,
            )
          : Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: Markdown(
                data: data,
                padding: const EdgeInsets.symmetric(
                  vertical: KPMargins.margin8,
                  horizontal: KPMargins.margin16,
                ),
                extensionSet: md.ExtensionSet.gitHubFlavored,
                shrinkWrap: shrinkWrap,
                controller: _scrollController,
              ),
            ),
    );
  }
}
