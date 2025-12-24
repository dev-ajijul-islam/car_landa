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
      if (response.success) {
        // নোট: এখানে clear না করে সরাসরি list fetch করা ভালো অথবা
        // ঐ নির্দিষ্ট আইটেমের isFavorite প্রপার্টি লোকালি আপডেট করা।
        return response;
      }
      return response;
    } catch (e) {
      return NetworkResponse(statusCode: -1, success: false, message: "failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //================================= get all favorite ==================================
  Future<void> getFavoriteCars() async {
    isLoading = true;
    notifyListeners();
    try {
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getFavoriteCars,
        token: AuthProvider.idToken,
      );
      if (response.success) {
        List<dynamic> list = response.body!["body"];
        favoriteCars = list.map((c) => CarModel.fromJson(c)).toList();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //=================================== delete favorite ==============================
  Future<NetworkResponse> deleteFavorite({required String carId}) async {
    isLoading = true;
    notifyListeners();
    try {
      NetworkResponse response = await NetworkCaller.deleteRequest(
        url: Urls.deleteFavoriteCar(carId),
        token: AuthProvider.idToken,
      );
      if (response.success) {
        // 🔥 এই লাইনটিই ফেভারিট স্ক্রিন থেকে কার্ডটি সাথে সাথে সরিয়ে দিবে
        favoriteCars.removeWhere((element) => element.sId == carId);
        return response;
      }
      return response;
    } catch (e) {
      return NetworkResponse(statusCode: -1, success: false, message: "failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}