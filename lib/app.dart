import 'package:car_hub/ui/screens/auth/pin_verification_screen.dart';
import 'package:car_hub/ui/screens/auth/reset_email_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up_screen.dart';
import 'package:car_hub/ui/screens/language_select_screen.dart';
import 'package:car_hub/ui/screens/splash_screen.dart';
import 'package:car_hub/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class CarHub extends StatelessWidget {
  const CarHub({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = Color(0xFF930405);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: primary,
          onPrimary: Colors.white,
          surface: Colors.grey.shade100,
          onSurface: Colors.black87,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 40),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: InputDecorationThemeData(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: primary),
          ),
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),

      //routes
      routes: {
        SplashScreen.name: (_) => SplashScreen(),
        LanguageSelectScreen.name: (_) => LanguageSelectScreen(),
        WelcomeScreen.name: (_) => WelcomeScreen(),
        SignInScreen.name: (_) => SignInScreen(),
        SignUpScreen.name : (_) => SignUpScreen(),
        ResetEmailScreen.name : (_) => ResetEmailScreen(),
        PinVerificationScreen.name : (_) => PinVerificationScreen()
      },
      initialRoute: SplashScreen.name,
    );
  }
}
