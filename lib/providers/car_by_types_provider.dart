import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/cupertino.dart';

class CarByTypesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<CarModel> cars = [];

  Future<void> getcarsByType(String carTypeId) async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCarByTypeId(carTypeId),
        token: AuthProvider.idToken
      );
      if(response.success){
        cars.clear();
        List <dynamic> list = response.body!["body"];
        cars = list.map((c) => CarModel.fromJson(c),).toList();

        notifyListeners();
      }
    } catch (e) {
      debugPrint("car loading by type failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
