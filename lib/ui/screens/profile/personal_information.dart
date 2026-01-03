import 'dart:io';

import 'package:car_hub/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  static String name = "personal-information";

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormState>();

  XFile? passportIdImage;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = context.read<AuthProvider>().currentUser;
    if (user != null) {
      _nameController.text = user.displayName.toString();
      _emailController.text = user.email.toString();
      _phoneController.text = user.phoneNumber.toString();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Full Name"),
              _input(
                controller: _nameController,
                hint: "Full name",
                icon: Icons.person_2_outlined,
                validator: (v) => v!.isEmpty ? "Name is required" : null,
              ),

              _label("Email"),
              _input(
                controller: _emailController,
                hint: "Email",
                icon: Icons.email_outlined,
                enabled: false,
              ),

              _label("Phone Number"),
              _input(
                controller: _phoneController,
                hint: "Enter phone number",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v!.length < 10 ? "Enter valid phone number" : null,
              ),

              _label("Address"),
              _input(
                controller: _addressController,
                hint: "Enter address",
                icon: Icons.location_on_outlined,
                validator: (v) => v!.isEmpty ? "Address is required" : null,
              ),

              _label("Upload Passport / ID"),
              _passportPicker(context),

              const Spacer(),

              FilledButton(onPressed: _onSubmit, child: const Text("Update")),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- SUBMIT ----------
  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (passportIdImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload passport / ID")),
      );
      return;
    }

    final data = {
      "name": _nameController.text.trim(),
      "phone": _phoneController.text.trim(),
      "address": _addressController.text.trim(),
      "passport": passportIdImage!.path,
    };

    debugPrint("SUBMIT DATA: $data");
  }

  /// ---------- UI HELPERS ----------
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _input({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(prefixIcon: Icon(icon), hintText: hint),
    );
  }

  Widget _passportPicker(BuildContext context) {
    return InkWell(
      onTap: _onTapUploadPassport,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: passportIdImage != null
              ? Image.file(File(passportIdImage!.path), fit: BoxFit.cover)
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file),
                      Text("Click to upload"),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _onTapUploadPassport() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (picked != null) {
      setState(() => passportIdImage = picked);
    }
  }
}
