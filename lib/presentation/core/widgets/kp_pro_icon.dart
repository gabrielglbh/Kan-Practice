import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPProIcon extends StatelessWidget {
  final Color? color;
  const KPProIcon({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.local_play_rounded,
      color: color ?? KPColors.getSecondaryColor(context),
    );
  }
}
