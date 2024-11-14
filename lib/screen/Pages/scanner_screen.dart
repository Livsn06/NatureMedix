import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naturemedix/utils/_initApp.dart';

import '../../utils/responsive.dart';
import 'control_screen.dart';

class ScannerScreen extends StatefulWidget with Application {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with Application {
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
              onTap: () =>  Get.offAll(() => const ControlScreen(), arguments: 0),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: color.white,
                size: setResponsiveSize(context, baseSize: 18),
              ),
            ),
            title: Text(
              'SCANNER',
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
        body: Center(
          child: Icon(
            Icons.camera_rear_outlined,
            color: color.lightGrey,
            size: setResponsiveSize(context, baseSize: 100),
          ),
        ));
  }
}
