import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/home/booking_cost_calculation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as ontext;
import 'package:provider/provider.dart';

class DeliveryInfoScreen extends StatefulWidget {
  const DeliveryInfoScreen({super.key});

  static String name = "delivery-info";

  @override
  State<DeliveryInfoScreen> createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _locationTEController = TextEditingController();

  late CarModel car;
  late String deliveryOption;
  late final user = context.read<AuthProvider>().currentUser;
  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    car = args['car'];
    deliveryOption = args['deliveryOption'];
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _nameTEController.text = user!.displayName.toString();
    _emailTEController.text = user!.email.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delivery information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text(
                "Full name",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            TextField(
              enabled: false,
              controller: _nameTEController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                hintText: "full name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text(
                "Email",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            TextField(
              enabled: false,
              controller: _emailTEController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                hintText: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text(
                "Phone number",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            TextField(
              controller: _phoneTEController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_outlined),
                hintText: "phone number",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 2),
              child: Text(
                "Location",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            TextField(
              controller: _locationTEController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
                hintText: "location",
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _onTapContinue,
                    child: const Text("Continue"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapContinue() {
    // পরবর্তী স্ক্রিনে সব ডাটা পাস করা
    Navigator.pushNamed(
      context,
      BookingCostCalculation.name,
      arguments: {
        'car': car,
        'deliveryOption': deliveryOption,
        'fullName': _nameTEController.text,
        'email': _emailTEController.text,
        'phone': _phoneTEController.text,
        'location': _locationTEController.text,
      },
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _phoneTEController.dispose();
    _locationTEController.dispose();
    super.dispose();
  }
}
