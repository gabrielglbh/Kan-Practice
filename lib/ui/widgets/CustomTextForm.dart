import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class CustomTextForm extends StatelessWidget {
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
  final Function? onSubmitted;
  /// [TextInputType] of the Soft Keyboard, defaults to [TextInputType.text]
  final TextInputType? inputType;
  /// [TextInputAction] of the Soft Keyboard, defaults to [TextInputAction.next]
  final TextInputAction? action;
  /// Font size of the text being inputted by the user, defaults to 18
  final double? fontSize;
  /// [FontWeight] of the text of the [TextField]
  final FontWeight? bold;
  /// [TextAlign] to define the behaviour of the text
  final TextAlign centerText;
  /// Whether to autofocus the [TextField] or not
  final bool autofocus;
  /// Whether to obscure the [TextField] or not
  final bool obscure;
  const CustomTextForm({
    required this.header, required this.hint, required this.controller,
    required this.focusNode, required this.onEditingComplete, this.onSubmitted,
    this.inputType = TextInputType.text, this.action = TextInputAction.next,
    this.fontSize = FontSizes.fontSize18, this.bold, this.centerText = TextAlign.start,
    this.autofocus = false, this.obscure = false, this.additionalWidget
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Margins.margin16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(header, style: TextStyle(fontSize: FontSizes.fontSize18, fontWeight: FontWeight.bold)),
              additionalWidget ?? Container()
            ],
          ),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: centerText,
          style: TextStyle(fontWeight: bold, fontSize: fontSize),
          textInputAction: action,
          keyboardType: inputType,
          textCapitalization: TextCapitalization.sentences,
          autofocus: autofocus,
          obscureText: obscure,
          decoration: InputDecoration(hintText: hint),
          onEditingComplete: () => onEditingComplete(),
          onSubmitted: (kanji) { if (onSubmitted != null) onSubmitted!(); }
        ),
      ],
    );
  }
}
