import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatelessWidget {
  const PinVerificationScreen({super.key});

  static String name = "pin-verify";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      "Enter verification code",
                      style: TextTheme.of(context).titleMedium,
                    ),
                    SizedBox(height: 10),
                    Text("We have sent a code to your "),
                    Text(
                      "micheljhon@gmail.com",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorScheme.of(context).primary,
                      ),
                    ),

                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PinCodeTextField(
                        backgroundColor: Colors.transparent,
                        keyboardType: TextInputType.number,
                        showCursor: false,
                        pinTheme: PinTheme(shape: PinCodeFieldShape.circle),
                        appContext: context,
                        length: 6,
                      ),
                    ),
                  ],
                ),
                FilledButton(onPressed: () {}, child: Text("Continue")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
