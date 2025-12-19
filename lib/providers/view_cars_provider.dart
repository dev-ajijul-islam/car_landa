import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class ViewCarsProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<CarModel> cars = [];

  // get all cars

  Future<void> getAllCars() async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getAllCars,
      );
      if (response.success) {
        cars.clear();
        errorMessage = null;

        List<dynamic> list = response.body!["body"];

        cars = list.map((c) {
          return CarModel.fromJson(c);
        }).toList();
        notifyListeners();
      } else {
        errorMessage = response.message;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("cars loading failed");
    } finally {
      isLoading = false;
    }
  }

  //search by title

  Future<void> getcarByTitle({required String title}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarByTitle(title),
      );
      if (response.success) {
        cars.clear();
        errorMessage = null;

        List<dynamic> list = response.body!["body"];
        cars = list.map((c) => CarModel.fromJson(c)).toList();
        notifyListeners();
      } else {
        errorMessage = response.message;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
