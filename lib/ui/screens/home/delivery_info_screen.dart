import 'package:flutter/material.dart';

class DeliveryInfoScreen extends StatelessWidget {
  const DeliveryInfoScreen({super.key});

  static String name = "delivery-info";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text("Full name", style: TextTheme.of(context).bodyLarge),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                hintText: "full name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text("Email", style: TextTheme.of(context).bodyLarge),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                hintText: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text("Phone number", style: TextTheme.of(context).bodyLarge),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_outlined),
                hintText: "phone number",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text("Location", style: TextTheme.of(context).bodyLarge),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
                hintText: "location",
              ),
            ),
            Expanded(child: Align(alignment: Alignment.bottomCenter, child: FilledButton(onPressed: (){}, child: Text("Continue")),))
          ],
        ),
      ),
    );
  }
}
