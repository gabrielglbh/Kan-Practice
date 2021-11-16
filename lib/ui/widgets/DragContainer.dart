import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class DragContainer extends StatelessWidget {
  const DragContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: CustomSizes.defaultSizeDragContainerWidth, height: CustomSizes.defaultSizeDragContainerHeight,
        margin: EdgeInsets.symmetric(vertical: Margins.margin8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomRadius.radius16),
            color: Colors.grey
        ),
      ),
    );
  }
}
