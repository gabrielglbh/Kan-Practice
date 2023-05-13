import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPTappableInfo extends StatelessWidget {
  final String text;
  const KPTappableInfo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: KPMargins.margin16,
        right: KPMargins.margin16,
        bottom: KPMargins.margin8,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: KPMargins.margin8),
            child: Icon(Icons.info_rounded, size: 16, color: Colors.grey),
          ),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
