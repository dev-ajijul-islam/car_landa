import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordSuccess extends StatelessWidget {
  const ResetPasswordSuccess({super.key});
  static String name = "reset-password-success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                Text(
                  textAlign: TextAlign.center,
                  "reset_password_success.title".tr(),
                  style: TextTheme.of(context).titleMedium,
                ),
                FilledButton(
                  onPressed: () {
                    _onTapGoToSignInScreenButton(context);
                  },
                  child: Text("reset_password_success.go_to_sign_in".tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _onTapGoToSignInScreenButton(BuildContext context){
    Navigator.pushNamed(context, SignInScreen.name);
  }
}