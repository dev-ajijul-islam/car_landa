import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/on_start/language_select_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String name = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().dbUser;

    if (!_navigated && user != null) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainLayout.name,
          (route) => false,
        );
      });
    } else if (!_navigated && user == null) {
      // optional splash delay
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted || _navigated) return;
        _navigated = true;
        Navigator.pushReplacementNamed(context, LanguageSelectScreen.name);
      });
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
          ),
          Center(child: SvgPicture.asset(AssetsFilePaths.logoSvg)),
          const Positioned(
            bottom: 80,
            child: SpinKitCircle(color: Colors.white, size: 50),
          ),
        ],
      ),
    );
  }
}
