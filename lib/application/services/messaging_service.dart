import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/messaging/i_messaging_repository.dart';

@injectable
class MessagingService {
  final IMessagingRepository _messagingRepository;

  MessagingService(this._messagingRepository);

  Future<void> handler(BuildContext context) async {
    await _messagingRepository.handler(context);
  }
}
