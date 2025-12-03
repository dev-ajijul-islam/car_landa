import 'package:car_hub/ui/screens/delivery_info_screen.dart';
import 'package:car_hub/ui/widgets/common_dialog.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static String name = "payment-screen";

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment Option", style: TextTheme.of(context).titleMedium),
            SizedBox(height: 10),
            Card(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: "ssl-commerz",
                          groupValue: paymentMethod,
                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value;
                            });
                          },
                        ),
                        Text("Pay with Credit or Debit card"),
                      ],
                    ),
                    Image.asset(width: 70, AssetsFilePaths.creditCard),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.food_bank_outlined,
                                size: 40,
                                color: ColorScheme.of(context).primary,
                              ),
                              Text(
                                "Bank Details for Payment",
                                style: TextTheme.of(context).titleMedium,
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Name : ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(
                                  text: "LISTAUTO ANGOLA COMERCIO",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Bank Account : ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(
                                  text: "13439833710001",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Bank Name : ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(
                                  text: "MILLENIUM ATLÂNTICO",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "iban : ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(
                                  text: "0055 0000 3439 8337 1015 4",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FilledButton(onPressed: _onTapPayButton, child: Text("Pay")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTapPayButton() {
    commonDialog(
      context,
      title: "Payment Successful",
      subtitle:
          "Payment confirmed! We’ve started processing your car delivery.",
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamed(context, DeliveryInfoScreen.name);
    });
  }
}
