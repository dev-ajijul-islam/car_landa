import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<NetworkResponse> createFavorite({required String carId}) async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createFavorite,
        body: {"carId": carId},
        token: AuthProvider.idToken
      );
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
}
