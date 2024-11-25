import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:naturemedix/controllers/Auth_Control/login_controller.dart';
import 'package:naturemedix/controllers/Home_Control/profile_controller.dart';
import 'package:naturemedix/screen/Pages/control_screen.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with Application {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return GetBuilder<LoginController>(
      init: Get.put(LoginController()),
      builder: (sp) {
        sp.getDataFromSharedPreferences();
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
                onTap: () =>
                    Get.offAll(() => const ControlScreen(), arguments: 4),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: color.white,
                  size: setResponsiveSize(context, baseSize: 18),
                ),
              ),
              title: Text(
                'EDIT PROFILE'.toUpperCase(),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: setResponsiveSize(context, baseSize: 3),
                    borderRadius: BorderRadius.circular(
                      setResponsiveSize(context, baseSize: 20),
                    ),
                    child: Container(
                      height: setResponsiveSize(context, baseSize: 180),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: color.light, width: 5),
                        borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 20),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            color.primary,
                            color.primarylow,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: sp.provider == 'GOOGLE'
                                ? null // Disable image selection if provider is GOOGLE
                                : () => profileController.showImage(context,
                                        (XFile? image) {
                                      if (image != null) {
                                        profileController.fileToDisplay.value =
                                            File(image.path);
                                        setState(() {});
                                      }
                                    }),
                            child: Material(
                              shape: CircleBorder(
                                  side:
                                      BorderSide(color: color.light, width: 4)),
                              child: CircleAvatar(
                                backgroundColor: color.grey,
                                backgroundImage: sp.provider == 'GOOGLE'
                                    ? (sp.imageUrl != null &&
                                            sp.imageUrl!.startsWith('http')
                                        ? NetworkImage(sp.imageUrl!)
                                            as ImageProvider<Object>
                                        : null)
                                    : (profileController.fileToDisplay.value !=
                                            null
                                        ? FileImage(profileController
                                            .fileToDisplay.value!)
                                        : null),
                                radius:
                                    setResponsiveSize(context, baseSize: 45),
                              ),
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          Text(
                            sp.name?.toUpperCase() ?? 'No Name',
                            style: style.smallText(context,
                                color: color.white,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 18),
                                fontweight: FontWeight.w600,
                                fontspace: 1),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 2)),
                          Text(
                            '${sp.email}',
                            style: style.displaySmall(context,
                                color: color.white,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 12),
                                fontweight: FontWeight.w400,
                                fontstyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: setResponsiveSize(context, baseSize: 15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(setResponsiveSize(context, baseSize: 20)),
                        Text(
                          '▣ personal Information'.toUpperCase(),
                          style: style.smallText(context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 14),
                              fontweight: FontWeight.w600,
                              fontspace: 1),
                        ),
                        const Divider(),
                        Gap(setResponsiveSize(context, baseSize: 10)),
                        TextFormField(
                          controller: profileController.name,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: sp.name ?? 'Enter your name',
                            hintStyle: TextStyle(
                              color: color.darkGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            border: sp.borderCust,
                            enabledBorder: sp.borderCust,
                            focusedBorder: sp.borderCust,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: color.primarylow,
                              size: setResponsiveSize(context, baseSize: 20),
                            ),
                          ),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        TextFormField(
                          controller: profileController.email,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: sp.email,
                              hintStyle: TextStyle(
                                  color: color.darkGrey,
                                  fontWeight: FontWeight.w500),
                              border: sp.borderCust,
                              enabledBorder: sp.borderCust,
                              focusedBorder: sp.borderCust,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: color.primarylow,
                                size: setResponsiveSize(context, baseSize: 20),
                              )),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        TextFormField(
                          controller: profileController.address,
                          readOnly: false,
                          decoration: InputDecoration(
                              hintText: 'Enter address',
                              hintStyle: TextStyle(
                                  color: color.darkGrey,
                                  fontWeight: FontWeight.w500),
                              border: sp.borderCust,
                              enabledBorder: sp.borderCust,
                              focusedBorder: sp.borderCust,
                              prefixIcon: Icon(
                                Icons.pin_drop_outlined,
                                color: color.primarylow,
                                size: setResponsiveSize(context, baseSize: 20),
                              )),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        TextFormField(
                          controller: profileController.birthdate,
                          readOnly: false,
                          decoration: InputDecoration(
                            hintText: 'Select birthdate',
                            hintStyle: TextStyle(
                                color: color.darkGrey,
                                fontWeight: FontWeight.w500),
                            border: sp.borderCust,
                            enabledBorder: sp.borderCust,
                            focusedBorder: sp.borderCust,
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: color.primarylow,
                              size: setResponsiveSize(context, baseSize: 20),
                            ),
                          ),
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              profileController.birthdate.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            }
                          },
                        ),
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        TextFormField(
                          controller: profileController.phoneNumber,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                  color: color.darkGrey,
                                  fontWeight: FontWeight.w500),
                              border: sp.borderCust,
                              enabledBorder: sp.borderCust,
                              focusedBorder: sp.borderCust,
                              prefixIcon: Icon(
                                Icons.call_outlined,
                                color: color.primarylow,
                                size: setResponsiveSize(context, baseSize: 20),
                              )),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        TextFormField(
                          controller: profileController.gender,
                          readOnly: false,
                          decoration: InputDecoration(
                            hintText: 'Enter gender',
                            hintStyle: TextStyle(
                              color: color.darkGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            border: sp.borderCust,
                            enabledBorder: sp.borderCust,
                            focusedBorder: sp.borderCust,
                            prefixIcon: Icon(
                              Icons
                                  .transgender, // Use the person icon for gender
                              color: color.primarylow,
                              size: setResponsiveSize(context, baseSize: 20),
                            ),
                          ),
                        ),
                        Gap(setResponsiveSize(context, baseSize: 15)),
                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: WidgetStatePropertyAll(
                                  setResponsiveSize(context, baseSize: 3)),
                              shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          setResponsiveSize(context,
                                              baseSize: 7)))),
                              backgroundColor:
                                  WidgetStatePropertyAll(color.primarylow)),
                          onPressed: () =>
                              profileController.updateUserProfile(sp.uid!),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    setResponsiveSize(context, baseSize: 12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SAVED UPDATE',
                                  textAlign: TextAlign.center,
                                  style: style.buttonText(context,
                                      color: color.white,
                                      fontspace: 1.5,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
