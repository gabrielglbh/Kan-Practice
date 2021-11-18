import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(CustomColors.secondaryColor),
    ));
  }
}
