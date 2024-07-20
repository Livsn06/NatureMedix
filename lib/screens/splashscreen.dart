import 'package:flutter/material.dart';
import 'package:naturemedix/utils/image_paths.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage(BackgroundImage.path(0)),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7),
                BlendMode.darken,
              )),
        ),
        child: Center(
            child: CircleAvatar(
          radius: screenWidth * 0.15,
          backgroundColor: Colors.black.withOpacity(0.5),
          backgroundImage: AssetImage(Logo.path),
        )),
      ),
    );
  }
}
