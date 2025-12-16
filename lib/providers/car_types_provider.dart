import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class CarTypesProvider extends ChangeNotifier {
  List<String> carTypes = [];
  bool isLoading = false;

  Future<void> getCarTypes() async {
    if (carTypes.isNotEmpty || isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarTypes,
      );
      if (response.success) {
        carTypes.clear();
        List<dynamic> list = response.body!["body"];
        carTypes = list.map((t) {
          return t.toString();
        }).toList();
      }
    } catch (e) {
      debugPrint("car types loading failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
