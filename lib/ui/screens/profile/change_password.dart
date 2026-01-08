import 'package:car_hub/providers/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  static String name = "change-password";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _oldObscure = true;
  bool _newObscure = true;
  bool _confirmObscure = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final loading = authProvider.inProgress;

        return Scaffold(
          appBar: AppBar(title: Text("change_password.title".tr())),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "change_password.existing_password".tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextFormField(
                    controller: _oldPasswordController,
                    obscureText: _oldObscure,
                    validator: (v) =>
                    v == null || v.isEmpty ? "change_password.enter_old_password".tr() : null,
                    decoration: InputDecoration(
                      hintText: "change_password.hint_existing".tr(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _oldObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _oldObscure = !_oldObscure),
                      ),
                    ),
                  ),

                  Text(
                    "change_password.new_password".tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _newObscure,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "change_password.enter_new_password".tr();
                      }
                      if (v.length < 6) {
                        return "change_password.password_min_length".tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "change_password.hint_new".tr(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _newObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _newObscure = !_newObscure),
                      ),
                    ),
                  ),

                  Text(
                    "change_password.confirm_password".tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _confirmObscure,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "change_password.confirm_your_password".tr();
                      }
                      if (v != _newPasswordController.text) {
                        return "change_password.passwords_not_match".tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "change_password.hint_confirm".tr(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () =>
                            setState(() => _confirmObscure = !_confirmObscure),
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: loading ? null : () => _onSubmit(authProvider),
                      child: loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : Text("change_password.change_password_button".tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSubmit(AuthProvider authProvider) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await authProvider.changePassword(
      context: context,
      oldPassword: _oldPasswordController.text.trim(),
      newPassword: _newPasswordController.text.trim(),
    );

    if (success) {
      Navigator.pop(context);
    }
  }
}