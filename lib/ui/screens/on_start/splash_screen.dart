import 'package:car_hub/ui/screens/on_start/language_select_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String name = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, LanguageSelectScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Theme.of(context).colorScheme.primary,
          ),
          Positioned(
            bottom: 80,
            child: SpinKitCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  position: DecorationPosition.background,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  ),
                );
              },
            ),
          ),
          Center(child: SvgPicture.asset(AssetsFilePaths.logoSvg))
        ],
      ),
    );
  }
}
