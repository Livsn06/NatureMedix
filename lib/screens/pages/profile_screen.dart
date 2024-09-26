import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/utils/_initApp.dart';

import '../../controllers/Home_Control/profile_controller.dart';
import '../../utils/responsive.dart';
import 'control_screen.dart';

class ProfileScreen extends StatefulWidget with Application {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Application {
  final ProfileController controller = Get.put(ProfileController());

  final currentUser = FirebaseAuth.instance.currentUser!;

  // Declare `profileData` as an instance variable
  List<Map<String, dynamic>> profileData = [];

  @override
  void initState() {
    super.initState();

    // Initialize the profile data
    profileData = [
      {'icon': Icons.edit, 'label': 'Edit Profile Name', 'action': () {}},
      {'icon': Icons.history, 'label': 'History', 'action': () {}},
      {'icon': Icons.lock, 'label': 'Change Password', 'action': () {}},
      {'icon': Icons.email, 'label': 'Change Email Address', 'action': () {}},
      {'icon': Icons.settings, 'label': 'Settings', 'action': () {}},
      {'icon': Icons.logout, 'label': 'Logout', 'action': () {}},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.primaryhigh,
      appBar: AppBar(
        iconTheme: IconThemeData(color: color.white),
        backgroundColor: color.primaryhigh,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => const ControlScreen(), arguments: 0);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final userdata = snapshot.data?.data();
            if (userdata != null) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: BoxDecoration(
                          color: color.primaryhigh,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.80,
                        decoration: BoxDecoration(
                          color: color.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(setResponsiveSize(context, baseSize: 130)),
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
                                  ' ${userdata['Name']}',
                                  style: style.displaySmall(context,
                                      color: color.primary,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 30),
                                      fontweight: FontWeight.w500,
                                      fontstyle: FontStyle.normal),
                                ),
                                Text(
                                  ' ${userdata['Email']}',
                                  style: style.displaySmall(context,
                                      color: color.primary,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 16),
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
                                    side: BorderSide(
                                        color: color.white, width: 6)),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(image.BG5),
                                  radius:
                                      setResponsiveSize(context, baseSize: 80),
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
                                  itemCount: profileData.length,
                                  itemBuilder: (context, index) {
                                    final item = profileData[index];
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
                                              controller.showLogoutConfirmation(
                                                  context);
                                            } else {
                                              // Handle other actions
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
                      )
                    ],
                  ),
                ],
              );
            } else {
              return const Text('Error: No data available');
            }
          } else {
            return const Text('Error: Unknown state');
          }
        },
      ),
    );
  }
}
