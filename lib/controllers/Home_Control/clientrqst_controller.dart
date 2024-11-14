// ignore_for_file: avoid_print

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturemedix/components/cust_ConfirmAlert.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../../components/cust_imagepick.dart';
import '../../models/client_data.dart';

class ClientRequestController extends GetxController {
  RxList<ClientData> requests = <ClientData>[].obs;
  var isListVisible = true.obs;
  Rx<File?> fileToDisplay = Rx<File?>(null);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Box? userBox;

  @override
  void onInit() {
    super.onInit();
    loadRequests();
  }

  void toggleView(bool showList) {
    isListVisible.value = showList;
  }

  // Create a new request
  Future<void> createRequest({
    required String title,
    required String description,
    required File image,
    required DateTime createdAt,
  }) async {
    var clientData = ClientData(
      title: title,
      description: description,
      imagePath: image.path,
      createdAt: createdAt,
    );

    // Save request to Firestore and Hive
    await saveRequest(clientData);
    requests.add(clientData);
  }

  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Open a Hive box specific to the user's UID only once.
    userBox = await Hive.openBox(user.uid);
  }

  Future<void> saveRequest(ClientData clientData) async {
    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Save to Hive (local storage)
      final userBox = await Hive.openBox('userRequests');
      List<dynamic> userRequests = userBox.get(user.uid, defaultValue: []);
      userRequests.add(clientData.toMap());
      await userBox.put(user.uid, userRequests);

      print("Request saved locally in Hive for user ${user.uid}");

      // Save to Firestore (cloud storage)
      await _firestore.collection('users').doc(user.uid).set({
        'RequestList': FieldValue.arrayUnion([clientData.toMap()]),
      }, SetOptions(merge: true));
      print("Request saved in Firestore for user ${user.uid}");
    }
  }

  Future<void> loadRequests() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        if (userBox == null) await openUserBox();
        if (userBox != null) {
          // Load requests from Hive (local storage)
          List<dynamic> userRequestsMap =
              userBox!.get(user.uid, defaultValue: []);

          if (userRequestsMap.isNotEmpty) {
            requests.addAll(
                userRequestsMap.map((e) => ClientData.fromMap(e)).toList());
          }

          // Load requests from Firestore (cloud storage)
          final docSnapshot =
              await _firestore.collection('users').doc(user.uid).get();
          if (docSnapshot.exists) {
            final data = docSnapshot.data();
            if (data != null && data.containsKey('RequestList')) {
              final firestoreRequests =
                  List<Map<String, dynamic>>.from(data['RequestList'] ?? []);
              final firestoreRequestData =
                  firestoreRequests.map((e) => ClientData.fromMap(e)).toList();

              // Add unique Firestore data to avoid duplication
              for (var request in firestoreRequestData) {
                if (!requests.any((req) =>
                    req.title == request.title &&
                    req.description == request.description)) {
                  requests.add(request);
                }
              }
            }
          }
          print("Requests loaded successfully for user ${user.uid}");
        }
      } catch (e) {
        print('Error loading requests: $e');
      }
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

  void submitRequest(BuildContext context) async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (validateRequest(
      title: title,
      description: description,
      image: fileToDisplay.value,
    )) {
      Get.snackbar(
        'Successfully ',
        'Request submitted successfully!',
        icon: Icon(Icons.error_outline, color: Application().color.white),
        colorText: Application().color.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.primary,
      );

      await createRequest(
        title: title,
        description: description,
        image: fileToDisplay.value!,
        createdAt: DateTime.now(),
      );

      clearForm();
      toggleView(true);
    } else {
      Get.snackbar(
        'Form Incomplete',
        'Please fill all fields and select an image.',
        icon: Icon(Icons.error_outline, color: Application().color.white),
        colorText: Application().color.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.invalid,
      );
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    fileToDisplay.value = null;
  }

  final borderCust = OutlineInputBorder(
    borderSide: BorderSide(color: Application().color.dark, width: 2),
    borderRadius: BorderRadius.circular(5),
  );

  void deleteRequest(BuildContext context, int index) async {
    showConfirmValidation(
      context,
      'Delete Request',
      'Do you want to delete this request?',
      () async {
        Get.back();

        try {
          requests.removeAt(index);

          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final docSnapshot =
                await _firestore.collection('users').doc(user.uid).get();
            if (docSnapshot.exists) {
              final data = docSnapshot.data();
              if (data != null && data.containsKey('RequestList')) {
                List<dynamic> firestoreRequests =
                    List.from(data['RequestList']);
                if (index < firestoreRequests.length) {
                  firestoreRequests.removeAt(index);

                  await _firestore.collection('users').doc(user.uid).update({
                    'RequestList': firestoreRequests,
                  });

                  Get.snackbar(
                    'Success',
                    'Successfully deleted request.',
                    icon: Icon(Icons.delete_outline_outlined,
                        color: Application().color.white),
                    colorText: Application().color.white,
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Application().color.valid,
                  );
                }
              }
            }
          }
        } catch (e) {
          print('Error deleting request: $e');
        }

        update();
      },
      Application().gif.removed,
    );
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
}
