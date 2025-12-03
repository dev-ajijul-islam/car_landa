import 'package:car_hub/ui/screens/home/booking_cost_calculation.dart';
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
            title: Text("Delivery Options"),
            content: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: BoxBorder.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivered to Port of Luanda"),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: BoxBorder.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivered to My Doorstep"),
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

                SizedBox(height: 10),
                FilledButton(onPressed:onTapContinueButton, child: Text("Continue")),
              ],
            ),
          );
        },
      );
    },
  );

}
