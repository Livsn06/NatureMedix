import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../routes/screen_routes.dart';
import '../../utils/_initApp.dart';
import '../../utils/responsive.dart';

class GetstartedScreen extends StatelessWidget with Application {
  GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(color: Color(0xFFF2F7FA)),
          ),
          Align(
            alignment: Alignment(0, setResponsiveSize(context, baseSize: 0.15)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: setResponsiveSize(context, baseSize: 18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(setResponsiveSize(context, baseSize: 20)),
                  Text('NATUREMEDIX',
                      style: style.displayLarge(context,
                          color: color.primarylow, fontspace: 3, fontsize: 25)),
                  Gap(setResponsiveSize(context, baseSize: 15)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: setResponsiveSize(context, baseSize: 18)),
                    child: Text(
                      '“Explore herbal plants and discover natural remedies to enhance your health and overall well-being.”',
                      textAlign: TextAlign.center,
                      style: style.TitleMedium(context,
                          color: color.primarylow, fontsize: 16),
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 20)),
                  Image.asset(
                    image.BG5,
                    fit: BoxFit.cover,
                    scale: setResponsiveSize(context, baseSize: 0.1),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 30)),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(
                            setResponsiveSize(context, baseSize: 3)),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 10)))),
                        backgroundColor:
                            WidgetStatePropertyAll(color.primarylow)),
                    onPressed: () => Get.toNamed(ScreenRouter.getLoginRoute),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: setResponsiveSize(context, baseSize: 13)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                            style: style.buttonText(context,
                                color: color.white,
                                fontspace: 1.5,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SlideAction(
                  //   sliderButtonIconPadding:
                  //       setResponsiveSize(context, baseSize: 10),
                  //   height: setResponsiveSize(context, baseSize: 55),
                  //   borderRadius: setResponsiveSize(context, baseSize: 10),
                  //   elevation: setResponsiveSize(context, baseSize: 5),
                  //   innerColor: color.white,
                  //   outerColor: color.primarylow,
                  //   text: 'LOGIN',
                  //   textStyle: style.buttonText(context,
                  //       color: color.white,
                  //       fontspace: 3.0,
                  //       fontsize: setResponsiveSize(context, baseSize: 15)),
                  //   onSubmit: () => Get.toNamed(ScreenRouter.getLoginRoute),
                  // ),
                  Gap(setResponsiveSize(context, baseSize: 15)),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(
                            setResponsiveSize(context, baseSize: 3)),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          side: BorderSide(color: color.primarylow, width: 1),
                          borderRadius: BorderRadius.circular(
                              setResponsiveSize(context, baseSize: 10)),
                        )),
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xFFF2F7FA))),
                    onPressed: () => Get.toNamed(ScreenRouter.getRegisterRoute),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: setResponsiveSize(context, baseSize: 13)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'REGISTER',
                            textAlign: TextAlign.center,
                            style: style.buttonText(context,
                                color: color.primarylow,
                                fontspace: 1.5,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 50)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
