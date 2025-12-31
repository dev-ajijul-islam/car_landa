import 'package:car_hub/providers/payment_provider.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:car_hub/ui/widgets/loading.dart';
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
    super.didChangeDependencies();
    allOrderData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Future.microtask((){
      if(mounted){
        final paymentProvider = Provider.of<PaymentProvider>(
          context,
          listen: false,
        );
        paymentProvider.reset();
      }
    });
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
                  _buildPaymentInfoCard(),
                  Consumer<PaymentProvider>(
                    builder: (context, paymentProvider, child) {
                      if (paymentProvider.isLoading) {
                        return SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: null,
                            child: Loading(),
                          ),
                        );
                      }

                      if (paymentProvider.status == PaymentStatus.success &&
                          paymentProvider.errorMessage == null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(
                            context,
                            TrackingProgress.name,
                            arguments: allOrderData['order']?.sId,
                          );
                          paymentProvider.reset();
                        });

                        return _buildStatusButton(
                          label: "Payment Successful",
                          color: Colors.green,
                          icon: Icons.check_circle,
                          enabled: false,
                        );
                      }

                      if (paymentProvider.status == PaymentStatus.failed ||
                          paymentProvider.errorMessage != null) {
                        return Column(
                          children: [
                            _buildStatusButton(
                              label: "Try Again",
                              color: Colors.red,
                              enabled: true,
                              onPressed: () => _processPayment(paymentProvider),
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

                      return _buildStatusButton(
                        label: "Pay Now",
                        color: Theme.of(context).colorScheme.primary,
                        enabled: true,
                        onPressed: () => _processPayment(paymentProvider),
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

  Widget _buildPaymentInfoCard() {
    final order = allOrderData['order'];
    final car = allOrderData['car'];
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 20),
            _buildRichText("Selected Method : ", "SSLCommerz Online Payment"),
            _buildRichText(
              "Order Amount : ",
              "\$${allOrderData['totalPrice']}",
            ),
            _buildRichText(
              "Order ID : ",
              "#${order?.sId?.substring(0, 8) ?? 'N/A'}",
            ),
            _buildRichText(
              "Note : ",
              "Complete payment to proceed with car delivery",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
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
      ),
    );
  }

  Widget _buildStatusButton({
    required String label,
    required Color color,
    bool enabled = true,
    IconData? icon,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(backgroundColor: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 20),
            if (icon != null) const SizedBox(width: 10),
            Text(label),
          ],
        ),
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
