import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

class PinVerificationScreen extends StatelessWidget {
  const PinVerificationScreen({super.key});
  static String name = "pin-verification";

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.mark_email_read_outlined, size: 80),
              const SizedBox(height: 20),
              Text(
                "Check your email",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "We sent a password reset link to",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                email ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    SignInScreen.name,
                    (route) => false,
                  );
                },
                child: const Text("Back to Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
