import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPActionButton extends StatelessWidget {
  /// Label to put on the button
  final String label;

  /// Color of the button. Defaults to green
  final Color color;

  /// Color of the label button. Defaults to green
  final Color textColor;

  /// Horizontal padding for the button. Defaults to 32.
  final double horizontal;

  /// Vertical padding for the button. Defaults to 8.
  final double vertical;
  final Function() onTap;
  const KPActionButton(
      {super.key,
      required this.label,
      this.color = Colors.green,
      this.textColor = Colors.white,
      this.horizontal = KPMargins.margin32,
      this.vertical = KPMargins.margin8,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KPSizes.defaultSizeActionButton,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KPRadius.radius16),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(KPRadius.radius16),
          child: Container(
            height: KPSizes.defaultSizeActionButton,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(KPMargins.margin8),
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
