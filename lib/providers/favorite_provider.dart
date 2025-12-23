import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  bool isLoading = false;
  List<CarModel> favoriteCars = [];

  //=================================== create favorite ==============================

  Future<NetworkResponse> createFavorite({required String carId}) async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createFavorite,
        body: {"carId": carId},
        token: AuthProvider.idToken,
      );
      print(AuthProvider.idToken);
      if (response.success) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        success: false,
        message: "create favorite failed $e",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  ///=================================get all favorite ==================================
  Future<void> getFavoriteCars() async {
    isLoading = true;
    notifyListeners();

    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getFavoriteCars,
        token: AuthProvider.idToken
      );
      if (response.success) {
        favoriteCars.clear();
        List<dynamic> list = response.body!["body"];
        favoriteCars = list.map((c) => CarModel.fromJson(c)).toList();
      } else {
        debugPrint("loading favorite car failed ${response.message}");
      }
    } catch (e) {
      debugPrint("loading favorite car failed $e");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }
}
