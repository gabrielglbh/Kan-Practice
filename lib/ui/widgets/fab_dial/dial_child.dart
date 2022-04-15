part of 'dial.dart';

class DialChild {
  const DialChild({
    required this.child,
    required this.onPressed
  });

  /// A widget to display as the [DialChild].
  final Widget child;

  /// A callback to be executed when the [DialChild] is pressed.
  final Function onPressed;
}