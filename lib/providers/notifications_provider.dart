import 'package:car_hub/data/model/notification_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class NotificationsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<NotificationModel> notifications = [];

  Future<void> createNotification({required NotificationModel notification}) async {
    isLoading = true;
    notifyListeners();
    try {
      final NetworkResponse response = await NetworkCaller.postRequest(
        body: notification.toJson(),
        url: Urls.createNotifications,
        token: AuthProvider.idToken
      );

      if (response.success) {
        final list = response.body?["body"];

        for (var notification in list) {
          notifications.add(NotificationModel.fromJson(notification));
        }
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  Future<void> getNotifications() async {
    isLoading = true;
    notifyListeners();
    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getNotifications,
        token: AuthProvider.idToken
      );

      if (response.success) {
        notifications.clear();
        final list = response.body?["body"];

        for (var notification in list) {
          notifications.add(NotificationModel.fromJson(notification));
        }
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
