import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  /// Label to put on the button
  final String label;
  /// Color of the button. Defaults to green
  final Color color;
  /// Horizontal padding for the button. Defaults to 32.
  final double horizontal;
  /// Vertical padding for the button. Defaults to 8.
  final double vertical;
  final Function() onTap;
  const ActionButton({required this.label, this.color = Colors.green,
    this.horizontal = 32, this.vertical = 8, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(label, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
              ),
            )
          ),
        ),
      ),
    );
  }
}
