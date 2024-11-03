import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:naturemedix/controllers/Home_Control/clientrqst_controller.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../../components/cust_tilelist.dart';
import '../../utils/responsive.dart';
import 'control_screen.dart';

class RequestScreen extends StatefulWidget with Application {
  RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> with Application {
  final ClientRequestController controller = Get.put(ClientRequestController());

  @override
  void initState() {
    super.initState();
    controller.openUserBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.light,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          iconTheme: IconThemeData(color: color.primary),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.primary,
                  color.primarylow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: InkWell(
            onTap: () => Get.offAll(() => const ControlScreen(), arguments: 0),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: color.white,
              size: setResponsiveSize(context, baseSize: 18),
            ),
          ),
          title: Text(
            'REQUEST',
            style: style.displaySmall(
              context,
              color: color.white,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w500,
              fontspace: 2,
              fontstyle: FontStyle.normal,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 20)),
        child: Column(
          children: [
            Material(
              elevation: setResponsiveSize(context, baseSize: 3),
              child: Container(
                color: color.white,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Obx(() => ToggleButtons(
                        fillColor: color.primary,
                        borderColor: color.white,
                        isSelected: [
                          controller.isListVisible.value,
                          !controller.isListVisible.value
                        ],
                        onPressed: (index) {
                          controller.toggleView(index == 0);
                        },
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    setResponsiveSize(context, baseSize: 20)),
                            child: Text(
                              'REQUEST LIST',
                              style: style.displaySmall(
                                context,
                                // Set color based on isSelected value
                                color: controller.isListVisible.value
                                    ? color.white
                                    : color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 12),
                                fontweight: FontWeight.w500,
                                fontspace:
                                    setResponsiveSize(context, baseSize: 2),
                                fontstyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    setResponsiveSize(context, baseSize: 20)),
                            child: Text(
                              'CREATE REQUEST',
                              style: style.displaySmall(
                                context,
                                // Set color based on isSelected value
                                color: !controller.isListVisible.value
                                    ? color.white
                                    : color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 12),
                                fontweight: FontWeight.w500,
                                fontspace: 2,
                                fontstyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Obx(() {
              return controller.isListVisible.value
                  ? Column(
                      children: [
                        Gap(setResponsiveSize(context, baseSize: 20)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '▣ Client request list:',
                            style: style.displaySmall(
                              context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 15),
                              fontweight: FontWeight.w500,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    )
                  : Gap(setResponsiveSize(context, baseSize: 10));
            }),
            Expanded(
              child: Obx(() {
                return controller.isListVisible.value
                    ? _buildRequestListView(context)
                    : _buildCreateRequestView(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the list view of requests
  Widget _buildRequestListView(BuildContext context) {
    return controller.requests.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  gif.notFound,
                  scale: setResponsiveSize(context, baseSize: 2),
                ),
                Text(
                  'No request found',
                  style: style.displaySmall(context,
                      fontsize: setResponsiveSize(context, baseSize: 14),
                      color: color.darkGrey),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              final request = controller.requests[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: setResponsiveSize(context, baseSize: 2)),
                child: CardList(
                  requestImage: Image.file(File(request.imagePath),
                      width: 60, height: 60, fit: BoxFit.cover),
                  requestTitle: Text(
                    request.title,
                    style: style.displaySmall(context,
                        fontsize: setResponsiveSize(context, baseSize: 14),
                        color: color.primarylow,
                        fontweight: FontWeight.w500),
                  ),
                  subRequestTitle:
                      Text(DateFormat.yMMMd().format(request.createdAt)),
                  settingsTapped: null,
                  deleteTapped: (context) =>
                      controller.deleteRequest(context, index),
                ),
              );
            },
          );
  }

  // Widget to build the create request form
  Widget _buildCreateRequestView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(setResponsiveSize(context, baseSize: 15)),
          // Display the selected image or a placeholder
          NeoBox(
            borderRadius:
                BorderRadius.circular(setResponsiveSize(context, baseSize: 0)),
            child: Padding(
              padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        setResponsiveSize(context, baseSize: 10)),
                    child: Obx(() {
                      final fileToDisplay = controller.fileToDisplay.value;
                      return InkWell(
                        onTap: () =>
                            controller.showImagePicker(context, (XFile? image) {
                          if (image != null) {
                            controller.fileToDisplay.value = File(image.path);
                          }
                        }),
                        child: Container(
                          width: double.infinity,
                          height: setResponsiveSize(context, baseSize: 200),
                          color: color.lightGrey,
                          child: fileToDisplay != null
                              ? Image.file(fileToDisplay, fit: BoxFit.cover)
                              : Icon(Icons.camera_alt,
                                  size:
                                      setResponsiveSize(context, baseSize: 50),
                                  color: color.white),
                        ),
                      );
                    }),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 5)),
                ],
              ),
            ),
          ),

          Gap(setResponsiveSize(context, baseSize: 20)),

          // Title input field
          Text(
            '▣ Topic header* ',
            style: style.displaySmall(
              context,
              fontsize: setResponsiveSize(context, baseSize: 14),
              color: color.darkGrey,
              fontweight: FontWeight.w500,
            ),
          ),
          Gap(setResponsiveSize(context, baseSize: 5)),

          Material(
            elevation: setResponsiveSize(context, baseSize: 3),
            child: TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 13),
                    fontweight: FontWeight.w500,
                    fontstyle: FontStyle.normal),
                border: controller.borderCust,
              ),
            ),
          ),
          Gap(setResponsiveSize(context, baseSize: 20)),

          // Description input field with hint text
          Text(
            '▣ Description* ',
            style: style.displaySmall(
              context,
              fontsize: setResponsiveSize(context, baseSize: 14),
              color: color.darkGrey,
              fontweight: FontWeight.w500,
            ),
          ),
          Gap(setResponsiveSize(context, baseSize: 5)),
          Material(
            elevation: setResponsiveSize(context, baseSize: 3),
            child: TextField(
              controller: controller.descriptionController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Describe your herbal plant request...",
                hintStyle: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 13),
                    fontweight: FontWeight.w500,
                    fontstyle: FontStyle.normal),
                border: controller.borderCust,
              ),
            ),
          ),
          Gap(setResponsiveSize(context, baseSize: 20)),

          // Submit request button
          ElevatedButton(
            onPressed: () => controller.submitRequest(context),
            style: ButtonStyle(
                elevation: WidgetStatePropertyAll(
                    setResponsiveSize(context, baseSize: 3)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        setResponsiveSize(context, baseSize: 5)),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  color.primary,
                ),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                    vertical: setResponsiveSize(context, baseSize: 13),
                  ),
                )),
            child: Text(
              'Submit Request',
              style: style.displaySmall(context,
                  color: color.white,
                  fontsize: setResponsiveSize(context, baseSize: 14),
                  fontweight: FontWeight.w500,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Gap(setResponsiveSize(context, baseSize: 100)),
        ],
      ),
    );
  }
}
