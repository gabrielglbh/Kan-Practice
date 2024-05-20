import 'package:flutter/material.dart';

class KPSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const KPSwitch({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: onChanged,
      value: value,
    );
  }
}
