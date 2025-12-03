import 'package:flutter/material.dart';

class DeliveryInfoScreen extends StatelessWidget {
  const DeliveryInfoScreen({super.key});

  static String name = "delivery-info";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery info"),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

          ],
        ),
      ),
    );

  }
}
