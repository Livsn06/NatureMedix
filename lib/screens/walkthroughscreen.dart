import 'package:flutter/material.dart';

import '../utils/image_paths.dart';

class Walkscreen extends StatelessWidget {
  const Walkscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage(BackgroundImage.path(1)),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                )),
          ),
          child: const Column(
            children: [
              Text(
                'Walkscreen',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
