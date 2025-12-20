import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:flutter/cupertino.dart';

class CarMinAndMaxYearProvider extends ChangeNotifier {
  bool isLoading = false;
  Map<String, dynamic> minAndMaxYear = {};

  Future<void> getMinAndMaxYear({String? brand}) async {
    isLoading = true;
    notifyListeners();

    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getMinAndMaxYear,
      );
      if (response.success) {
        minAndMaxYear.clear();
        Map<dynamic, dynamic> obj = response.body!["body"];
        minAndMaxYear = obj as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint("car max and min year loading failed $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
