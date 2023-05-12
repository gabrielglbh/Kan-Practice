import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ZoomSlider extends StatefulWidget {
  final double zoom;
  final Function(double) onChanged;
  const ZoomSlider({super.key, required this.zoom, required this.onChanged});

  @override
  State<ZoomSlider> createState() => _ZoomSliderState();
}

class _ZoomSliderState extends State<ZoomSlider> {
  final _maxZoom = 5.0;
  final _minZoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BulletContainer(text: '-'),
        Expanded(
          child: Slider(
            value: widget.zoom,
            onChanged: widget.onChanged,
            max: _maxZoom,
            min: _minZoom,
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
