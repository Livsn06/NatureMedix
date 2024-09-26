import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/cust_confirmation.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class ClientRequestController extends GetxController {
  RxList<Map<String, dynamic>> requests = <Map<String, dynamic>>[].obs;
  var isListVisible = true.obs;

  // State for picked file
  Rx<File?> fileToDisplay = Rx<File?>(null);

  // TextEditingControllers for form inputs
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Toggle between list and create view
  void toggleView(bool showList) {
    isListVisible.value = showList;
  }

  // Create a new request
  void createRequest({
    required String title,
    required String description,
    required File image,
    required DateTime createdAt,
  }) {
    requests.add({
      'title': title,
      'description': description,
      'image': image.path,
      'createdAt': createdAt,
    });
  }

  // Validate request data
  bool validateRequest({
    required String title,
    required String description,
    required File? image,
  }) {
    return title.isNotEmpty && description.isNotEmpty && image != null;
  }

  // Pick image file
  Future<void> pickFile() async {
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
  }

  // Submit request
  void submitRequest(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;

    if (validateRequest(
      title: title,
      description: description,
      image: fileToDisplay.value,
    )) {
      Get.snackbar(
        padding: EdgeInsets.symmetric(
            vertical: setResponsiveSize(context, baseSize: 20),
            horizontal: setResponsiveSize(context, baseSize: 30)),
        icon: Icon(Icons.error,
            color: Colors.white,
            size: setResponsiveSize(context, baseSize: 40)),
        backgroundColor: Application().color.primaryhigh,
        'Success',
        colorText: Colors.white,
        'Successfully created request.',
        snackPosition: SnackPosition.TOP,
      );
      createRequest(
        title: title,
        description: description,
        image: fileToDisplay.value!,
        createdAt: DateTime.now(),
      );

      clearForm();
      toggleView(true); // Switch to List view
    } else {
      Get.snackbar(
        padding: EdgeInsets.symmetric(
            vertical: setResponsiveSize(context, baseSize: 20),
            horizontal: setResponsiveSize(context, baseSize: 30)),
        icon: Icon(Icons.error,
            color: Colors.white,
            size: setResponsiveSize(context, baseSize: 40)),
        backgroundColor: Application().color.invalid,
        'Field Required',
        colorText: Colors.white,
        'Please fill out all fields and select an image.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Clear form
  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    fileToDisplay.value = null;
  }

  // Clear all requests
  void clearRequests() {
    requests.clear();
  }

  void updateRequest(int index, Map<String, dynamic> updatedRequest) {
    requests[index] = updatedRequest;
  }

  void deleteRequest(BuildContext context, int index) {
    showConfirmValidation(
        context, 'Delete Request', 'Do you want to delete request?', () {
      requests.removeAt(index);
      Get.back();
    });
    update();
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    fileToDisplay.value = null;
  }
}
