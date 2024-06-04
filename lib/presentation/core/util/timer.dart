import 'dart:async';

import 'package:flutter/material.dart';

mixin CustomPeriodicTimer<T extends StatefulWidget> on State<T> {
  Timer? _timer;
  int _elapsedTime = 0;

  int get elapsedTime => _elapsedTime;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _elapsedTime++);
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _elapsedTime = 0;
  }
}

extension Format on int {
  String format() {
    final duration = Duration(seconds: this);
    final minutes = duration.inMinutes;
    final seconds = this % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}
