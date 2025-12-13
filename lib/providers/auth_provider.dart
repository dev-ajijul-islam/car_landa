import 'dart:async';

import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _watchCurrentUser();
  }

  bool inProgress = false;

  User? currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///================================= Sign up with email & password ===========================

  Future<bool> signUpWithEmailAndPassword({
    required context,
    required String email,
    required String password,
    String? name,
  }) async {
    inProgress = true;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        if (name != null) {
          await credential.user!.updateDisplayName(name);
        }

        showSnackbarMessage(
          context: context,
          message: "Sign up successful",
          color: Colors.green,
        );
        return true;
      }
      return false;
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

      if (credential.user != null) {
        showSnackbarMessage(
          context: context,
          message: "Sign in successful",
          color: Colors.green,
        );
        return true;
      }
      return false;
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

  ///================================= Google Sign In (google_sign_in ^7.2.0) ===========================

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

      if (userCredential.user != null) {
        showSnackbarMessage(
          context: context,
          message: "Google sign in successful",
          color: Colors.green,
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          MainLayout.name,
          (route) => false,
        );

        return true;
      }

      return false;
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

  ///================================= Watch current user ===========================

  void _watchCurrentUser() {
    _auth.authStateChanges().listen((User? user) {
      currentUser = user;
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
