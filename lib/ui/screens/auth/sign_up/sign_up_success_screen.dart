import 'package:car_hub/ui/screens/auth/profile_setup/set_profile_picture.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});
  static String name = "sign-up-success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset(AssetsFilePaths.svgCurveRectangle, fit: BoxFit.fill),
                Positioned(
                  top: 220,
                  child: SvgPicture.asset(width: 120, AssetsFilePaths.svgTickLogo),
                ),
        
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 180,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Congratulation",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(
                        "You’ve successfully created your account. Let’s get started on your Journey",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
        
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: FilledButton(
                      onPressed: () {
                        _onTapGoToSignInScreenButton(context);
                      },
                      child: Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTapGoToSignInScreenButton(BuildContext context) {
    Navigator.pushNamed(context, SetProfilePicture.name);
  }
}
