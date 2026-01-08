import 'package:car_hub/app.dart';
import 'package:car_hub/firebase_options.dart';
import 'package:car_hub/services/fcm_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await EasyLocalization.ensureInitialized();
  await FcmService.initialized();

  runApp(EasyLocalization(
      supportedLocales: [Locale("en","US"),Locale("bn")],
      path: 'assets/translations',
      startLocale: Locale("en","US"),
      fallbackLocale: Locale("en","US"),
      child: CarHub()));
}