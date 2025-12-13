import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _watchCurrentUser();
  }

  bool inProgress = false;

  User? currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///=================================sign up with email and password===========================

  Future<bool> signUpWithEmailAndPassword({
    required BuildContext context,
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

      final user = credential.user;
      if (user != null) {
        if (name != null) {
          await credential.user?.updateDisplayName(name);
        }
        debugPrint("User created: ${user.uid}");
        showSnackbarMessage(
          context: context,
          message: "Sign up successful",
          color: Colors.green,
        );
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase error: ${e.code}");
      showSnackbarMessage(
        context: context,
        message: e.message.toString(),
        color: Colors.red,
      );
      return false;
    } catch (e) {
      debugPrint("Unknown error: $e");
      showSnackbarMessage(
        context: context,
        message: e.toString(),
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///=================================sign in with email and password===========================

  Future<bool> signInWithEmailAndPassword({
    required BuildContext context,
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
      final user = credential.user;
      if (user != null) {
        showSnackbarMessage(
          context: context,
          message: "Sign in successful",
          color: Colors.green,
        );
        return true;
      } else {
        showSnackbarMessage(
          context: context,
          message: "Sign in Failed",
          color: Colors.red,
        );
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showSnackbarMessage(
        context: context,
        message: e.message.toString(),
        color: Colors.red,
      );
      return false;
    } catch (e) {
      showSnackbarMessage(
        context: context,
        message: e.toString(),
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///================================= Watch current user===========================

  void _watchCurrentUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUser = user;
      }
    });
  }
}
