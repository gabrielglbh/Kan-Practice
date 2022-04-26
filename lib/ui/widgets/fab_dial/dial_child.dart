part of 'kp_dial.dart';

class DialChild {
  /// A widget to display as the [DialChild].
  final Widget child;

  /// A callback to be executed when the [DialChild] is pressed.
  final Function onPressed;

  /// Color of the dial
  final Color color;

  const DialChild({
    required this.child,
    required this.onPressed,
    this.color = CustomColors.secondaryDarkerColor
  });
}