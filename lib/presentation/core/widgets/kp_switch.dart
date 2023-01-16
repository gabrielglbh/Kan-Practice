import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

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
      activeColor: KPColors.secondaryDarkerColor,
      activeTrackColor: KPColors.secondaryColor,
      inactiveThumbColor: Brightness.light == Theme.of(context).brightness
          ? KPColors.subtleLight
          : KPColors.primaryLight,
      inactiveTrackColor: Colors.grey,
      onChanged: onChanged,
      value: value,
    );
  }
}
