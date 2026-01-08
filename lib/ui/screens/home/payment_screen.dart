import 'package:car_hub/providers/payment_provider.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
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
      appBar: AppBar(title: Text("payment.title".tr())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "payment.payment_option".tr(),
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
                        Text("payment.pay_with_sslcommerz".tr()),
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
                          label: "payment.payment_successful".tr(),
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
                              label: "payment.try_again".tr(),
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
                        label: "payment.pay_now".tr(),
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
                  "payment.payment_information".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildRichText("payment.selected_method".tr(), "payment.sslcommerz_online_payment".tr()),
            _buildRichText(
              "payment.order_amount".tr(),
              "\$${allOrderData['totalPrice']}",
            ),
            _buildRichText(
              "payment.order_id".tr(),
              "#${order?.sId?.substring(0, 8) ?? 'N/A'}",
            ),
            _buildRichText(
              "payment.note".tr(),
              "payment.complete_payment_note".tr(),
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
          text: "$label : ",
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
        SnackBar(
          content: Text('payment.order_information_missing'.tr()),
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