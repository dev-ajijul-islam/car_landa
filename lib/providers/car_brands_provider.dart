import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/cupertino.dart';

class CarBrandsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<String> carBrands = [];

  Future<void> getAllCarBrands() async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarBrands,
      );
      if (response.success) {
        carBrands.clear();
        List<dynamic> list = response.body!["body"];
        carBrands = list.map((b) => b.toString()).toList();
      }
    } catch (e) {
      debugPrint("car brands loaded successfully $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
