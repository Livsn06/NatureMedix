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
            'SCANNER',
            style: style.displaySmall(context,
                color: color.white,
                fontsize: setResponsiveSize(context, baseSize: 15),
                fontweight: FontWeight.w500,
                fontspace: 2,
                fontstyle: FontStyle.normal),
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
