import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/data/model/order_model.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/providers/create_order_provider.dart';
import 'package:car_hub/ui/screens/home/payment_screen.dart';
import 'package:car_hub/ui/widgets/common_dialog.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingCostCalculation extends StatelessWidget {
  const BookingCostCalculation({super.key});
  static String name = "booking-cost-calculation";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final CarModel car = args['car'];
    final String deliveryOption = args['deliveryOption'];
    final String fullName = args['fullName'];
    final String email = args['email'];
    final String phone = args['phone'];
    final String location = args['location'];

    final double carPrice = car.pricing.sellingPrice.toDouble();
    final double shipping = car.costs.shipping.toDouble();
    final double total = carPrice + shipping;

    return Scaffold(
      appBar: AppBar(title: const Text("Car cost")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cost Summary",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Car price",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "\$$carPrice",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipping",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "\$$shipping",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total price",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "\$$total",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<CreateOrderProvider>(
                  builder: (context, orderProvider, child) {
                    if (orderProvider.isLoading) {
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: null,
                          child: const Loading(),
                        ),
                      );
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => _onTapBookNowButton(
                          context,
                          car,
                          deliveryOption,
                          total,
                          fullName,
                          email,
                          phone,
                          location,
                          orderProvider,
                        ),
                        child: const Text("Book now"),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapBookNowButton(
      BuildContext context,
      CarModel car,
      String deliveryOption,
      double totalPrice,
      String fullName,
      String email,
      String phone,
      String location,
      CreateOrderProvider orderProvider,
      ) async {
    final user = context.read<AuthProvider>().dbUser;
    if (user == null) {
      showSnackbarMessage(
        context: context,
        message: "Please login to book a car",
        color: Colors.red,
      );
      return;
    }

    final order = OrderModel(
      carId: car.sId,
      userId: user.id.toString(),
      deliveryOption: deliveryOption,
      totalAmount: totalPrice,
      paymentMethod: 'Pending',
      paymentStatus: 'Pending',
      fullName: fullName,
      email: email,
      phone: phone,
      location: location,
    );

    await orderProvider.createOrder(order);

    if (orderProvider.isSuccess && orderProvider.createdOrder != null) {
      final createdOrder = orderProvider.createdOrder!;

      commonDialog(
        context,
        title: "Order Created Successfully",
        subtitle: "Your order has been placed. Proceed to payment.",
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(
          context,
          PaymentScreen.name,
          arguments: {
            'car': car,
            'deliveryOption': deliveryOption,
            'fullName': fullName,
            'email': email,
            'phone': phone,
            'location': location,
            'totalPrice': totalPrice,
            'order': createdOrder,
          },
        );
        orderProvider.resetStatus();
      });
    } else if (orderProvider.errorMessage != null) {
      showSnackbarMessage(
        context: context,
        message: orderProvider.errorMessage!,
        color: Colors.red,
      );
    }
  }
}