import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class TrackCarProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<OrderModel> userOrders = [];


  Future<void> getMyOrders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {

      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getMyOrders,
        token: AuthProvider.idToken,
      );

      if (response.success) {
        userOrders.clear();

        if (response.body?["body"] is List) {
          List<dynamic> list = response.body!["body"];
          for (var item in list) {
            if (item is Map<String, dynamic>) {
              userOrders.add(OrderModel.fromJson(item));
            }
          }
        }
      } else {
        errorMessage = response.body?["message"] ?? "Failed to load orders";
      }
    } catch (e) {
      errorMessage = "An error occurred: ${e.toString()}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}