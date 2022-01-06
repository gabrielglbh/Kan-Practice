import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class KanjiSearchBar extends StatelessWidget {
  /// Hint text to show on the search bar when not used
  final String hint;
  /// Padding to apply to the search bar, defaults to 8
  final double top, bottom, right, left;
  /// Controller for the text field
  final TextEditingController? controller;
  final Function() onClear;
  final Function() onRemoveLast;
  KanjiSearchBar({
    required this.hint,
    required this.controller,
    required this.onClear,
    required this.onRemoveLast,
    this.top = Margins.margin8,
    this.bottom = 0,
    this.left = Margins.margin8,
    this.right = Margins.margin8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
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
        controller: controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: Margins.margin24, bottom: Margins.margin16,
            left: Margins.margin16, right: Margins.margin64 + Margins.margin18
          ),
          hintText: hint,
          filled: false
        ),
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
    ]);
  }

  Container _removeLast() {
    return Container(
      width: CustomSizes.defaultSizeSearchBarIcons,
      height: CustomSizes.defaultSizeSearchBarIcons,
      child: InkWell(
        borderRadius: BorderRadius.circular(CustomRadius.radius32),
        onTap: () => onRemoveLast(),
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
        onTap: () => onClear(),
        child: Icon(Icons.clear),
      )
    );
  }
}