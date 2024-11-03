import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturemedix/components/cust_ConfirmAlert.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/cust_imagepick.dart';
import '../../models/client_data.dart';

class ClientRequestController extends GetxController {
  RxList<ClientData> requests = <ClientData>[].obs;
  var isListVisible = true.obs;
  Box<ClientData>? userRequestBox;

  Rx<File?> fileToDisplay = Rx<File?>(null);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Open a Hive box specific to the user's UID.
  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userRequestBox = await Hive.openBox<ClientData>('requests_${user.uid}');
      await loadRequestsFromHive(); // Load requests upon opening the box
    }
  }

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
    var clientData = ClientData(
      title: title,
      description: description,
      imagePath: image.path,
      createdAt: createdAt,
    );

    // Save request to Hive
    saveRequestToHive(clientData);

    // Add the request to the list
    requests.add(clientData);
  }

  Future<void> saveRequestToHive(ClientData clientData) async {
    if (userRequestBox == null) await openUserBox();
    if (userRequestBox != null) {
      String key =
          '${clientData.title}-${DateTime.now().millisecondsSinceEpoch}';
      await userRequestBox!.put(key, clientData);
    }
  }

  // Load requests from Hive
  Future<void> loadRequestsFromHive() async {
    requests.clear();
    if (userRequestBox == null) await openUserBox();
    if (userRequestBox != null) {
      userRequestBox!.values.forEach((value) {
        requests.add(value);
      });
    }
  }

  bool validateRequest({
    required String title,
    required String description,
    required File? image,
  }) {
    return title.isNotEmpty && description.isNotEmpty && image != null;
  }

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

  void submitRequest(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;

    if (validateRequest(
      title: title,
      description: description,
      image: fileToDisplay.value,
    )) {
      Get.snackbar(
        'Success',
        'Successfully created request.',
        icon:
            Icon(Icons.check_circle_outline, color: Application().color.white),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.primaryhigh,
      );

      createRequest(
        title: title,
        description: description,
        image: fileToDisplay.value!,
        createdAt: DateTime.now(),
      );

      clearForm();
      toggleView(true);
    } else {
      Get.snackbar(
        'Field Required',
        'Please fill out all fields and select an image.',
        icon: Icon(Icons.error_outline, color: Application().color.white),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.primary,
      );
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    fileToDisplay.value = null;
  }

  void clearRequests() {
    requests.clear();
  }

  void deleteRequest(BuildContext context, int index) {
    showConfirmValidation(
      context,
      'Delete Request',
      'Do you want to delete request?',
      () async {
        final request = requests[index];

        // Remove the request from the local list
        requests.removeAt(index);

        // Remove the request from Hive storage if the box is open
        if (userRequestBox != null) {
          await userRequestBox!.deleteAt(index);
        }

        Get.back(); // Close the dialog

        // Show the success message
        Get.snackbar(
          'Success',
          'Successfully deleted request.',
          icon: Icon(Icons.delete_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.primary,
        );

        update(); // Update the UI after deletion
      },
      Application().gif.removed,
    );
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    fileToDisplay.value = null;
  }

  Future<void> showImagePicker(
      BuildContext context, Function(XFile?) onImageSelected) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(onImageSelected: onImageSelected);
      },
    );
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.dark, width: 2),
    borderRadius: BorderRadius.circular(5),
  );
}
