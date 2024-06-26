import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPButton extends StatelessWidget {
  /// Width of the button
  final bool width;

  /// Color of the button
  final Color? color;

  /// First title of the button, usually the JP part
  final String? title1;

  /// Icon of the button
  final IconData? icon;

  /// Second title of the button, located below the [title1], usually native part
  final String title2;

  /// Action to perform when tapping the button
  final Function()? onTap;
  final Widget? customIcon;
  final Color? textColor;
  const KPButton({
    super.key,
    this.width = false,
    this.color,
    this.title1,
    required this.title2,
    required this.onTap,
    this.icon,
    this.customIcon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != false ? KPSizes.customButtonWidth : null,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(KPMargins.margin8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KPRadius.radius16),
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(KPRadius.radius16),
          child: Container(
            width: width != false ? KPSizes.customButtonWidth : null,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(KPMargins.margin8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(KPRadius.radius16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: title1 != null,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: KPMargins.margin8),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(title1 ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: textColor ??
                                      Theme.of(context).colorScheme.onPrimary)),
                    ),
                  ),
                ),
                Visibility(
                  visible: title1 == null && icon != null,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: KPMargins.margin8),
                      child: Icon(icon,
                          color: textColor ??
                              Theme.of(context).colorScheme.onPrimary)),
                ),
                Visibility(
                  visible: title1 == null && icon == null && customIcon != null,
                  child: customIcon ?? const SizedBox(),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(title2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: textColor ??
                              Theme.of(context).colorScheme.onPrimary)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
