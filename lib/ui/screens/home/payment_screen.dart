import 'package:car_hub/providers/payment_provider.dart';
import 'package:car_hub/ui/screens/home/delivery_info_screen.dart';
import 'package:car_hub/ui/screens/track_car/track_car.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:car_hub/ui/widgets/common_dialog.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    allOrderData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
                                Icons.payment,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                "Payment Information",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          _buildRichText("Selected Method : ", "SSLCommerz Online Payment"),
                          _buildRichText("Order Amount : ", "\$${allOrderData['totalPrice']}"),
                          _buildRichText("Order ID : ", "#${allOrderData['order']?.sId?.substring(0, 8) ?? 'N/A'}"),
                          _buildRichText(
                            "Note : ",
                            "Complete payment to proceed with car delivery",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<PaymentProvider>(
                    builder: (context, paymentProvider, child) {
                      if (paymentProvider.isLoading) {
                        return SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                                const SizedBox(width: 10),
                                const Text("Processing..."),
                              ],
                            ),
                          ),
                        );
                      }

                      if (paymentProvider.status == PaymentStatus.success) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(
                            context,
                            TrackingProgress.name,
                            arguments: allOrderData['order']?.sId,
                          );
                          paymentProvider.reset();
                        });

                        return SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: null,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, size: 20),
                                SizedBox(width: 10),
                                Text("Payment Successful"),
                              ],
                            ),
                          ),
                        );
                      }

                      if (paymentProvider.status == PaymentStatus.failed) {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () => _processPayment(paymentProvider),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text("Try Again"),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (paymentProvider.errorMessage != null)
                              Text(
                                paymentProvider.errorMessage!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        );
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => _processPayment(paymentProvider),
                          child: const Text("Pay Now"),
                        ),
                      );
                    },
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

  void _processPayment(PaymentProvider paymentProvider) {
    final car = allOrderData['car'];
    final order = allOrderData['order'];

    if (order == null || order.sId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order information missing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    paymentProvider.processPayment(
      orderId: order.sId!,
      totalAmount: allOrderData['totalPrice'],
      customerName: allOrderData['fullName'],
      customerEmail: allOrderData['email'],
      customerPhone: allOrderData['phone'],
      customerAddress: allOrderData['location'],
      carTitle: car.title,
      deliveryOption: allOrderData['deliveryOption'],
    );
  }
}