import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
class FcmService {
  static Future <void> initialized() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission(
      sound: true,
      provisional: true,
      providesAppNotificationSettings: true,
      criticalAlert: true,
      carPlay: true,
      badge: true,
      announcement: true,
      alert: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) => handler);

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => handler,
    );

    FirebaseMessaging.onBackgroundMessage((message) async => backgroundHandler);
  }

  //notification handler
  static void handler(RemoteMessage message) {
    debugPrint(message.notification?.title);
    debugPrint(message.notification?.body);
    debugPrint(message.data as String?);
  }
}
// background handler
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.notification?.title);
  debugPrint(message.notification?.body);
  debugPrint(message.data as String?);
}
