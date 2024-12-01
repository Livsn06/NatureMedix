import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/cust_chatbox.dart';
import 'package:naturemedix/controllers/PlantInfo_Control/plantInfos_controller.dart';
import 'package:naturemedix/models/remedy_info.dart';
import 'package:naturemedix/controllers/Home_Control/bookmark_controller.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class RemedyInfoScreen extends StatefulWidget {
  final RemedyInfo remedy;
  const RemedyInfoScreen({super.key, required this.remedy});

  @override
  State<RemedyInfoScreen> createState() => _RemedyInfoScreenState();
}

class _RemedyInfoScreenState extends State<RemedyInfoScreen> with Application {
  final PageController _pageController = PageController(initialPage: 0);
  final PlantInfoController plantInfoController =
      Get.put(PlantInfoController());

  void _submitRating(double rating) async {
    await plantInfoController.saveRating(widget.remedy.remedyName, rating);
    plantInfoController.updateRemedyRating(widget.remedy.remedyName, rating);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
      init: Get.put(BookmarkController()),
      builder: (controller) {
        return Scaffold(
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
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: color.white,
                  size: setResponsiveSize(context, baseSize: 18),
                ),
              ),
              title: Text(
                'REMEDY INFO',
                style: style.InterSmallText(
                  context,
                  color: color.white,
                  fontsize: setResponsiveSize(context, baseSize: 14),
                  fontweight: FontWeight.w500,
                  fontspace: 2,
                  fontstyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          backgroundColor: color.darklight,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          setResponsiveSize(context, baseSize: 20)),
                      child: SizedBox(
                        height: setResponsiveSize(context, baseSize: 250),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.remedy.remedyImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NeoBox(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 5)),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 12)),
                                  child: Image.asset(
                                    widget.remedy.remedyImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: color.white,
                  padding:
                      EdgeInsets.all(setResponsiveSize(context, baseSize: 20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.remedy.remedyName,
                            style: style.InterSmallText(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 20),
                                fontweight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Gap(setResponsiveSize(context, baseSize: 5)),
                      Obx(() {
                        return Row(
                          children: [
                            for (int i = 1; i <= 5; i++)
                              Icon(
                                Icons.star,
                                color: i <=
                                        (plantInfoController
                                                .overallRatingForRemedy[
                                                    widget.remedy.remedyName]
                                                ?.value ??
                                            0)
                                    ? color.warning
                                    : color.darkGrey,
                                size: setResponsiveSize(context, baseSize: 17),
                              ),
                            Gap(setResponsiveSize(context, baseSize: 10)),
                            Text(
                              '${plantInfoController.overallRatingForRemedy[widget.remedy.remedyName]?.value ?? 0.0}',
                              style: style.InterSmallText(
                                context,
                                color: color.primary,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 14),
                                fontweight: FontWeight.w500,
                                fontstyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        );
                      }),
                      const Divider(),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text(
                        'Remedy type: ${widget.remedy.remedyType}',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w500,
                            fontstyle: FontStyle.italic),
                      ),
                      Text(
                        'Treatment: ${widget.remedy.treatment}',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w500,
                            fontstyle: FontStyle.italic),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ DESCRIPTION:',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text(
                        widget.remedy.description,
                        textAlign: TextAlign.justify,
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w500),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '▣ INGREDIENTS:',
                            style: style.InterSmallText(
                              context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 14),
                              fontweight: FontWeight.w700,
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          ...widget.remedy.ingredients.map((ingredient) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '□ $ingredient',
                                style: style.InterSmallText(
                                  context,
                                  color: color.primarylow,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 14),
                                  fontweight: FontWeight.w500,
                                  height: 1.8,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '▣ STEPS:',
                            style: style.InterSmallText(
                              context,
                              color: color.primarylow,
                              fontsize:
                                  setResponsiveSize(context, baseSize: 14),
                              fontweight: FontWeight.w700,
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          ...widget.remedy.steps.map((steps) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '□ Step $steps',
                                style: style.InterSmallText(
                                  context,
                                  color: color.primarylow,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 14),
                                  fontweight: FontWeight.w500,
                                  height: 1.8,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ HOW TO USE:',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text.rich(
                        TextSpan(
                          children: widget.remedy.usage
                              .map((usage) => TextSpan(
                                    text: '     □ $usage\n',
                                    style: style.InterSmallText(
                                      context,
                                      color: color.primarylow,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 14),
                                      fontweight: FontWeight.w500,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ SIDE EFFECT:',
                        style: style.InterSmallText(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      ...widget.remedy.sideEffects.map(
                        (effect) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              '□ Effect $effect',
                              style: style.InterSmallText(
                                context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 14),
                                fontweight: FontWeight.w500,
                                height: 1.8,
                              ),
                            ),
                          );
                        },
                      ),
                      Gap(setResponsiveSize(context, baseSize: 30)),
                      RemedyFeedbackScreen(
                        rateRemedy: widget.remedy,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
