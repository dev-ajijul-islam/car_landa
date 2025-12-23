import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class SingleCarProvider extends ChangeNotifier {
  CarModel? car;
  bool loading = false;
  String? errorMessage;

  Future<void> getCarById(String id) async {
    loading = true;
    errorMessage = null;
    car = null;
    notifyListeners();

    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.carById(id),
        token: AuthProvider.idToken
      );
      if (response.success) {
        car = CarModel.fromJson(response.body?["body"]);
      } else {
        errorMessage = "Car not found";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
