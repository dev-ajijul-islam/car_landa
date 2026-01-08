import 'package:car_hub/ui/screens/home/booking_cost_calculation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void deliveryDialog(BuildContext context) {
  String? deliveryOption = "Luanda";

  void onTapContinueButton(){
    Navigator.pushNamed(context, BookingCostCalculation.name);
  }

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            title: Text("car_details.delivery_options".tr()),
            content: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("car_details.delivered_to_luanda".tr()),
                      Radio(
                        value: "Luanda",
                        groupValue: deliveryOption,
                        onChanged: (value) {
                          setState(() {
                            deliveryOption = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("car_details.delivered_to_doorstep".tr()),
                      Radio(
                        value: "Doorstep",
                        groupValue: deliveryOption,
                        onChanged: (value) {
                          setState(() {
                            deliveryOption = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                FilledButton(
                    onPressed: onTapContinueButton,
                    child: Text("car_details.continue".tr())
                ),
              ],
            ),
          );
        },
      );
    },
  );
}