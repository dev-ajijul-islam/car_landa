import 'package:car_hub/providers/advance_search_provider.dart';
import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/providers/car_brands_provider.dart';
import 'package:car_hub/providers/car_by_types_provider.dart';
import 'package:car_hub/providers/car_fuel_type_provider.dart';
import 'package:car_hub/providers/car_locations_provider.dart';
import 'package:car_hub/providers/car_min_and_max_price_provider.dart';
import 'package:car_hub/providers/car_min_and_max_year_provider.dart';
import 'package:car_hub/providers/car_models_provider.dart';
import 'package:car_hub/providers/car_types_provider.dart';
import 'package:car_hub/providers/create_order_provider.dart';
import 'package:car_hub/providers/favorite_provider.dart';
import 'package:car_hub/providers/featured_car_provider.dart';
import 'package:car_hub/providers/hot_deal_car_provider.dart';
import 'package:car_hub/providers/language_provider.dart';
import 'package:car_hub/providers/order_tracking_provider.dart';
import 'package:car_hub/providers/payment_provider.dart';
import 'package:car_hub/providers/single_car_provider.dart';
import 'package:car_hub/providers/track_car_provider.dart';
import 'package:car_hub/providers/view_cars_provider.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/profile_setup/set_profile_picture.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_email_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_password_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_password_success.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/email_verification_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_success_screen.dart';
import 'package:car_hub/ui/screens/cars_by_type_screen.dart';
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
import 'package:car_hub/ui/screens/profile/my_history.dart';
import 'package:car_hub/ui/screens/profile/personal_information.dart';
import 'package:car_hub/ui/screens/profile/terms_and_condition.dart';
import 'package:car_hub/ui/screens/track_car/order_details_screen.dart';
import 'package:car_hub/ui/screens/track_car/tracking_progress.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarHub extends StatelessWidget {
  const CarHub({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary = Color(0xFF930405);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FeaturedCarProvider()),
        ChangeNotifierProvider(create: (_) => SingleCarProvider()),
        ChangeNotifierProvider(create: (_) => HotDealCarProvider()),
        ChangeNotifierProvider(create: (_) => CarTypesProvider()),
        ChangeNotifierProvider(create: (_) => ViewCarsProvider()),
        ChangeNotifierProvider(create: (_) => CarBrandsProvider()),
        ChangeNotifierProvider(create: (_) => CarModelsProvider()),
        ChangeNotifierProvider(create: (_) => AdvanceSearchProvider()),
        ChangeNotifierProvider(create: (_) => CarFuelTypeProvider()),
        ChangeNotifierProvider(create: (_) => CarLocationsProvider()),
        ChangeNotifierProvider(create: (_) => CarMinAndMaxYearProvider()),
        ChangeNotifierProvider(create: (_) => CarMinAndMaxPriceProvider()),
        ChangeNotifierProvider(create: (_) => CarByTypesProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CreateOrderProvider()),
        ChangeNotifierProvider(create: (_) => TrackCarProvider()),
        ChangeNotifierProvider(create: (_) => OrderTrackingProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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

          buttonTheme: ButtonThemeData(),

          inputDecorationTheme: InputDecorationThemeData(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(color: primary),
            ),
            focusedBorder: OutlineInputBorder(
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),

        //routes
        routes: {
          SplashScreen.name: (_) => SplashScreen(),
          LanguageSelectScreen.name: (_) => LanguageSelectScreen(),
          WelcomeScreen.name: (_) => WelcomeScreen(),
          SignInScreen.name: (_) => SignInScreen(),
          SignUpScreen.name: (_) => SignUpScreen(),
          ResetEmailScreen.name: (_) => ResetEmailScreen(),
          ResetEmailScreen.name: (_) => ResetEmailScreen(),
          ResetPasswordScreen.name: (_) => ResetPasswordScreen(),
          ResetPasswordSuccess.name: (_) => ResetPasswordSuccess(),
          PinVerificationScreen.name : (_)=> PinVerificationScreen(),
          SignUpSuccessScreen.name: (_) => SignUpSuccessScreen(),
          SetProfilePicture.name: (_) => SetProfilePicture(),
          HomeScreen.name: (_) => HomeScreen(),
          MainLayout.name: (_) => MainLayout(),
          SearchResultScreen.name: (_) => SearchResultScreen(),
          NotificationsScreen.name: (_) => NotificationsScreen(),
          CarDetailsScreen.name: (_) => CarDetailsScreen(),
          BookingCostCalculation.name: (_) => BookingCostCalculation(),
          PaymentScreen.name: (_) => PaymentScreen(),
          DeliveryInfoScreen.name: (_) => DeliveryInfoScreen(),
          TrackingProgress.name: (_) => TrackingProgress(),
          PersonalInformation.name: (_) => PersonalInformation(),
          ChangePassword.name: (_) => ChangePassword(),
          MyHistory.name: (_) => MyHistory(),
          TermsAndCondition.name: (_) => TermsAndCondition(),
          CarsByTypeScreen.name: (_) => CarsByTypeScreen(),
          OrderDetailsScreen.name: (_) => OrderDetailsScreen(),
        },
        initialRoute: SplashScreen.name,
      ),
    );
  }
}
