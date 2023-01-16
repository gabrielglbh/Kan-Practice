import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPDragContainer extends StatelessWidget {
  const KPDragContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: KPSizes.defaultSizeDragContainerWidth,
        height: KPSizes.defaultSizeDragContainerHeight,
        margin: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(KPRadius.radius16),
            color: Colors.grey),
      ),
    );
  }
}
