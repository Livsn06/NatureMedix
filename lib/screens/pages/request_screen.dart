import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color.white),
        centerTitle: true,
        backgroundColor: color.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => const ControlScreen(), arguments: 0);
          },
        ),
        title: Text(
          'REQUESTS ',
          style: style.displaySmall(context,
              color: color.white,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w500,
              fontspace: setResponsiveSize(context, baseSize: 2),
              fontstyle: FontStyle.normal),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 20)),
        child: Column(
          children: [
            Obx(() => ToggleButtons(
                  fillColor: color.primary,
                  borderColor: color.primarylow,
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
                          horizontal: setResponsiveSize(context, baseSize: 20)),
                      child: Text(
                        'REQUEST LIST',
                        style: style.displaySmall(
                          context,
                          // Set color based on isSelected value
                          color: controller.isListVisible.value
                              ? color.white
                              : color.primarylow,
                          fontsize: setResponsiveSize(context, baseSize: 12),
                          fontweight: FontWeight.w500,
                          fontspace: setResponsiveSize(context, baseSize: 2),
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: setResponsiveSize(context, baseSize: 20)),
                      child: Text(
                        'CREATE REQUEST',
                        style: style.displaySmall(
                          context,
                          // Set color based on isSelected value
                          color: !controller.isListVisible.value
                              ? color.white
                              : color.primarylow,
                          fontsize: setResponsiveSize(context, baseSize: 12),
                          fontweight: FontWeight.w500,
                          fontspace: 2,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                )),
            Gap(setResponsiveSize(context, baseSize: 10)),
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
                      vertical: setResponsiveSize(context, baseSize: 5)),
                  child: CardList(
                    requestImage: Image.file(File(request['image']),
                        width: 60, height: 60, fit: BoxFit.cover),
                    requestTitle: Text(
                      request['title'],
                      style: style.displaySmall(context,
                          fontsize: setResponsiveSize(context, baseSize: 14),
                          color: color.primarylow,
                          fontweight: FontWeight.w500),
                    ),
                    subRequestTitle:
                        Text(DateFormat.yMMMd().format(request['createdAt'])),
                    settingsTapped: null,
                    deleteTapped: (context) =>
                        controller.deleteRequest(context, index),
                  ));
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
                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: setResponsiveSize(context, baseSize: 180),
                            color: color.lightGrey,
                            child: fileToDisplay != null
                                ? Image.file(fileToDisplay, fit: BoxFit.cover)
                                : Icon(Icons.camera_alt,
                                    size: setResponsiveSize(context,
                                        baseSize: 50),
                                    color: Colors.grey),
                          ),
                          Positioned(
                            bottom: setResponsiveSize(context, baseSize: 2),
                            right: setResponsiveSize(context, baseSize: 2),
                            child: InkWell(
                              onTap: () => controller.pickFile(),
                              child: Material(
                                elevation:
                                    setResponsiveSize(context, baseSize: 3),
                                child: Padding(
                                    padding: EdgeInsets.all(setResponsiveSize(
                                        context,
                                        baseSize: 8)),
                                    child: Icon(Icons.file_upload_outlined,
                                        color: color.primarylow)),
                              ),
                            ),
                          ),
                        ],
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
            '📌 Topic header* ',
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
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Gap(setResponsiveSize(context, baseSize: 20)),

          // Description input field with hint text
          Text(
            '📜 Description* ',
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
              maxLines: 4,
              decoration: InputDecoration(
                fillColor: color.grey,
                filled: true,
                hintText: "What's on your mind...",
                hintStyle: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 13),
                    fontweight: FontWeight.w500,
                    fontstyle: FontStyle.normal),
                border: OutlineInputBorder(),
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
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        setResponsiveSize(context, baseSize: 5)),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  color.primary,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
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
        ],
      ),
    );
  }
}
