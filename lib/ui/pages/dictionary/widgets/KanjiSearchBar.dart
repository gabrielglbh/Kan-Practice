import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class KanjiSearchBar extends StatefulWidget {
  /// Hint text to show on the search bar when not used
  final String hint;
  /// Padding to apply to the search bar, defaults to 8
  final double top, bottom, right, left;
  /// Controller for the text field
  final TextEditingController? controller;
  KanjiSearchBar({
    required this.hint,
    required this.controller,
    this.top = Margins.margin8,
    this.bottom = 0,
    this.left = Margins.margin8,
    this.right = Margins.margin8,
  });

  @override
  _KanjiSearchBarState createState() => _KanjiSearchBarState();
}

class _KanjiSearchBarState extends State<KanjiSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.left, right: widget.right,
          top: widget.top, bottom: widget.bottom
        ),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: Margins.margin8),
            child: _searchBar()
          )
        ])
      )
    );
  }

  Stack _searchBar() {
    return Stack(children: <Widget>[
      TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: Margins.margin24, bottom: Margins.margin16,
            left: Margins.margin48, right: Margins.margin64 + Margins.margin18
          ),
          hintText: widget.hint,
          filled: false
        ),
      ),
      Positioned(
        bottom: Margins.margin4,
        left: 0,
        child: _search()
      ),
      Positioned(
        bottom: Margins.margin4,
        right: Margins.margin32 + Margins.margin8,
        child: _removeLast(),
      ),
      Positioned(
        bottom: Margins.margin4,
        right: 0,
        child: _clear(),
      ),
    ],
    );
  }

  Container _search() {
    return Container(
      width: CustomSizes.defaultSizeSearchBarIcons,
      height: CustomSizes.defaultSizeSearchBarIcons,
      child: Icon(Icons.search)
    );
  }

  Container _removeLast() {
    return Container(
      width: CustomSizes.defaultSizeSearchBarIcons,
      height: CustomSizes.defaultSizeSearchBarIcons,
      child: InkWell(
        borderRadius: BorderRadius.circular(CustomRadius.radius32),
        onTap: () {
          String? text = widget.controller?.text;
          if (text != null)
            widget.controller?.text = text.substring(0, text.length - 1);
        },
        child: Icon(Icons.backspace_rounded),
      )
    );
  }

  Container _clear() {
    return Container(
      width: CustomSizes.defaultSizeSearchBarIcons,
      height: CustomSizes.defaultSizeSearchBarIcons,
      child: InkWell(
        borderRadius: BorderRadius.circular(CustomRadius.radius32),
        onTap: () => widget.controller?.clear(),
        child: Icon(Icons.clear),
      )
    );
  }
}