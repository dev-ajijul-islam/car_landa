import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/cupertino.dart';

class AdvanceSearchProvider extends ChangeNotifier {
  bool isLoading = false;
  List<CarModel> searchedCars = [];

  String? brand;
  String? model;
  int? maxPrice;
  int? minPrice;
  int? minYear;
  int? maxYear;
  String? fuelType;
  String? location;

  Future<void> getCarsByFiltering({String? title}) async {
    isLoading = true;
    notifyListeners();

    try {
      // Clean URL calling with named parameters
      final String filterUrl = Urls.getCarsByFilter(
        model: model,
        brand: brand,
        location: location,
        minPrice: minPrice,
        maxPrice: maxPrice,
        maxYear: maxYear,
        minYear: minYear,
        fuelType: fuelType,
        title: title,
      );

      NetworkResponse response = await NetworkCaller.getRequest(
        url: filterUrl,
        token: AuthProvider.idToken,
      );
      if (response.success) {
        final List<dynamic>? list = response.body?["body"];
        if (list != null) {
          searchedCars = list.map((c) => CarModel.fromJson(c)).toList();
        } else {
          searchedCars = [];
        }
      } else {
        debugPrint("Server error: ${response.message}");
      }
    } catch (e) {
      debugPrint("getting car failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
