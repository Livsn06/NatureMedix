import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:naturemedix/themes/color_styles.dart';
import 'package:naturemedix/themes/text_styles.dart';
import 'package:naturemedix/utils/application_constant.dart';
import 'package:naturemedix/utils/image_paths.dart';
import 'package:naturemedix/utils/responsive.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsivePaddingSize(
                context: context,
                basePadding: 18,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: getResponsiveDefaultSize(
                    context: context,
                    baseSize: 70,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.5),
                  backgroundImage: AssetImage(Application.logo),
                ),
                Gap(getResponsiveDefaultSize(context: context, baseSize: 15)),
                Text(
                  Application.name,
                  style: ApplicationTextStyle.headlineLarge(
                    context: context,
                    color: AppColor.style.white,
                  ),
                ),
                Gap(getResponsiveDefaultSize(context: context, baseSize: 25)),
                Text(
                  'Explore herbal plants and discover natural remedies for better health',
                  textAlign: TextAlign.center,
                  style: ApplicationTextStyle.TitleMedium(
                    context: context,
                    color: AppColor.style.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
