import 'dart:async';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/data/network/network_response.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _watchCurrentUser();
  }
  bool inProgress = false;

  User? currentUser;
  static String? idToken;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///================================= Sign up with email & password ===========================

  Future<bool> signUpWithEmailAndPassword({
    required context,
    required String email,
    required String password,
    required String name,
  }) async {
    inProgress = true;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return false;

      final response = await NetworkCaller.postRequest(
        url: Urls.createUser,
        body: {"name": name, "email": email, "authenticatedBy": "credentials"},
        token: idToken,
      );

      if (!response.success) {
        await user.delete();

        showSnackbarMessage(
          context: context,
          message: response.message,
          color: Colors.red,
        );
        return false;
      }

      await user.updateDisplayName(name);

      showSnackbarMessage(
        context: context,
        message: "Sign up successful",
        color: Colors.green,
      );
      await user.reload();
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackbarMessage(
        context: context,
        message: e.message ?? "Sign up failed",
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///================================= Sign in with email & password ===========================

  Future<bool> signInWithEmailAndPassword({
    required context,
    required String email,
    required String password,
  }) async {
    inProgress = true;
    notifyListeners();
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) return false;

      final idToken = await credential.user!.getIdToken();
      NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.loginUser(idToken: idToken!),
      );

      if (response.success) {
        showSnackbarMessage(
          context: context,
          message: "Sign in successful",
          color: Colors.green,
        );
        return true;
      } else {
        showSnackbarMessage(
          context: context,
          message: "Sign in failed",
          color: Colors.red,
        );
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showSnackbarMessage(
        context: context,
        message: e.message ?? "Sign in failed",
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///================================= Google Sign In ===========================

  Future<bool> signInWithGoogle(context) async {
    inProgress = true;
    notifyListeners();

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception("Google ID Token is null");
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user == null) return false;

      final response = await NetworkCaller.postRequest(
        body: {
          "name": userCredential.user?.displayName,
          "email": userCredential.user?.email,
          "authenticatedBy": "google",
        },
        url: Urls.createUser,
        token: idToken,
      );

      if (!response.success) {
        await userCredential.user?.delete();

        showSnackbarMessage(
          context: context,
          message: response.message,
          color: Colors.red,
        );
        return false;
      }

      showSnackbarMessage(
        context: context,
        message: "Sign up successful",
        color: Colors.green,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainLayout.name,
        (route) => false,
      );
      return true;
    } catch (e) {
      showSnackbarMessage(
        context: context,
        message: "Google sign in failed: $e",
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///================================= Update Profile ===========================

  Future<bool> updateProfile({
    required BuildContext context,
    required String userId,
    String? name,
    String? phone,
    String? address,
    String? passportIdUrl,
  }) async {
    inProgress = true;
    notifyListeners();

    try {
      final Map<String, dynamic> body = {};

      if (name != null) body["name"] = name;
      if (phone != null) body["phone"] = phone;
      if (address != null) body["address"] = address;
      if (passportIdUrl != null) body["passportIdUrl"] = passportIdUrl;

      final NetworkResponse response = await NetworkCaller.putRequest(
        url: Urls.updateProfile(userId),
        body: body,
        token: idToken,
      );

      if (response.success) {
        // 🔄 Update Firebase display name if changed
        if (name != null && currentUser != null) {
          await currentUser!.updateDisplayName(name);
          await currentUser!.reload();
          currentUser = _auth.currentUser;
        }

        showSnackbarMessage(
          context: context,
          message: response.message ?? "Profile updated successfully",
          color: Colors.green,
        );

        return true;
      } else {
        showSnackbarMessage(
          context: context,
          message: response.message ?? "Profile update failed",
          color: Colors.red,
        );
        return false;
      }
    } catch (e) {
      showSnackbarMessage(
        context: context,
        message: "Profile update failed: $e",
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///================================= Watch current user ===========================

  void _watchCurrentUser() {
    _auth.authStateChanges().listen((User? user) async {
      currentUser = user;
      idToken = await user?.getIdToken();
      notifyListeners();
    });
  }

  ///================================= Sign out ===========================

  Future<void> signOut(context) async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();

      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
        (_) => false,
      );
    } catch (e) {
      showSnackbarMessage(context: context, message: "Sign out failed: $e");
    }
  }
}
