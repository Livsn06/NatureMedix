import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturemedix/components/cust_imagepick.dart';
import '../../components/cust_ConfirmAlert.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../Auth_Control/login_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  final LoginController sp = Get.put(LoginController());
  Rx<File?> fileToDisplay = Rx<File?>(null);
  final FirebaseAuth auth = FirebaseAuth.instance;
  var selectedFiles = <File>[].obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var address = TextEditingController();
  var phoneNumber = TextEditingController();
  var gender = TextEditingController();
  var birthdate = TextEditingController();

  // Function to update user profile
  Future<void> updateUserProfile(String uid) async {
    try {
      if (fileToDisplay.value != null) {
        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child(
            'user_images/${uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
        final uploadTask = storageRef.putFile(fileToDisplay.value!);

        // Wait for the upload to complete and get the download URL
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Update Firestore with the download URL of the image
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'address': address.text,
          'birthdate': birthdate.text,
          'phoneNumber': phoneNumber.text,
          'gender': gender.text,
          'imageEmail': selectedFiles.first.path, // Store the image URL here
        });

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          icon: Icon(Icons.check_circle_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.valid,
        );
      } else {
        // If no image is selected, just update other fields
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'address': address.text,
          'birthdate': birthdate.text,
          'phoneNumber': phoneNumber.text,
          'gender': gender.text,
        });

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          icon: Icon(Icons.check_circle_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.valid,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        icon: Icon(Icons.warning_amber_outlined,
            color: Application().color.white),
        colorText: Application().color.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.invalid,
      );
    }
  }

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
      Application().gif.question,
    );
    update();
  }

  Future<void> showImage(
      BuildContext context, Function(XFile?) onCaptureImage) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onCaptureImage: onCaptureImage,
          onSelectMultiple: () async {
            try {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.image,
                allowMultiple: false,
              );

              if (result != null && result.files.isNotEmpty) {
                fileToDisplay.value = File(result.files.first.path!);
              } else {
                print('No file selected');
              }
            } catch (e) {
              print('Error picking file: $e');
            }
          },
        );
      },
    );
  }

  // Profile options
  List<Map<String, dynamic>> EmailData = [];
  List<Map<String, dynamic>> GoogleData = [];

  @override
  void onInit() {
    super.onInit();

    //# Email
    EmailData = [
      {
        'icon': Icons.edit,
        'label': 'Edit Profile',
        'action': () => Get.toNamed(ScreenRouter.getEditProfileRoute)
      },
      {
        'icon': Icons.history,
        'label': 'History',
        'action': () => Get.toNamed(ScreenRouter.getHistoryRoute)
      },
      {
        'icon': Icons.lock,
        'label': 'Privacy Policy',
        'action': () => Get.toNamed(ScreenRouter.getPrivacyRoute)
      },
      {
        'icon': Icons.question_answer,
        'label': 'FAQ\'s',
        'action': () => Get.toNamed(ScreenRouter.getFaqRoute)
      },
      {
        'icon': Icons.info_outline,
        'label': 'About Us',
        'action': () => Get.toNamed(ScreenRouter.getAboutRoute)
      },
      {
        'icon': Icons.logout,
        'label': 'Logout',
        'action': () => showLogoutConfirmation(Get.context!)
      },
    ];

    //# Google
    GoogleData = [
      {
        'icon': Icons.edit,
        'label': 'Edit Profile',
        'action': () => Get.toNamed(ScreenRouter.getEditProfileRoute)
      },
      {
        'icon': Icons.history,
        'label': 'History',
        'action': () => Get.toNamed(ScreenRouter.getHistoryRoute)
      },
      {
        'icon': Icons.lock,
        'label': 'Privacy Policy',
        'action': () => Get.toNamed(ScreenRouter.getPrivacyRoute)
      },
      {
        'icon': Icons.question_answer,
        'label': 'FAQ\'s',
        'action': () => Get.toNamed(ScreenRouter.getFaqRoute)
      },
      {
        'icon': Icons.info_outline,
        'label': 'About Us',
        'action': () => Get.toNamed(ScreenRouter.getAboutRoute)
      },
      {
        'icon': Icons.logout,
        'label': 'Logout',
        'action': () => showLogoutConfirmation(Get.context!)
      },
    ];
  }
}
