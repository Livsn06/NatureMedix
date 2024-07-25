import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:naturemedix/providers/walkthrough_provider.dart';
import 'package:naturemedix/themes/button_styles.dart';
import 'package:naturemedix/themes/color_styles.dart';
import 'package:naturemedix/themes/text_styles.dart';
import 'package:naturemedix/components/indicator.dart';
import 'package:provider/provider.dart';

import '../../utils/responsive.dart';

class Featurescreen extends StatefulWidget {
  const Featurescreen({super.key});

  @override
  State<Featurescreen> createState() => _FeaturescreenState();
}

var pageController = PageController(initialPage: 0);

class _FeaturescreenState extends State<Featurescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<WalkthroughProvider>(
              builder: (context, provide, child) {
                return PageView.builder(
                  allowImplicitScrolling: false,
                  controller: pageController,
                  itemCount: provide.maxPage,
                  onPageChanged: (value) {
                    setState(() {
                      provide.page = value;
                    });
                  },
                  itemBuilder: (context, index) => const ApplicationFeature(),
                );
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Appname_and_Skip(controller: pageController),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Indicator_and_Next(controller: pageController),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class Appname_and_Skip extends StatelessWidget {
  const Appname_and_Skip({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<WalkthroughProvider>(
      builder: (context, provide, child) {
        return Padding(
          padding: EdgeInsets.all(
            getResponsivePaddingSize(context: context, basePadding: 18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NATUREMEDIX',
                style: ApplicationTextStyle.TitleMedium(
                  context: context,
                  color: AppColor.style.white,
                ),
              ),
              InkWell(
                splashColor: Colors.amber,
                focusColor: Colors.red,
                onTap: () {
                  provide.skipAll(controller);
                },
                child: Text(
                  'SKIP',
                  textAlign: TextAlign.right,
                  style: ApplicationTextStyle.TitleMedium(
                    context: context,
                    color: AppColor.style.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ApplicationFeature extends StatelessWidget {
  const ApplicationFeature({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<WalkthroughProvider>(
      builder: (context, provide, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: screenSize.width,
          height: screenSize.height,
          padding: EdgeInsets.all(
            getResponsivePaddingSize(
              context: context,
              basePadding: 18,
            ),
          ),
          decoration: imageDecoration(provide.feature.backgroundImageAsset),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                splitTitle(provide.feature.title, 0),
                style: ApplicationTextStyle.displayLarge(
                  context: context,
                  color: AppColor.style.white,
                ),
              ),
              Text(
                splitTitle(provide.feature.title, 1),
                style: ApplicationTextStyle.displayLarge(
                    context: context, color: AppColor.style.white),
              ),
              Divider(
                color: AppColor.style.white,
                thickness: getResponsiveDefaultSize(
                  context: context,
                  baseSize: 2,
                ),
                height: getResponsiveDefaultSize(
                  context: context,
                  baseSize: 0,
                ),
              ),
              const Gap(14),
              Text(
                provide.feature.subtitles,
                style: ApplicationTextStyle.TitleMedium(
                  context: context,
                  color: AppColor.style.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String splitTitle(String title, int index) {
    return title.split(' ')[index];
  }

  BoxDecoration imageDecoration(String backgroundImageAsset) {
    return BoxDecoration(
      image: DecorationImage(
        alignment: Alignment.center,
        image: AssetImage(backgroundImageAsset),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          AppColor.style.darkOpacity70,
          BlendMode.darken,
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class Indicator_and_Next extends StatelessWidget {
  const Indicator_and_Next({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<WalkthroughProvider>(
      builder: (context, provide, child) {
        return Padding(
          padding: EdgeInsets.all(getResponsivePaddingSize(
            context: context,
            basePadding: 18,
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAnimatedIndicator(
                initial: provide.initialPage,
                count: provide.maxPage,
                curve: Curves.bounceInOut,
                duration: Durations.medium2,
                gap: getResponsiveDefaultSize(context: context, baseSize: 4),
                activeColor: AppColor.style.primary,
                size: Size(
                  getResponsiveDefaultSize(context: context, baseSize: 12),
                  getResponsiveDefaultSize(context: context, baseSize: 12),
                ),
                activeWidth:
                    getResponsiveDefaultSize(context: context, baseSize: 2.5),
              ),
              IconButton(
                style: ApplicationButtonStyle.button1(
                  size: Size(
                    getResponsiveDefaultSize(context: context, baseSize: 50),
                    getResponsiveDefaultSize(context: context, baseSize: 50),
                  ),
                  backgroundColor: AppColor.style.whiteOpacity20,
                  borderWidth: 1.5,
                  borderColor: AppColor.style.white,
                  radius:
                      getResponsiveDefaultSize(context: context, baseSize: 10),
                ),
                onPressed: () {
                  provide.nextPage(controller);
                },
                icon: const Icon(Icons.arrow_forward_ios),
                color: AppColor.style.white,
              )
            ],
          ),
        );
      },
    );
  }
}
