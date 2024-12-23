import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/cust_validationAlert.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class RegisterController extends GetxController {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isRememberMeChecked = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isRememberMeChecked => _isRememberMeChecked;

  // Toggle functions
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    update();
  }

  void toggleRememberMe() {
    _isRememberMeChecked = !_isRememberMeChecked;
    update();
  }

  // Email Validator
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password Validator
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  // Confirm Password Validator
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Register User
  void toSignUpConfirm(
    TextEditingController fnameControl,
    TextEditingController emailControl,
    TextEditingController passControl,
    TextEditingController confirmControl,
    BuildContext context,
    String msgType,
  ) async {
    try {
      if (isRememberMeChecked == true) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailControl.text, password: passControl.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'uid': userCredential.user!.uid,
          'name': fnameControl.text,
          'email': emailControl.text,
          'provider': 'EMAIL'
        });

        // Show success alert
        showValidationAlert(
            context, 'Successful', 'Successfully $msgType', msgType, true, () {
          Get.toNamed(ScreenRouter.getLoginRoute);
        });
      } else {
        Get.snackbar(
          padding: EdgeInsets.symmetric(
              vertical: setResponsiveSize(context, baseSize: 20),
              horizontal: setResponsiveSize(context, baseSize: 30)),
          icon: Icon(Icons.warning_rounded,
              color: Colors.white,
              size: setResponsiveSize(context, baseSize: 40)),
          backgroundColor: Application().color.valid,
          'Terms and Conditions',
          colorText: Colors.white,
          'Please check the terms and conditions',
          snackPosition: SnackPosition.TOP,
        );
      }
    } on FirebaseAuthException catch (ex) {
      String msgtext;
      if (ex.code == 'invalid-credential') {
        msgtext = 'Invalid Credential';
      } else if (ex.code == 'email-already-in-use') {
        msgtext = 'Email already registered.';
      } else if (ex.code == 'weak-password') {
        msgtext = 'Password must be at least 6 characters.';
      } else if (ex.code == 'user-disabled') {
        msgtext = 'Account Temporarily Disabled';
      } else {
        msgtext = 'An error occurred: ${ex.message}';
      }

      // Show error alert
      showValidationAlert(context, 'Opps...', msgtext, msgType, false, () {
        Navigator.pop(context);
      });
    }
  }
}
