import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';

class KPButton extends StatelessWidget {
  /// Width of the button
  final bool width;

  /// Color of the button
  final Color color;

  /// First title of the button, usually the JP part
  final String? title1;

  /// Icon of the button
  final IconData? icon;

  /// Second title of the button, located below the [title1], usually native part
  final String title2;

  /// Action to perform when tapping the button
  final Function onTap;
  const KPButton(
      {Key? key,
      this.width = false,
      this.color = CustomColors.secondaryColor,
      this.title1,
      required this.title2,
      required this.onTap,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != false ? CustomSizes.customButtonWidth : null,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(Margins.margin8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomRadius.radius16),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(CustomRadius.radius16),
          child: Container(
            width: width != false ? CustomSizes.customButtonWidth : null,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(Margins.margin8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomRadius.radius16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: title1 != null,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: Margins.margin8),
                    child: Text(title1 ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.w400, color: Colors.white)),
                  ),
                ),
                Visibility(
                  visible: title1 == null && icon != null,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: Margins.margin8),
                      child: Icon(icon, color: Colors.white)),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(title2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
