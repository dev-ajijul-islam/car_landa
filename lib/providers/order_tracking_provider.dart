import 'package:car_hub/data/model/tracking_status_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class OrderTrackingProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;


  List<TrackingStatusModel> trackingTimeline = [];


  String? currentOrderId;

  Future<void> getTrackingProgress(String orderIdOrCode) async {
    isLoading = true;
    errorMessage = null;
    trackingTimeline.clear();
    notifyListeners();

    try {

      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getTrackingStatus(orderIdOrCode),
        token: AuthProvider.idToken,
      );

      if (response.success) {
        currentOrderId = orderIdOrCode;


        if (response.body?["body"] != null && response.body!["body"]["statusList"] is List) {
          List<dynamic> list = response.body!["body"]["statusList"];

          for (var item in list) {
            if (item is Map<String, dynamic>) {
              trackingTimeline.add(TrackingStatusModel.fromJson(item));
            }
          }
        }
      } else {
        errorMessage = response.body?["message"] ?? "Invalid tracking code";
      }
    } catch (e) {
      errorMessage = "An error occurred: ${e.toString()}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}