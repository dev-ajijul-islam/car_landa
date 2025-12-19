import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class CarModelsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<String> carModels = [];

  Future<void> getAllCarModels({String? brand}) async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarModels(brand),
      );
      if (response.success) {
        carModels.clear();
        List<dynamic> list = response.body!["body"];
        carModels = list.map((c) => c.toString()).toList();
      }
    } catch (e) {
      debugPrint("car models loading failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
