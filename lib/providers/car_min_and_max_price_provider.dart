import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class CarMinAndMaxPriceProvider extends ChangeNotifier {
  bool isLoading = false;
  Map<String, dynamic> minAndMaxPrice = {};

  Future<void> getMinAndMaxPrice({String? brand}) async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getMinAdMaxPrice,
      );
      if (response.success) {
        minAndMaxPrice.clear();
        Map<dynamic, dynamic> obj = response.body!["body"];
        minAndMaxPrice = obj as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint("car max and min price loading failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
