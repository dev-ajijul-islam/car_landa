import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/screens/auth/sign_up/email_verification_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetEmailScreen extends StatefulWidget {
  const ResetEmailScreen({super.key});
  static String name = "reset-email";

  @override
  State<ResetEmailScreen> createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "reset_email.title".tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      Text("reset_email.email".tr()),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "reset_email.enter_email".tr();
                          }
                          if (!value.contains("@")) {
                            return "reset_email.enter_valid_email".tr();
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "reset_email.hint_email".tr(),
                          prefixIcon: const Icon(Icons.mail_outline_rounded),
                        ),
                      ),
                    ],
                  ),
                ),

                FilledButton(
                  onPressed: authProvider.inProgress
                      ? null
                      : () => _onTapContinue(authProvider),
                  child: authProvider.inProgress
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text("reset_email.continue".tr()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onTapContinue(AuthProvider authProvider) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await authProvider.forgotPassword(
      context: context,
      email: _emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacementNamed(
        context,
        PinVerificationScreen.name,
        arguments: _emailController.text.trim(),
      );
    }
  }
}