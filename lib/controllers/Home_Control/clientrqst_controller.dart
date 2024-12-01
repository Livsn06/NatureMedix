// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/client_data.dart';
import '../../components/cust_imagepick.dart';
import '../../components/cust_ConfirmAlert.dart';
import '../../utils/_initApp.dart';

class ClientRequestController extends GetxController {
  RxList<ClientData> requests = <ClientData>[].obs;
  var isListVisible = true.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Box? userBox;

  @override
  void onInit() {
    super.onInit();
    loadRequests();
  }

  final indexImage = 0.obs;
  final ImagePicker _picker = ImagePicker();
  var selectedFiles = <File>[].obs;
  var imagesData =
      <Map<String, dynamic>>[].obs; // Stores image data (bytes and size)

  Future<void> pickImages() async {
    try {
      // Clear the previously selected files to remove the preview
      selectedFiles.clear();

      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages != null) {
        List<Map<String, dynamic>> imagesDataList = [];

        // Check if exactly one image is selected
        if (selectedImages.length == 1) {
          // Save single image as usual
          File file = File(selectedImages.first.path);
          Uint8List imageBytes = await file.readAsBytes();
          int sizeInBytes = imageBytes.length;
          double sizeInKB = sizeInBytes / 1024;

          imagesDataList.add({
            "bytes": imageBytes,
            "size": sizeInKB.toStringAsFixed(2), // Size in KB
            "file": file,
          });

          // Update the selected files with a single image
          selectedFiles.value = [file];
        } else if (selectedImages.length > 1) {
          // Handle multiple image selection
          for (var image in selectedImages) {
            File file = File(image.path);
            Uint8List imageBytes = await file.readAsBytes();
            int sizeInBytes = imageBytes.length;
            double sizeInKB = sizeInBytes / 1024;

            imagesDataList.add({
              "bytes": imageBytes,
              "size": sizeInKB.toStringAsFixed(2), // Size in KB
              "file": file,
            });
          }

          // Update the selected files with all selected images
          selectedFiles.value =
              imagesDataList.map((e) => e["file"] as File).toList();
        }

        imagesData.value = imagesDataList; // Update image data list
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  void toggleView(bool showList) {
    isListVisible.value = showList;
  }

  // Create a new request
  Future<void> createRequest({
    required String title,
    required String description,
    required List<File> images,
    required DateTime createdAt,
  }) async {
    var clientData = ClientData(
      title: title,
      description: description,
      imagePaths: images.map((image) => image.path).toList(),
      createdAt: createdAt,
    );

    // Save request to Firestore and Hive
    await saveRequest(clientData);
    requests.add(clientData);
  }

  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    userBox = await Hive.openBox(user.uid);
  }

  Future<void> saveRequest(ClientData clientData) async {
    if (userBox == null) await openUserBox();
    if (userBox == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userBox = await Hive.openBox('userRequests');
      List<dynamic> userRequests = userBox.get(user.uid, defaultValue: []);
      userRequests.add(clientData.toMap());
      await userBox.put(user.uid, userRequests);

      print("Request saved locally in Hive for user ${user.uid}");

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
          List<dynamic> userRequestsMap =
              userBox!.get(user.uid, defaultValue: []);
          if (userRequestsMap.isNotEmpty) {
            requests.addAll(
                userRequestsMap.map((e) => ClientData.fromMap(e)).toList());
          }

          final docSnapshot =
              await _firestore.collection('users').doc(user.uid).get();
          if (docSnapshot.exists) {
            final data = docSnapshot.data();
            if (data != null && data.containsKey('RequestList')) {
              final firestoreRequests =
                  List<Map<String, dynamic>>.from(data['RequestList'] ?? []);
              final firestoreRequestData =
                  firestoreRequests.map((e) => ClientData.fromMap(e)).toList();

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
    required List<File> images,
  }) {
    return title.isNotEmpty && description.isNotEmpty && images.isNotEmpty;
  }

  void submitRequest(BuildContext context) async {
    final title = titleController.text;
    final description = descriptionController.text;

    if (validateRequest(
      title: title,
      description: description,
      images: selectedFiles,
    )) {
      Get.snackbar(
        'Success',
        'Request submitted successfully!',
        icon: Icon(Icons.check_circle, color: Application().color.white),
        colorText: Application().color.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.primary,
      );

      await createRequest(
        title: title,
        description: description,
        images: selectedFiles,
        createdAt: DateTime.now(),
      );

      clearForm();
      toggleView(true);
    } else {
      Get.snackbar(
        'Form Incomplete',
        'Please fill all fields and select at least three image.',
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
    selectedFiles.clear();
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
      BuildContext context, Function(XFile?) onCaptureImage) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onCaptureImage: onCaptureImage,
          onSelectMultiple: () => pickImages(),
        );
      },
    );
  }
}
