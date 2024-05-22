import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPSnackbar extends StatelessWidget {
  final String message;
  const KPSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(KPMargins.margin8),
      margin: const EdgeInsets.all(KPMargins.margin12),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(right: KPMargins.margin8),
          child: Icon(Icons.info_rounded,
              color: Theme.of(context).colorScheme.surface),
        ),
        Expanded(
            child: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.surface),
        )),
      ]),
    );
  }
}
