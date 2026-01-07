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
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AssetsFilePaths.svgCurveRectangle,
                        fit: BoxFit.fill,
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
                                  "You’ve successfully created your account.",
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  args["message"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorScheme.of(context).primary,
                                    decoration: TextDecoration.underline,
                                  ),
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
                Positioned(
                  top: 220,
                  child: SvgPicture.asset(
                    width: 120,
                    AssetsFilePaths.svgTickLogo,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onTapGoToSignInScreenButton(BuildContext context) {
    Navigator.pushNamed(context, SignInScreen.name);
  }
}
