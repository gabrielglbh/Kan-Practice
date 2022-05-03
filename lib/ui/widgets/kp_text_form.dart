import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';

class KPTextForm extends StatelessWidget {
  /// Header text to show above the [TextField]
  final String header;
  /// Additional action along the header for a certain Input Field
  final Widget? additionalWidget;
  /// Hint text to show on the [TextField] when it is not used
  final String hint;
  /// [TextEditingController] for handling the [TextField] input
  final TextEditingController? controller;
  /// [FocusNode] for the [TextField]
  final FocusNode? focusNode;
  /// Action to perform when the user taps on the Input Action on the Soft Keyboard
  final Function onEditingComplete;
  /// Action to perform when the user taps on the Input Action NEXT or PREVIOUS on the Soft Keyboard
  final Function(String)? onSubmitted;
  /// [TextInputType] of the Soft Keyboard, defaults to [TextInputType.text]
  final TextInputType? inputType;
  /// [TextInputAction] of the Soft Keyboard, defaults to [TextInputAction.next]
  final TextInputAction? action;
  /// [TextAlign] to define the behaviour of the text
  final TextAlign centerText;
  /// Whether to autofocus the [TextField] or not
  final bool autofocus;
  /// Whether to obscure the [TextField] or not
  final bool obscure;
  /// Max length of this. Defaults to null
  final int? maxLength;
  /// Max lines of this. Defaults to null
  final int? maxLines;
  /// Text Style of the input. Defaults to headline5
  final TextStyle? style;
  const KPTextForm({
    Key? key,
    required this.header,
    required this.hint,
    required this.controller,
    required this.focusNode,
    required this.onEditingComplete,
    this.onSubmitted,
    this.inputType = TextInputType.text,
    this.action = TextInputAction.next,
    this.centerText = TextAlign.start,
    this.autofocus = false,
    this.obscure = false,
    this.additionalWidget,
    this.maxLength,
    this.maxLines,
    this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Margins.margin16, right: Margins.margin8, left: Margins.margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(header, overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6
              )),
              additionalWidget ?? Container()
            ],
          ),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: centerText,
          style: style ?? Theme.of(context).textTheme.bodyText1,
          textInputAction: action,
          keyboardType: inputType,
          maxLength: maxLength,
          maxLines: obscure ? 1 : maxLines,
          textCapitalization: TextCapitalization.sentences,
          autofocus: autofocus,
          obscureText: obscure,
          decoration: InputDecoration(hintText: hint),
          onEditingComplete: () => onEditingComplete(),
          onSubmitted: (kanji) { if (onSubmitted != null) onSubmitted!(kanji); }
        ),
      ],
    );
  }
}
