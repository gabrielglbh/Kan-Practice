import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KanjiSearchBar extends StatelessWidget {
  /// Hint text to show on the search bar when not used
  final String hint;

  /// Padding to apply to the search bar, defaults to 8
  final double top, bottom, right, left;

  /// Controller for the text field
  final TextEditingController? controller;
  final bool enabled;
  final Function() onClear;
  final Function() onRemoveLast;
  final void Function(String) onChange;
  const KanjiSearchBar({
    Key? key,
    required this.hint,
    required this.controller,
    required this.onClear,
    required this.onRemoveLast,
    required this.onChange,
    this.enabled = false,
    this.top = KPMargins.margin8,
    this.bottom = 0,
    this.left = KPMargins.margin8,
    this.right = KPMargins.margin8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: KPMargins.margin8),
          child: _searchBar(),
        )
      ]),
    );
  }

  Stack _searchBar() {
    return Stack(children: <Widget>[
      TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        enabled: enabled,
        onChanged: onChange,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
                top: KPMargins.margin24,
                bottom: KPMargins.margin16,
                left: KPMargins.margin16,
                right: KPMargins.margin64 + KPMargins.margin18),
            hintText: hint,
            filled: false),
      ),
      Positioned(
        bottom: KPMargins.margin4,
        right: KPMargins.margin32 + KPMargins.margin8,
        child: _removeLast(),
      ),
      Positioned(
        bottom: KPMargins.margin4,
        right: 0,
        child: _clear(),
      ),
    ]);
  }

  SizedBox _removeLast() {
    return SizedBox(
        width: KPSizes.defaultSizeSearchBarIcons,
        height: KPSizes.defaultSizeSearchBarIcons,
        child: InkWell(
          borderRadius: BorderRadius.circular(KPRadius.radius32),
          onTap: () => onRemoveLast(),
          child: const Icon(Icons.backspace_rounded),
        ));
  }

  SizedBox _clear() {
    return SizedBox(
        width: KPSizes.defaultSizeSearchBarIcons,
        height: KPSizes.defaultSizeSearchBarIcons,
        child: InkWell(
          borderRadius: BorderRadius.circular(KPRadius.radius32),
          onTap: () => onClear(),
          child: const Icon(Icons.clear),
        ));
  }
}
