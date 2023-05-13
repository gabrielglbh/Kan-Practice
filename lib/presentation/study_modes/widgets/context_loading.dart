import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';

class ContextLoading extends StatelessWidget {
  const ContextLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: KPMargins.margin12),
      child: SizedBox(width: 24, height: 24, child: KPProgressIndicator()),
    );
  }
}
