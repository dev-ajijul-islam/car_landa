import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  static String name = "terms-condition";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms and Condition")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "About CarLanda \n"
                    " Effective Date: 04/21/2025 \n"
                    " Welcome to CarLanda. By signing up and using our mobile application and services (collectively, the “App”), you agree to the following Terms and Conditions (“Terms”). Please read them carefully 1User Eligibility \n"
                    " You must be 18 years or older and provide accurate information when registering or making a purchase.Vehicle Purchase \n"
                    " All vehicle listings are added and maintained by CarLanda. Prices shown include base cost; delivery options may affect the final price. Payment & Proof \n"
                    " Payments must be made via approved methods (bank transfer or in-person). Proof of payment must be submitted to process the order Contract Agreement \n"
                    " Upon payment confirmation, a purchase contract is automatically generated and signed digitally.Delivery & Tracking \n"
                    " Once the vehicle is in transit, users will receive tracking details. Delivery times may vary due to customs and logistics.Cancellations & Refunds \n"
                    " Orders are final once payment is confirmed. Cancellations are not accepted after contract generation.Liability10. Contact UsFor questions or concerns, contact support@carlanda.com.",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
