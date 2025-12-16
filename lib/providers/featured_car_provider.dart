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
    if (featuredCars.isNotEmpty || isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getFeaturedCar(10),
      );
      if (response.success) {
        featuredCars.clear();
        if (response.body?["body"] is List) {
          List<dynamic> list = response.body!["body"];
          for (var item in list) {
            if (item is Map<String, dynamic>) {
              featuredCars.add(CarModel.fromJson(item));
            }
          }
        }
      } else {
        errorMessage = "Failed to load featured cars";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}