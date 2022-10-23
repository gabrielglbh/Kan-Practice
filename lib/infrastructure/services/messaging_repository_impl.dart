import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/messaging/i_messaging_repository.dart';
import 'package:kanpractice/presentation/home_page/widgets/daily_test_bottom_sheet.dart';

@LazySingleton(as: IMessagingRepository)
class MessagingRepositoryImpl implements IMessagingRepository {
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _messaging;

  MessagingRepositoryImpl(this._localNotifications, this._messaging);

  @override
  Future<void> handler(BuildContext context) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Same as in the Manifest
      'High Importance Notifications',
      importance: Importance.max,
    );

    // Create and register channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _messaging.getToken().then((String? token) {
      assert(token != null);
      print(token);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.data['test'] == 'daily') {
        await DailyBottomSheet.show(context);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
              ),
            ));
      }
    });
  }
}
