import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';


class CreateOrderProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;
  OrderModel? createdOrder;

  Future<void> createOrder(OrderModel order) async {
    isLoading = true;
    isSuccess = false;
    errorMessage = null;
    createdOrder = null;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createOrder,
        token: AuthProvider.idToken,
        body: order.toJson(),
      );

      if (response.success) {
        isSuccess = true;
        if (response.body?["body"] != null) {
          createdOrder = OrderModel.fromJson(response.body!["body"]);
        }
      } else {
        errorMessage = response.body?["message"] ?? "Failed to create order";
      }
    } catch (e) {
      errorMessage = "An error occurred: ${e.toString()}";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetStatus() {
    isSuccess = false;
    errorMessage = null;
    createdOrder = null;
    notifyListeners();
  }
}