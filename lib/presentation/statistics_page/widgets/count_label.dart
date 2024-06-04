import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class CountLabel extends StatelessWidget {
  final String count;
  const CountLabel({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          count,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
