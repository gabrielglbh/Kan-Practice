import 'package:flutter/material.dart';

class GrammarListWidget extends StatefulWidget {
  const GrammarListWidget({super.key});

  @override
  State<GrammarListWidget> createState() => _GrammarListWidgetState();
}

class _GrammarListWidgetState extends State<GrammarListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
