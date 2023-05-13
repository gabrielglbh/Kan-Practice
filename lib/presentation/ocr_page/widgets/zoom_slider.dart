import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ZoomSlider extends StatelessWidget {
  final double zoom, max, min;
  final Function(double) onChanged;
  const ZoomSlider({
    super.key,
    required this.zoom,
    required this.onChanged,
    required this.max,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BulletContainer(text: '-'),
        Expanded(
          child: Slider(
            value: zoom,
            onChanged: onChanged,
            max: max,
            min: min,
          ),
        ),
        const BulletContainer(text: '+'),
      ],
    );
  }
}

class BulletContainer extends StatelessWidget {
  final String text;
  const BulletContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: KPMargins.margin32,
      height: KPMargins.margin32,
      decoration: BoxDecoration(
        color: KPColors.midGrey,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
