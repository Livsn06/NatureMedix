import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../components/cust_validation.dart';

class LoginController extends GetxController {
  // State for password visibility
  bool _isPasswordVisible = false;

  // Getters
  bool get isPasswordVisible => _isPasswordVisible;

  // Toggle functions
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
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

  void toSignInConfirm(
    TextEditingController userControl,
    TextEditingController passControl,
    BuildContext context,
    String msgType,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userControl.text, password: passControl.text);

      showValidationAlert(
          context, 'Successful', 'Successfully $msgType', msgType, true);
    } on FirebaseException catch (ex) {
      String msgtext;
      if (ex.message ==
          'The supplied auth credential is incorrect, malformed or has expired.') {
        msgtext = 'Invalid Credential';
      } else if (ex.message == 'The email address is badly formatted.') {
        msgtext = 'Incorrect Email';
      } else if (ex.message ==
          '[ Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later. ]') {
        msgtext = 'Account Temporarily Disabled';
      } else {
        msgtext = 'Unknown Error Occurred';
      }
      showValidationAlert(context, 'Invalid', msgtext, msgType, false);
    }
  }
}
