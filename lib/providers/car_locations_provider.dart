import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class CarLocationsProvider extends ChangeNotifier {
  List<String> carLocations = [];
  bool isLoading = false;

  Future<void> getcarLocations({
    String? brand,
    String? model,
    String? fuelType,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarLocations(brand, fuelType, model),
      );

      print(
        "------------------------------------------------------${brand.toString() + " " + model.toString() + " " + fuelType.toString()}",
      );
      print(
        "---------------------------------------------------------${response.body}",
      );
      if (response.success) {
        carLocations.clear();
        List<dynamic> list = response.body!["body"];
        carLocations = list.map((c) => c.toString()).toList();
      }
    } catch (e) {
      debugPrint("car Locations failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
