import 'package:car_hub/ui/screens/payment_screen.dart';
import 'package:car_hub/ui/widgets/common_dialog.dart';
import 'package:flutter/material.dart';

class BookingCostCalculation extends StatelessWidget {
  const BookingCostCalculation({super.key});
  static String name = "booking-cost-calculation";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car cost")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cost Summary", style: TextTheme.of(context).titleMedium),
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
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Text(
                          "\$25000",
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipping",
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Text(
                          "\$2400",
                          style: TextTheme.of(context).titleMedium,
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total price",
                          style: TextTheme.of(context).titleMedium,
                        ),
                        Text(
                          "\$27400",
                          style: TextTheme.of(context).titleMedium,
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
                child: FilledButton(
                  onPressed: () {
                    _onTapBookNowButton(context);
                  },
                  child: Text("Book now"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapBookNowButton(BuildContext context) {
    commonDialog(
      context,
      title: "Booking Request Done",
      subtitle:
          "Your booking request has been sent. Once the admin accepts your request, you will be able to make the payment",
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamed(context, PaymentScreen.name);
    });
  }
}
