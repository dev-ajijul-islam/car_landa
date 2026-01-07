import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:car_hub/data/model/user_model.dart';
import 'package:car_hub/data/network/network_caller.dart';
import 'package:car_hub/ui/main_layout.dart';
import 'package:car_hub/ui/screens/auth/sign_in/sign_in_screen.dart';
import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:car_hub/utils/urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    watchCurrentUser();
  }

  bool inProgress = false;
  User? firebaseUser;
  UserModel? dbUser;

  static String? idToken;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///================================= Sign up with email & password ===========================
  Future<bool> signUpWithEmailAndPassword({
    required BuildContext context,
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

      firebaseUser = credential.user;
      if (firebaseUser == null) return false;

      await firebaseUser!.updateDisplayName(name);

      await firebaseUser!.sendEmailVerification();

      final response = await NetworkCaller.postRequest(
        url: Urls.createUser,
        body: {"name": name, "email": email, "authenticatedBy": "credentials"},
        token: idToken,
      );

      if (!response.success) {
        await firebaseUser!.delete();
        showSnackbarMessage(
          context: context,
          message: response.message,
          color: Colors.red,
        );
        return false;
      }

      await _auth.signOut();
      firebaseUser = null;
      idToken = null;

      showSnackbarMessage(
        context: context,
        message: "Verification email sent. Please verify before login.",
        color: Colors.green,
      );

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

      firebaseUser = credential.user;
      if (firebaseUser == null) return false;

      // ❌ BLOCK UNVERIFIED USERS
      if (!firebaseUser!.emailVerified) {
        await _auth.signOut();
        showSnackbarMessage(
          context: context,
          message: "Please verify your email before signing in",
          color: Colors.red,
        );
        return false;
      }

      final idTokenValue = await firebaseUser!.getIdToken();
      idToken = idTokenValue;

      final response = await NetworkCaller.getRequest(
        url: Urls.loginUser(idToken: idToken!),
      );

      if (!response.success || response.body?["body"] == null) {
        showSnackbarMessage(
          context: context,
          message: "Sign in failed",
          color: Colors.red,
        );
        return false;
      }

      final body = response.body!["body"];
      dbUser = UserModel(
        id: body["_id"],
        name: body["name"],
        email: body["email"],
        phone: body["phone"],
        address: body["address"],
        passportIdUrl: body["passportIdUrl"],
        photo: body["photo"],
      );

      showSnackbarMessage(
        context: context,
        message: "Sign in successful",
        color: Colors.green,
      );

      return true;
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
          "photo": userCredential.user?.photoURL,
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

      await firebaseUser!.reload();
      firebaseUser = _auth.currentUser;

      /// Fetch DB user and set
      dbUser = UserModel(
        id: response.body?["body"]["_id"],
        name: response.body?["body"]["name"],
        email: response.body?["body"]["email"],
        phone: response.body?["body"]["phone"],
        address: response.body?["body"]["address"],
        passportIdUrl: response.body?["body"]["passportIdUrl"],
        photo: response.body?["body"]["photo"],
      );

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

  ///=============================== Update Profile ===========================
  Future<bool> updateProfile({
    required BuildContext context,
    required String userId,
    String? name,
    String? phone,
    String? address,
    XFile? profileImageFile,
    XFile? passportImageFile,
  }) async {
    inProgress = true;
    notifyListeners();

    try {
      String? uploadedProfileUrl;
      String? uploadedPassportUrl;

      // Upload profile image if provided
      if (profileImageFile != null) {
        final bytes = await File(profileImageFile.path).readAsBytes();
        final base64Image = base64Encode(bytes);

        final response = await http.post(
          Uri.parse(
            "https://api.imgbb.com/1/upload?key=5350a71f27b5f7f75e8d222f343c8cd4",
          ),
          body: {"image": base64Image},
          headers: {"token": ?idToken},
        );

        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          uploadedProfileUrl = decoded["data"]["url"];
        } else {
          print(
            "------------------------------------------${response.statusCode}",
          );
          showSnackbarMessage(
            context: context,
            message: "Profile image upload failed",
            color: Colors.red,
          );
          return false;
        }
      }

      // Upload passport/proof image if provided
      if (passportImageFile != null) {
        final bytes = await File(passportImageFile.path).readAsBytes();
        final base64Image = base64Encode(bytes);

        final response = await http.post(
          Uri.parse(
            "https://api.imgbb.com/1/upload?key=5350a71f27b5f7f75e8d222f343c8cd4",
          ),
          body: {"image": base64Image},
          headers: {"token": ?idToken},
        );

        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          uploadedPassportUrl = decoded["data"]["url"];
        } else {
          showSnackbarMessage(
            context: context,
            message: "Passport image upload failed",
            color: Colors.red,
          );
          return false;
        }
      }

      // Prepare body for backend update
      final Map<String, dynamic> body = {};
      if (name != null) body["name"] = name;
      if (phone != null) body["phone"] = phone;
      if (address != null) body["address"] = address;
      if (uploadedProfileUrl != null) body["photo"] = uploadedProfileUrl;
      if (uploadedPassportUrl != null) {
        body["passportIdUrl"] = uploadedPassportUrl;
      }

      final response = await NetworkCaller.putRequest(
        url: Urls.updateProfile(userId),
        body: body,
        token: idToken,
      );

      if (response.success) {
        // Update local dbUser
        if (dbUser != null) {
          dbUser = UserModel(
            id: dbUser!.id,
            name: name ?? dbUser!.name,
            email: dbUser!.email,
            phone: phone ?? dbUser!.phone,
            address: address ?? dbUser!.address,
            passportIdUrl: uploadedPassportUrl ?? dbUser!.passportIdUrl,
            photo: uploadedProfileUrl ?? dbUser!.photo,
          );
        }

        // Update firebase display name if changed
        if (name != null && firebaseUser != null) {
          await firebaseUser!.updateDisplayName(name);
          await firebaseUser!.reload();
          firebaseUser = _auth.currentUser;
        }

        showSnackbarMessage(
          context: context,
          message: response.message,
          color: Colors.green,
        );

        if (profileImageFile == null) {
          Navigator.pop(context);
        }
        notifyListeners();
        return true;
      } else {
        showSnackbarMessage(
          context: context,
          message: response.message,
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
  void watchCurrentUser() {
    _auth.authStateChanges().listen((User? user) async {
      firebaseUser = user;
      idToken = await user?.getIdToken();

      notifyListeners();

      final response = await NetworkCaller.getRequest(
        url: Urls.loginUser(idToken: idToken!),
      );

      if (response.success && response.body?["body"] != null) {
        final body = response.body?["body"];
        dbUser = UserModel(
          id: body["_id"] ?? "",
          name: body["name"] ?? "",
          email: body["email"] ?? "",
          phone: body["phone"],
          address: body["address"],
          passportIdUrl: body["passportIdUrl"],
          photo: body["photo"],
        );
      }
      notifyListeners();
    });
  }

  ///=============================== Change Password ===========================
  Future<bool> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
  }) async {
    inProgress = true;
    notifyListeners();

    try {
      final user = _auth.currentUser;

      if (user == null || user.email == null) {
        showSnackbarMessage(
          context: context,
          message: "User not logged in",
          color: Colors.red,
        );
        return false;
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // 🔁 Update password
      await user.updatePassword(newPassword);

      showSnackbarMessage(
        context: context,
        message: "Password updated successfully",
        color: Colors.green,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String message = "Password update failed";

      switch (e.code) {
        case 'wrong-password':
          message = "Old password is incorrect";
          break;
        case 'weak-password':
          message = "Password should be at least 6 characters";
          break;
        case 'requires-recent-login':
          message = "Please login again and try";
          break;
      }

      showSnackbarMessage(
        context: context,
        message: message,
        color: Colors.red,
      );
      return false;
    } catch (e) {
      showSnackbarMessage(
        context: context,
        message: "Password update failed: $e",
        color: Colors.red,
      );
      return false;
    } finally {
      inProgress = false;
      notifyListeners();
    }
  }

  ///================================= Sign out ===========================
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await GoogleSignIn.instance.signOut();

      firebaseUser = null;
      dbUser = null;
      idToken = null;

      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.name,
        (_) => false,
      );
    } catch (e) {
      showSnackbarMessage(context: context, message: "Sign out failed: $e");
    } finally {
      notifyListeners();
    }
  }
}
