import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';

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
  const CustomButton({this.width = customButtonWidth, this.color = secondaryColor,
    required this.title1, required this.title2, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: customButtonHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: width,
            height: customButtonHeight,
            alignment: Alignment.center,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(title1, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                Text(title2, textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
