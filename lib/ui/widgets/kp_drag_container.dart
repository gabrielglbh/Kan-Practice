import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class KPDragContainer extends StatelessWidget {
  const KPDragContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: CustomSizes.defaultSizeDragContainerWidth, height: CustomSizes.defaultSizeDragContainerHeight,
        margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomRadius.radius16),
            color: Colors.grey
        ),
      ),
    );
  }
}
