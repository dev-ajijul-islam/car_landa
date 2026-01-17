import 'package:car_hub/data/model/notification_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FcmService {
  static Future<void> initialized() async {
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

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => handler(message),
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => handler(message),
    );

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  //notification handler
  static void handler(RemoteMessage message) {
    debugPrint(message.notification?.title);
    debugPrint(message.notification?.body);
    createNotification(message);
  }
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await createNotification(message);
}

Future<void> createNotification(RemoteMessage message) async {
  final NotificationModel notification = NotificationModel(
    body: message.notification!.title.toString(),
    title: message.notification!.body.toString(),
    userId: FirebaseAuth.instance.currentUser!.uid,
  );
  try {
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createNotifications,
      body: notification.toJson(),
      token: await FirebaseAuth.instance.currentUser?.getIdToken(),
    );
    if (response.success) {
      debugPrint("Notification created successfully");
    } else {
      debugPrint(response.message.toString());
    }
  } catch (e) {
    debugPrint("Notification create failed");
  }
}
