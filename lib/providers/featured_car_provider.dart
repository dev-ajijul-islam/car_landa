import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class FeaturedCarProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  List<CarModel> featuredCars = [];

  Future<void> getFeaturedCar() async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getFeaturedCar(10),
      );
      if (response.success) {
        List<Map<String, dynamic>> list =
            response.body as List<Map<String, dynamic>>;
        featuredCars = list.map((c) => CarModel.fromJson(c)).toList();
      }
    } catch (e) {
      errorMessage = e.toString();
      debugPrint(e.toString());
      notifyListeners();
    }
  }
}
