import 'package:car_hub/ui/screens/home/delivery_info_screen.dart';
import 'package:car_hub/ui/screens/track_car/track_car.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
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
  String? paymentMethod = "ssl-commerz";
  late Map<String, dynamic> allOrderData;

  @override
  void didChangeDependencies() {
    allOrderData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Option",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
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
                              paymentMethod = value.toString();
                            });
                          },
                        ),
                        const Text("Pay with SSLCommerz"),
                      ],
                    ),
                    Image.asset(width: 60, AssetsFilePaths.creditCard),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.food_bank_outlined,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                "Bank Details for Payment",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          _buildRichText("Name : ", "LISTAUTO ANGOLA COMERCIO"),
                          _buildRichText("Bank Account : ", "13439833710001"),
                          _buildRichText("Bank Name : ", "MILLENIUM ATLÂNTICO"),
                          _buildRichText(
                            "iban : ",
                            "0055 0000 3439 8337 1015 4",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _onTapPayButton,
                      child: const Text("Pay Now"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _onTapPayButton() {
    commonDialog(
      context,
      title: "Payment Successful",
      subtitle:
          "Payment confirmed! We’ve started processing your car delivery.",
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(
        context,
        TrackingProgress.name,
        arguments: {...allOrderData, 'paymentMethod': paymentMethod},
      );
    });
  }
}
