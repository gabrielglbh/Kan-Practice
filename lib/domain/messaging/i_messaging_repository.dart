import 'package:flutter/material.dart';

abstract class IMessagingRepository {
  Future<void> handler(BuildContext context);
}
