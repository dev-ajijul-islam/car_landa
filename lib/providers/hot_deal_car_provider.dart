import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class HotDealCarProvider extends ChangeNotifier {
  List<CarModel> hotDealCars = [];
  bool isLoading = false;

  Future<void> getHotDealCar() async {
    if(hotDealCars.isNotEmpty || isLoading) return;

    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getHotDealCar,
      );
      if(response.success){
        hotDealCars.clear();

        if(response.body!["body"] is List){
          List <dynamic> list = response.body!["body"];
          hotDealCars = list.map((c){
            return CarModel.fromJson(c);
          }).toList();
        }
      }
    } catch (e) {
      debugPrint("hot deal car loding failed $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}
