import 'package:car_hub/ui/screens/on_start/welcome_screen.dart';
import 'package:flutter/material.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  static String name = "language-select";

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String? selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Choose your language",
                    style: TextTheme.of(context).titleLarge
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Select your preferred language to use CarLanda",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                buildLanguageTile(
                  flag: "https://flagcdn.com/w40/us.png",
                  value: "English",
                ),
                buildLanguageTile(
                  flag: "https://flagcdn.com/w40/bd.png",
                  value: "Bangla",
                ),
              ],
            ),
            FilledButton(onPressed: _onTapContinueButton, child: Text("Continue")),
          ],
        ),
      ),
    );
  }

  Container buildLanguageTile({required String flag, required String value}) {
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
          Image.network(flag, width: 30, height: 30),
          Expanded(child: Text(value)),
          Radio(
            value: value,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }



  void _onTapContinueButton(){
    Navigator.pushNamed(context, WelcomeScreen.name);
  }
}
