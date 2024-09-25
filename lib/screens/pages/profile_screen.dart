import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/utils/_initApp.dart';

import '../../utils/responsive.dart';
import 'control_screen.dart';

class ProfileScreen extends StatefulWidget with Application {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Application {
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
          'PROFILE',
          style: style.displaySmall(context,
              color: color.white,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w500,
              fontspace: 2,
              fontstyle: FontStyle.normal),
        ),
      ),
      body: Center(
        child: Text(
          'This is profile screen',
          style: style.displaySmall(context,
              color: color.primarylow,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w400,
              fontstyle: FontStyle.normal),
        ),
      ),
    );
  }
}
