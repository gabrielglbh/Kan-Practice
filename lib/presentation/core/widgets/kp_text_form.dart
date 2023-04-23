import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

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

  /// Text Style of the input. Defaults to headlineSmall
  final TextStyle? style;

  /// Whehter the input is enabled or not
  final bool enabled;

  /// Whehter the text form field is horizontal or not
  final bool isHorizontalForm;

  final TextStyle? headerTextStyle;
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
    this.style,
    this.enabled = true,
    this.isHorizontalForm = false,
    this.headerTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(header,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    headerTextStyle ?? Theme.of(context).textTheme.titleLarge)),
        additionalWidget ?? Container()
      ],
    );
    if (isHorizontalForm) {
      return SizedBox(
        height: KPMargins.margin64,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: KPMargins.margin16),
                child: headerWidget,
              ),
            ),
            Flexible(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                textAlign: centerText,
                style: style ?? Theme.of(context).textTheme.bodyLarge,
                textInputAction: action,
                keyboardType: inputType,
                maxLength: maxLength,
                maxLines: obscure ? 1 : maxLines,
                textCapitalization: TextCapitalization.sentences,
                autofocus: autofocus,
                obscureText: obscure,
                decoration: InputDecoration(hintText: hint),
                enabled: enabled,
                onEditingComplete: () => onEditingComplete(),
                onSubmitted: (word) {
                  if (onSubmitted != null) onSubmitted!(word);
                },
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: KPMargins.margin16,
              right: KPMargins.margin8,
              left: KPMargins.margin8),
          child: headerWidget,
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: centerText,
          style: style ?? Theme.of(context).textTheme.bodyLarge,
          textInputAction: action,
          keyboardType: inputType,
          maxLength: maxLength,
          maxLines: obscure ? 1 : maxLines,
          textCapitalization: TextCapitalization.sentences,
          autofocus: autofocus,
          obscureText: obscure,
          decoration: InputDecoration(hintText: hint),
          enabled: enabled,
          onEditingComplete: () => onEditingComplete(),
          onSubmitted: (word) {
            if (onSubmitted != null) onSubmitted!(word);
          },
        ),
      ],
    );
  }
}
