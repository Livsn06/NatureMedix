// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/cust_loadingAlert.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class ForgetPasswordController extends GetxController {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      showLoadingAlert(context, "Sending Reset Link",
          "Please wait while we process your request...");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      hideLoadingAlert(context);
      Get.snackbar(
        padding: EdgeInsets.symmetric(
            vertical: setResponsiveSize(context, baseSize: 20),
            horizontal: setResponsiveSize(context, baseSize: 30)),
        icon: Icon(Icons.check_circle_outline,
            color: Colors.white,
            size: setResponsiveSize(context, baseSize: 40)),
        backgroundColor: Application().color.valid,
        'Success sent to your email.',
        colorText: Colors.white,
        'Password reset link has been sent to your email.',
        snackPosition: SnackPosition.TOP,
      );
    } on FirebaseAuthException {
      // Close loading dialog
      hideLoadingAlert(context);

      // Show error dialog
      Get.snackbar(
        padding: EdgeInsets.symmetric(
            vertical: setResponsiveSize(context, baseSize: 20),
            horizontal: setResponsiveSize(context, baseSize: 30)),
        icon: Icon(Icons.error_outline,
            color: Colors.white,
            size: setResponsiveSize(context, baseSize: 40)),
        backgroundColor: Application().color.invalid,
        'Error sending reset link.',
        colorText: Colors.white,
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
