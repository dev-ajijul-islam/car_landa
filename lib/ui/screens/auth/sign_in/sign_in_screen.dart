import 'package:car_hub/providers/auth_provider.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/sign_in/reset_email_screen.dart';
import 'package:car_hub/ui/screens/auth/sign_up/sign_up_screen.dart';
import 'package:car_hub/ui/widgets/loading.dart';
import 'package:car_hub/utils/assets_file_paths.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static String name = "sign-in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordShow = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool loading = context.select<AuthProvider, bool>(
      (p) => p.inProgress,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _onTapSkipButton,
                    child: Text("Skip"),
                  ),
                ),

                Text("Sign In", style: TextTheme.of(context).titleLarge),
                Text(
                  "Welcome back! \n Please enter your details",
                  style: TextTheme.of(context).bodyMedium,
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Email"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          if (!value.contains("@")) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          hintText: "Enter your Email",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Password"),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          if(value.length <6){
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        obscureText: !_isPasswordShow,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordShow = !_isPasswordShow;
                              });
                            },
                            icon: Icon(
                              _isPasswordShow
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          hintText: "Enter your Email",
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                          onPressed: _onTapForgetPasswordButton,
                          child: Text("Forget password"),
                        ),
                      ),
                      FilledButton(
                        onPressed:(){
                          loading ? null : _onTapSignInButton(context);
                        } ,
                        child: loading ? Loading() : Text("Sign in"),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Divider(color: Colors.grey),
                            ),
                          ),
                          Text("Or"),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Divider(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black87,
                        ),
                        onPressed: () {
                          context.read<AuthProvider>().signInWithGoogle(context);
                        },
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AssetsFilePaths.google),
                            Text("Sign in with google"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    text: "Don't have and account ?",
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: ColorScheme.of(context).primary,
                        ),
                        text: "Sign up",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, SignUpScreen.name);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignInButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final success = await context
          .read<AuthProvider>()
          .signInWithEmailAndPassword(
            context: context,
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (success) {
        _emailController.clear();
        _passwordController.clear();
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainLayout.name,
          (route) => false,
        );
      }
    }
  }

  _onTapSkipButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainLayout.name,
      (predicate) => false,
    );
  }

  _onTapForgetPasswordButton() {
    Navigator.pushNamed(context, ResetEmailScreen.name);
  }
}
