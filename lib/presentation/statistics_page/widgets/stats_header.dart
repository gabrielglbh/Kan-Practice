import 'package:flutter/material.dart';

class StatsHeader extends StatelessWidget {
  final MainAxisAlignment? align;
  final String title;
  final String? value;
  final String? secondaryValue;
  final double verticalVisualDensity;
  const StatsHeader({
    super.key,
    required this.title,
    this.value,
    this.secondaryValue,
    this.align,
    this.verticalVisualDensity = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(vertical: verticalVisualDensity),
      title: Row(
        mainAxisAlignment: align ?? MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          if (value != null)
            Text("  •  ", style: Theme.of(context).textTheme.titleLarge),
          if (value != null)
            Text(value!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.normal)),
          if (secondaryValue != null)
            Text("  •  ", style: Theme.of(context).textTheme.titleLarge),
          if (secondaryValue != null)
            Text(secondaryValue!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.normal))
        ],
      ),
    );
  }
}
