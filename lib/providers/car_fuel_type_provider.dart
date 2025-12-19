import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class CarFuelTypeProvider extends ChangeNotifier {
  List<String> carFuelTypes = [];
  bool isLoading = false;

  Future<void> getCarFuelTypes({String? brand, String? model}) async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarFuelTypes(brand, model),
      );
      if (response.success) {
        carFuelTypes.clear();
        List<dynamic> list = response.body!["body"];
        carFuelTypes = list.map((c) => c.toString()).toList();
      }
    } catch (e) {
      debugPrint("car fuel type failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
