import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class ViewCarsProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  List<CarModel> cars = [];
  List<CarModel> allCars = [];

  //=============================== get all cars=====================================

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
        allCars = list.map((c) {
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

  //==================================search by title===============================
  Future<void> getcarByTitle({required String title}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      cars = allCars
          .where((car) => car.title.toLowerCase().contains(title.toLowerCase()))
          .toList();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //================================reset searches ====================================
  void resetSearch() {
    isLoading = true;
    notifyListeners();
    cars = allCars;
    isLoading = false;
    notifyListeners();
  }

  //================================sort cars ====================================
  void sortCars(String? criteria) {
    if (criteria == "year-lowest-to-highest") {
      cars.sort((a, b) => a.year.compareTo(b.year));
    } else if (criteria == "year-highest-to-lowest") {
      cars.sort((a, b) => b.year.compareTo(a.year));
    } else if (criteria == "price-highest-to-lowest") {
      cars.sort(
        (a, b) => b.pricing.sellingPrice.compareTo(a.pricing.sellingPrice),
      );
    } else if (criteria == "price-lowest-to-highest") {
      cars.sort(
        (a, b) => a.pricing.sellingPrice.compareTo(b.pricing.sellingPrice),
      );
    }

    notifyListeners();
  }
}
