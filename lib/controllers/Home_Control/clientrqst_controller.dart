import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturemedix/components/cust_ConfirmAlert.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../../components/cust_imagepick.dart';
import '../../models/client_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientRequestController extends GetxController {
  RxList<ClientData> requests = <ClientData>[].obs;
  var isListVisible = true.obs;
  Box<List<ClientData>>? userRequestBox;

  Rx<File?> fileToDisplay = Rx<File?>(null);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();

    loadRequests();
  }

  // Open a Hive box specific to the user's UID.
  Future<void> openUserBox() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    userRequestBox =
        await Hive.openBox<List<ClientData>>('requests_${user.uid}');
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

    // Save request to Hive and Firestore
    saveRequest(clientData);

    // Add the request to the list
    requests.add(clientData);
  }

  Future<void> saveRequest(ClientData clientData) async {
    if (userRequestBox == null) await openUserBox();
    if (userRequestBox == null) return;

    // Saved data to Hive (Offline)
    List<ClientData>? currentRequests =
        userRequestBox!.get('requests', defaultValue: <ClientData>[]);
    currentRequests?.add(clientData);
    await userRequestBox!.put('requests', currentRequests!);

    // Saved data to Firestore (Online)
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'RequestList': currentRequests.map((value) => value.toMap()).toList(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> loadRequests() async {
    final user = FirebaseAuth.instance.currentUser;

    if (userRequestBox == null) {
      await openUserBox();
    }

    if (userRequestBox == null) {
      return;
    }

    List<ClientData>? currentRequests =
        userRequestBox!.get('requests', defaultValue: <ClientData>[]);

    requests.value = currentRequests!.map((e) => e as ClientData).toList();

    // Load from Firestore (online)
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final docSnapshot =
            await _firestore.collection('users').doc(user!.uid).get();
        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          if (data != null) {
            final firestoreRequests = List.from(data['RequestList'] ?? []);
            // Update requests with Firestore data (if available)
            requests.value =
                firestoreRequests.map((e) => ClientData.fromMap(e)).toList();
          }
        }
      }
    } on SocketException catch (_) {
      // Offline, only load from Hive
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
        'Successfuly submitted',
        'Request submitted successfully!',
        icon: Icon(Icons.error_outline, color: Application().color.white),
        colorText: Application().color.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Application().color.primary,
      );
      // Create and save the request
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

  void clearRequests() {
    requests.clear();
  }

  void deleteRequest(BuildContext context, int index) {
    showConfirmValidation(
      context,
      'Delete Request',
      'Do you want to delete this request?',
      () async {
        final request = requests[index];

        // First, remove the request from the list (frontend)
        requests.removeAt(index);

        // Update Hive if it's not null
        if (userRequestBox != null) {
          // Fetch the current list of requests from the Hive box
          List<ClientData>? currentRequests =
              userRequestBox!.get('requests', defaultValue: <ClientData>[]);

          // Ensure index is within bounds before deleting from the Hive box
          if (currentRequests != null && index < currentRequests.length) {
            // Remove the request at the correct index from the list
            currentRequests.removeAt(index);

            // Now, update the Hive box with the modified list
            await userRequestBox!.put('requests', currentRequests);
          } else {
            print('Invalid index for deletion in Hive box');
          }
        }

        // Delete from Firestore if needed
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          try {
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
                }
              }
            }
          } catch (e) {
            print('Error deleting request from Firestore: $e');
          }
        }

        // Provide feedback to the user and close the dialog
        Get.back();
        Get.snackbar(
          'Success',
          'Successfully deleted request.',
          icon: Icon(Icons.delete_outline_outlined,
              color: Application().color.white),
          colorText: Application().color.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Application().color.valid,
        );
        update();
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
