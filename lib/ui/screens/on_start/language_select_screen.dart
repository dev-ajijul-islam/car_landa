import 'package:car_hub/providers/language_provider.dart';
import 'package:car_hub/ui/screens/on_start/welcome_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  static String name = "language-select";

  final String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: args != null ? AppBar(title: Text("language").tr()) : null,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 10,
              children: [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    "choose_lang_title",
                    style: TextTheme.of(context).titleLarge,
                  ).tr(),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "choose_lang_description",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ).tr(),
                  ),
                ),

                buildLanguageTile(
                  context: context,
                  flag: "assets/images/us.png",
                  value: "en_US",
                  name: "English",
                ),
                buildLanguageTile(
                  context: context,
                  flag: "assets/images/bd.png",
                  value: "bn",
                  name: "Bangla",
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                _onTapContinueButton(context, args);
              },
              child: Text((args != null) ? "save".tr() : "continue".tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapContinueButton(BuildContext context, args) {
    if (args != null) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamed(context, WelcomeScreen.name);
    }
  }

  Container buildLanguageTile({
    required BuildContext context,
    required String flag,
    required String value,
    required String name,
  }) {
    bool isSelected = selectedLanguage == value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: double.maxFinite,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        border: BoxBorder.fromBorderSide(
          BorderSide(
            width: 0.5,
            color: isSelected
                ? ColorScheme.of(context).primary
                : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        spacing: 10,
        children: [
          Image.asset(flag, width: 30, height: 30),
          Expanded(child: Text(name)),
          Consumer<LanguageProvider>(
            builder: (context, state, child) => Radio(
              value: value,
              groupValue: state.currentLanguage,
              onChanged: (value) {
                state.changeLanguage(context, value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
