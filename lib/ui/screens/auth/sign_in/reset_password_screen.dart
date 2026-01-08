import 'package:car_hub/ui/screens/auth/sign_in/reset_password_success.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static String name = "rsest_password";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 10,
                children: [
                  Text(
                    "reset_password.title".tr(),
                    style: TextTheme.of(context).titleMedium,
                  ),
                  Text("reset_password.subtitle".tr()),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("reset_password.password".tr()),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      hintText: "reset_password.hint_password".tr(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("reset_password.confirm_password".tr()),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      hintText: "reset_password.hint_confirm_password".tr(),
                    ),
                  ),
                ],
              ),
              FilledButton(
                  onPressed: _onTapContinue,
                  child: Text("reset_password.continue".tr())
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapContinue(){
    Navigator.pushNamed(context, ResetPasswordSuccess.name);
  }
}