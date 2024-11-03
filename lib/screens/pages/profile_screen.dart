import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.primary,
                            color.primarylow,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              setResponsiveSize(context, baseSize: 20)),
                          bottomRight: Radius.circular(
                              setResponsiveSize(context, baseSize: 20)),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.78,
                    decoration: BoxDecoration(
                      color: color.white,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(setResponsiveSize(context, baseSize: 180)),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: setResponsiveSize(context, baseSize: 100),
                        decoration: BoxDecoration(
                          color: color.white,
                          borderRadius: BorderRadius.circular(
                              setResponsiveSize(context, baseSize: 15)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gap(setResponsiveSize(context, baseSize: 35)),
                            Text(
                              '${sp.name}',
                              style: style.displaySmall(context,
                                  color: color.primary,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 23),
                                  fontweight: FontWeight.w500,
                                  fontstyle: FontStyle.normal),
                            ),
                            Text(
                              '${sp.email}',
                              style: style.displaySmall(context,
                                  color: color.primary,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 14),
                                  fontweight: FontWeight.w400,
                                  fontstyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -130,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Material(
                            shape: CircleBorder(
                                side: BorderSide(color: color.white, width: 6)),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("${sp.imageUrl}"),
                              radius: setResponsiveSize(context, baseSize: 80),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(setResponsiveSize(context, baseSize: 40)),
                  Material(
                    elevation: setResponsiveSize(context, baseSize: 5),
                    borderRadius: BorderRadius.circular(
                        setResponsiveSize(context, baseSize: 5)),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.zero,
                        color: color.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.profileData.length,
                              itemBuilder: (context, index) {
                                final item = controller.profileData[index];
                                return Card(
                                  color: color.white,
                                  margin: EdgeInsets.symmetric(
                                      vertical: setResponsiveSize(context,
                                          baseSize: 0.5)),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: setResponsiveSize(context,
                                          baseSize: 4),
                                    ),
                                    child: ListTile(
                                      leading: Icon(item['icon']),
                                      title: Text(item['label']),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 13,
                                      ),
                                      onTap: () {
                                        if (item['label'] == 'Logout') {
                                          controller
                                              .showLogoutConfirmation(context);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
