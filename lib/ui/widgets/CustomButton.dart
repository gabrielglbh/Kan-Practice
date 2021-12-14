import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class CustomButton extends StatelessWidget {
  /// Width of the button
  final double width;
  /// Color of the button
  final Color color;
  /// First title of the button, usually the JP part
  final String title1;
  /// Second title of the button, located below the [title1], usually native part
  final String title2;
  /// Action to perform when tapping the button
  final Function onTap;
  const CustomButton({this.width = CustomSizes.customButtonWidth,
    this.color = CustomColors.secondaryColor,
    required this.title1, required this.title2, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: CustomSizes.defaultSizeButtonHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.all(Margins.margin8),
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
            width: width,
            height: CustomSizes.defaultSizeButtonHeight,
            alignment: Alignment.center,
            margin: EdgeInsets.all(Margins.margin8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomRadius.radius16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: Margins.margin8),
                  child: Text(title1, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: FontSizes.fontSize18, color: Colors.white)),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(title2, textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: FontSizes.fontSize16, fontWeight: FontWeight.bold, color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
