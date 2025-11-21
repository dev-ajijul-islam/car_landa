import 'package:car_hub/ui/screens/auth/pin_verification_screen.dart';
import 'package:flutter/material.dart';

class ResetEmailScreen extends StatefulWidget {
  const ResetEmailScreen({super.key});
  static String name = "reset-email";

  @override
  State<ResetEmailScreen> createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Enter your email to reset your password",
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Email"),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(onPressed: _onTapContinueButton, child: Text("Continue")),
          ],
        ),
      ),
    );
  }

  _onTapContinueButton(){
    Navigator.pushNamed(context, PinVerificationScreen.name);
  }
}
