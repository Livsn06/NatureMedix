import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/cust_loadingAlert.dart';
import '../../components/cust_validationAlert.dart';
import 'package:http/http.dart' as http;

import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../Home_Control/bookmark_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //hasError, errorCode, provider,uid, email, name, imageUrl
  String? _errorCode;
  String? _name;
  String? _email;
  String? _uid;
  String? _imageUrl;
  String? _provider;
  bool _hasError = false;
  bool _isSignedIn = false;

  // Getters for each variable
  String? get name => _name;
  String? get email => _email;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;
  String? get provider => _provider;
  bool get isSignedIn => _isSignedIn;
  String? get errorCode => _errorCode;
  bool get hasError => _hasError;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    update();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    update();
  }

  // sign in with google
  Future signInWithGoogle(BuildContext context, String msgType) async {
    try {
      showLoadingAlert(context, "Logging In",
          "Please wait while we verify your credentials...");

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;
        _uid = userDetails.uid;

        // Check if the user is new or existing
        bool userExists = await checkUserExists();
        if (!userExists) {
          // If the user is new, save to Firestore
          _name = userDetails.displayName;
          _email = userDetails.email;
          _imageUrl = userDetails.photoURL;
          _provider = "GOOGLE";
          saveDataToFirestore();
        } else {
          // If the user exists, fetch data from Firestore
          await getUserDataFromFirestore(_uid);
        }

        saveDataToSharedPreferences();
        handleUserLogin(); // Call this after user login
        showValidationAlert(
            context, 'Successful', 'Successfully $msgType', msgType, true, () {
          Get.toNamed(ScreenRouter.getControlscreenRoute);
          Get.snackbar('Successfully Login', 'Welcome back, $_name!',
              icon: Icon(Icons.check_circle_outline,
                  color: Application().color.dimdark),
              colorText: Application().color.dimdark,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Application().color.whiteOpacity20);
        });
        update();
      } else {
        _hasError = true;
        update();
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e, msgType);
    } catch (e) {
      print("Google sign-in error: $e");
      _hasError = true;
      update();
    }
  }

  // Sign-in with email and password
  Future<void> signInWithEmail(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
    String msgType,
  ) async {
    try {
      showLoadingAlert(context, "Logging In",
          "Please wait while we verify your credentials...");

      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        bool userExists = await checkUserExists();
        if (userExists) {
          await getUserDataFromFirestore(_uid);
        } else {
          // Save new user data to Firestore if required
          _name = userCredential.user!.displayName ?? "No Name";
          _email = userCredential.user!.email;
          _provider = "EMAIL";
          saveDataToFirestore();
        }
        saveDataToSharedPreferences();
        handleUserLogin();
        showValidationAlert(
            context, 'Successful', 'Successfully $msgType', msgType, true, () {
          Get.toNamed(ScreenRouter.getControlscreenRoute);
          Get.snackbar('Successfully Login', 'Welcome back, $_name!',
              icon: Icon(Icons.check_circle_outline,
                  color: Application().color.dimdark),
              colorText: Application().color.dimdark,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Application().color.whiteOpacity20);
        });
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e, msgType);
    }
  }

  // ENTRY FOR CLOUDFIRESTORE

  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Cast the snapshot data to Map<String, dynamic>
        var data = snapshot.data() as Map<String, dynamic>;

        _uid = data['uid'];
        _name = data['name'];
        _email = data['email'];
        _imageUrl = data['image_url'];
        _provider = data['provider'];
      } else {
        print("User data does not exist");
      }
    });
  }

  Future saveDataToFirestore() async {
    if (_uid != null) {
      final DocumentReference r =
          FirebaseFirestore.instance.collection("users").doc(_uid);
      await r.set({
        "uid": _uid,
        "name": _name,
        "email": _email,
        "image_url": _imageUrl,
        "provider": _provider,
      });
    } else {
      print("Error: uid is null");
    }
    update();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();

    await s.setString('name', _name ?? 'Unknown');
    await s.setString('email', _email ?? 'Unknown email');
    await s.setString('uid', _uid ?? 'Unknown uid');
    await s.setString('image_url', _imageUrl ?? 'default_image_url');
    await s.setString('provider', _provider ?? 'Unknown provider');

    update();
  }

  Future<void> getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _provider = s.getString('provider');
    update();
  }

  // checkUser exists or not in cloudfirestore
  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      print("EXISTING USER");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void handleUserLogin() async {
    final BookmarkController bookmarkController = Get.put(BookmarkController());
    await bookmarkController.loadBookmarksFromHive();
  }

  // signout
  Future userSignOut() async {
    await firebaseAuth.signOut;
    await googleSignIn.signOut();

    _isSignedIn = false;
    update();
    // clear all storage information
    clearStoredData();
  }

  Future clearStoredData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  bool isPasswordVisible = false;

  // Handle FirebaseAuth exceptions
  void _handleAuthError(
      BuildContext context, FirebaseAuthException e, String msgType) {
    final errorMsg = _getErrorMessage(e.code);
    showValidationAlert(context, 'Opps...', errorMsg, msgType, false, () {
      Navigator.of(context).pop();
    });
  }

  // Return error message based on FirebaseAuthException code
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return 'Verify your credentials and try again.';
      case 'invalid-email':
        return 'Incorrect Email';
      case 'too-many-requests':
        return 'Account Temporarily Disabled';
      default:
        return 'Unknown Error Occurred';
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}
