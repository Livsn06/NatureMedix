import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/cust_confirmation.dart';
import '../../routes/screen_routes.dart';
import '../Auth_Control/login_controller.dart';

class ProfileController extends GetxController {
  final LoginController sp = Get.put(LoginController());

  // Show confirmation dialog for logout
  void showLogoutConfirmation(BuildContext context) {
    showConfirmValidation(
      context,
      'Logout',
      'Are you sure you want to logout?',
      () async {
        sp.userSignOut();
        Get.offAllNamed(ScreenRouter.getLoginRoute);
      },
    );
    update();
  }

  // Profile options
  List<Map<String, dynamic>> profileData = [];

  @override
  void onInit() {
    super.onInit();

    profileData = [
      {'icon': Icons.edit, 'label': 'Edit Profile Name', 'action': () {}},
      {'icon': Icons.history, 'label': 'History', 'action': () {}},
      {'icon': Icons.lock, 'label': 'Change Password', 'action': () {}},
      {'icon': Icons.email, 'label': 'Change Email Address', 'action': () {}},
      {'icon': Icons.settings, 'label': 'Settings', 'action': () {}},
      {
        'icon': Icons.logout,
        'label': 'Logout',
        'action': () => showLogoutConfirmation(Get.context!)
      },
    ];
  }
}
