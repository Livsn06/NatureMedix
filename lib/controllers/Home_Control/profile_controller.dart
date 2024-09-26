import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/cust_confirmation.dart';
import '../../routes/screen_routes.dart'; 

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showLogoutConfirmation(BuildContext context) {
    showConfirmValidation(context, 'Logout', 'Are you sure you want to logout?',
        () async {
      await _auth.signOut();
      Get.offAllNamed(ScreenRouter.getLoginRoute);
    });
    update();
  }
}
