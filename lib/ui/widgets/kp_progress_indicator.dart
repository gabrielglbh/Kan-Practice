import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';

class KPProgressIndicator extends StatelessWidget {
  const KPProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(CustomColors.secondaryColor),
    ));
  }
}
