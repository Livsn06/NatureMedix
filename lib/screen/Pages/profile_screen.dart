import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/routes/screen_routes.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../../controllers/Auth_Control/login_controller.dart';
import '../../controllers/Home_Control/profile_controller.dart';
import '../../utils/responsive.dart';
import 'control_screen.dart';

class ProfileScreen extends StatefulWidget with Application {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Application {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
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
                    Get.offAll(() => const ControlScreen(), arguments: 0),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: color.white,
                  size: setResponsiveSize(context, baseSize: 18),
                ),
              ),
              title: Text(
                'PROFILE',
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
          body: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.all(setResponsiveSize(context, baseSize: 10)),
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 20)),
                      elevation: setResponsiveSize(context, baseSize: 3),
                      child: Container(
                        height: setResponsiveSize(context, baseSize: 160),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  setResponsiveSize(context, baseSize: 20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Material(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        color: color.light, width: 3)),
                                child: CircleAvatar(
                                  backgroundColor: color.grey,
                                  backgroundImage: sp.imageUrl == null
                                      ? controller.fileToDisplay.value != null
                                          ? Image.file(
                                                  controller.fileToDisplay.value
                                                      as File,
                                                  fit: BoxFit.cover)
                                              as ImageProvider<Object>?
                                          : null
                                      : sp.imageUrl!.startsWith('http')
                                          ? NetworkImage("${sp.imageUrl}")
                                              as ImageProvider<Object>?
                                          : AssetImage("${sp.imageUrl}")
                                              as ImageProvider<Object>?,
                                  radius:
                                      setResponsiveSize(context, baseSize: 45),
                                ),
                              ),
                              Gap(setResponsiveSize(context, baseSize: 20)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    sp.name?.toUpperCase() ?? 'No Name',
                                    style: style.smallText(context,
                                        color: color.white,
                                        fontsize: setResponsiveSize(context,
                                            baseSize: 18),
                                        fontweight: FontWeight.w600,
                                        fontspace: 1),
                                  ),
                                  Gap(setResponsiveSize(context, baseSize: 2)),
                                  Text(
                                    '${sp.email}',
                                    style: style.displaySmall(context,
                                        color: color.white,
                                        fontsize: setResponsiveSize(context,
                                            baseSize: 12),
                                        fontweight: FontWeight.w400,
                                        fontstyle: FontStyle.italic),
                                  ),
                                  Gap(setResponsiveSize(context, baseSize: 5)),
                                  ElevatedButton(
                                    onPressed: () => Get.toNamed(
                                        ScreenRouter.getViewProfileRoute),
                                    style: ButtonStyle(
                                      elevation: WidgetStateProperty.all(2),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              color.primary),
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: color.white,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              setResponsiveSize(context,
                                                  baseSize: 6)),
                                        ),
                                      ),
                                      padding: WidgetStatePropertyAll(
                                          EdgeInsets.symmetric(
                                              horizontal: setResponsiveSize(
                                                  context,
                                                  baseSize: 15),
                                              vertical: setResponsiveSize(
                                                  context,
                                                  baseSize: 6))),
                                    ),
                                    child: Text(
                                      'View Profile',
                                      style: style.smallText(context,
                                          color: color.white,
                                          fontsize: setResponsiveSize(context,
                                              baseSize: 13),
                                          fontweight: FontWeight.w600,
                                          fontspace: 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sp.provider == "GOOGLE"
                      ? controller.GoogleData.length
                      : controller.EmailData.length,
                  itemBuilder: (context, index) {
                    final item = sp.provider == 'GOOGLE'
                        ? controller.GoogleData[index]
                        : controller.EmailData[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: setResponsiveSize(context, baseSize: 10),
                        vertical: setResponsiveSize(context, baseSize: 3),
                      ),
                      elevation: 3,
                      color: color.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: setResponsiveSize(context, baseSize: 8),
                        ),
                        child: ListTile(
                          leading: Material(
                            color: color.primary,
                            borderRadius: BorderRadius.circular(
                                setResponsiveSize(context, baseSize: 8)),
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      setResponsiveSize(context, baseSize: 13),
                                  vertical:
                                      setResponsiveSize(context, baseSize: 13)),
                              child: Icon(
                                item['icon'],
                                color: color.white,
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    setResponsiveSize(context, baseSize: 2)),
                            child: Text(' ${item['label']}'),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 13,
                          ),
                          onTap: item['action'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
