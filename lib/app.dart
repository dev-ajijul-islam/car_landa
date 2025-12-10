import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/profile_setup/set_profile_picture.dart';
import 'package:car_hub/ui/screens/auth/sign_in/pin_verification_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_email_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_password_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_password_success.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/email_verification_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_success_screen.dart';
import 'package:car_hub/ui/screens/home/booking_cost_calculation.dart';
import 'package:car_hub/ui/screens/home/car_details_screen.dart';
import 'package:car_hub/ui/screens/home/delivery_info_screen.dart';
import 'package:car_hub/ui/screens/home/home_screen.dart';
import 'package:car_hub/ui/screens/home/notifications_screen.dart';
import 'package:car_hub/ui/screens/home/payment_screen.dart';
import 'package:car_hub/ui/screens/home/search_result_screen.dart';
import 'package:car_hub/ui/screens/on_start/welcome_screen.dart';
import 'package:car_hub/ui/screens/on_start/language_select_screen.dart';
import 'package:car_hub/ui/screens/on_start/splash_screen.dart';
import 'package:car_hub/ui/screens/profile/change_password.dart';
import 'package:car_hub/ui/screens/profile/my_bookings.dart';
import 'package:car_hub/ui/screens/profile/my_history.dart';
import 'package:car_hub/ui/screens/profile/personal_information.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';

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
          surface: Colors.grey.shade200,
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

        dropdownMenuTheme: DropdownMenuThemeData(),

        buttonTheme: ButtonThemeData(

        ),

        inputDecorationTheme: InputDecorationThemeData(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: primary),
          ), focusedBorder: OutlineInputBorder(
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
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
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
        PinVerificationScreen.name : (_) => PinVerificationScreen(),
        ResetPasswordScreen.name : (_) => ResetPasswordScreen(),
        ResetPasswordSuccess.name : (_) => ResetPasswordSuccess(),
        EmailVerificationScreen.name : (_) => EmailVerificationScreen(),
        SignUpSuccessScreen.name : (_)=> SignUpSuccessScreen(),
        SetProfilePicture.name : (_) => SetProfilePicture(),
        HomeScreen.name : (_) => HomeScreen(),
        MainLayout.name : (_) => MainLayout(),
        SearchResultScreen.name : (_) => SearchResultScreen(),
        NotificationsScreen.name : (_)=> NotificationsScreen(),
        CarDetailsScreen.name : (_)=> CarDetailsScreen(),
        BookingCostCalculation.name : (_) => BookingCostCalculation(),
        PaymentScreen.name : (_) => PaymentScreen(),
        DeliveryInfoScreen.name : (_) => DeliveryInfoScreen(),
        TrackingProgress.name : (_) => TrackingProgress(),
        PersonalInformation.name : (_) => PersonalInformation(),
        ChangePassword.name : (_) => ChangePassword(),
        MyHistory.name : (_) => MyHistory(),
        MyBookings.name : (_)=> MyBookings()
      },
      initialRoute: SplashScreen.name,
    );
  }
}
