import 'package:flutter/material.dart';

class KPProgressIndicator extends StatelessWidget {
  const KPProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
    ));
  }
}
