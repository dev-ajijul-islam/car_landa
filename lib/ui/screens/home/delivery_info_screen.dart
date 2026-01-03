import 'package:car_hub/data/model/car_model.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/home/booking_cost_calculation.dart';
import 'package:flutter/material.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CarModel car;
  late String deliveryOption;
  late final user = context.read<AuthProvider>().dbUser;

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
    _nameTEController.text = user!.name.toString();
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
          children: [
            // Scrollable form fields
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "Full name",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: _nameTEController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "full name",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "Email",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: _emailTEController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "Phone number",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        controller: _phoneTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_outlined),
                          hintText: "phone number",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(
                            r'^[0-9]{10,}$',
                          ).hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          "Location",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      TextFormField(
                        controller: _locationTEController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.location_on_outlined),
                          hintText: "location",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your location';
                          }
                          if (value.trim().length < 5) {
                            return 'Please enter a valid location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ), // Extra space at bottom of scroll
                    ],
                  ),
                ),
              ),
            ),

            // Fixed button at bottom
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onTapContinue,
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapContinue() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        BookingCostCalculation.name,
        arguments: {
          'car': car,
          'deliveryOption': deliveryOption,
          'fullName': _nameTEController.text.trim(),
          'email': _emailTEController.text.trim(),
          'phone': _phoneTEController.text.trim(),
          'location': _locationTEController.text.trim(),
        },
      );
    }
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
