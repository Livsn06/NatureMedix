import 'package:flutter/material.dart';
import 'package:naturemedix/utils/application_constant.dart';
import 'package:naturemedix/utils/image_paths.dart';
import 'package:naturemedix/utils/responsive.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage(Application.image.BG1),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
                BlendMode.darken,
              )),
        ),
        child: Center(
            child: CircleAvatar(
          radius: getResponsiveDefaultSize(context: context, baseSize: 70),
          backgroundColor: Colors.black.withOpacity(0.5),
          backgroundImage: AssetImage(Application.logo),
        )),
      ),
    );
  }
}
