import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  /// Message to show when a list is empty on the center of the screen
  final String message;
  const EmptyList({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
