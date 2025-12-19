import 'package:car_hub/data/model/car_model.dart';
import 'package:flutter/material.dart';

class AdvanceSearchProvider extends ChangeNotifier {
  bool isLoading = false;
  List<CarModel> searchedCars = [];
  
}
