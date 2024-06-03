import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class ExpandedElapsedTimeTile extends StatelessWidget {
  final String mode;
  final String elapsedTime;
  const ExpandedElapsedTimeTile({
    super.key,
    required this.mode,
    required this.elapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KPMargins.margin24,
      padding: const EdgeInsets.only(
        left: KPMargins.margin8,
        right: KPMargins.margin16,
        bottom: KPMargins.margin8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              " • ${mode.capitalized}:",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  elapsedTime.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
