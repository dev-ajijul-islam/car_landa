import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/ui/screens/home/payment_screen.dart';
import 'package:car_hub/ui/widgets/common_dialog.dart';
import 'package:flutter/material.dart';

class BookingCostCalculation extends StatelessWidget {
  const BookingCostCalculation({super.key});
  static String name = "booking-cost-calculation";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final CarModel car = args['car'];

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
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _onTapBookNowButton(context, args, total),
                    child: const Text("Book now"),
                  ),
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
    Map<String, dynamic> args,
    double totalPrice,
  ) {
    commonDialog(
      context,
      title: "Booking Request Done",
      subtitle:
          "Your booking request has been sent. Once the admin accepts your request, you will be able to make the payment",
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(
        context,
        PaymentScreen.name,
        arguments: {...args, 'totalPrice': totalPrice},
      );
    });
  }
}
