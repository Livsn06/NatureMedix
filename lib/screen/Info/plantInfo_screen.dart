import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/Home_Control/bookmark_controller.dart';
import 'package:naturemedix/controllers/PlantInfo_Control/plantInfos_controller.dart';
import 'package:naturemedix/models/plant_info.dart';
import 'package:naturemedix/models/remedy_info.dart';
import 'package:naturemedix/screen/Info/remedy_screen.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class PlantInfoScreen extends StatefulWidget {
  final PlantData plant;
  const PlantInfoScreen({super.key, required this.plant});

  @override
  State<PlantInfoScreen> createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> with Application {
  final PageController _pageController = PageController(initialPage: 0);
  final PlantInfoController plantInfoController =
      Get.put(PlantInfoController());

  @override
  void initState() {
    super.initState();
    plantInfoController.fetchReactionState(widget.plant.plantName);
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
                'HERBAL PLANT INFO',
                style: style.displaySmall(
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
                          itemCount: widget.plant.plantImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(
                                  setResponsiveSize(context, baseSize: 8)),
                              child: NeoBox(
                                borderRadius: BorderRadius.circular(
                                    setResponsiveSize(context, baseSize: 5)),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 12)),
                                  child: Image.asset(
                                    widget.plant.plantImages[index],
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
                  padding: EdgeInsets.only(
                      right: setResponsiveSize(context, baseSize: 20),
                      left: setResponsiveSize(context, baseSize: 20),
                      top: setResponsiveSize(context, baseSize: 30),
                      bottom: setResponsiveSize(context, baseSize: 40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.plant.plantName,
                            style: style.displaySmall(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 20),
                                fontweight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Obx(
                            () => InkWell(
                              child: Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      setResponsiveSize(context, baseSize: 10)),
                                  child: Icon(
                                    // Change the icon based on the toggle status
                                    plantInfoController.isReacted.value
                                        ? Icons.favorite // Active icon
                                        : Icons
                                            .favorite_outline, // Inactive icon
                                    color: color.primary,
                                  ),
                                ),
                              ),
                              onTap: () {
                                plantInfoController
                                    .toggleReactButton(widget.plant.plantName);
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Scientific Name: ${widget.plant.scientificName}',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w400,
                            fontstyle: FontStyle.italic),
                      ),
                      const Divider(),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ DESCRIPTION:',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text(
                        widget.plant.description,
                        textAlign: TextAlign.justify,
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            height: setResponsiveSize(context, baseSize: 1.4),
                            fontsize: setResponsiveSize(context, baseSize: 13),
                            fontweight: FontWeight.w400),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        '▣ TREATMENT:',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: setResponsiveSize(context, baseSize: 7),
                          runSpacing: setResponsiveSize(context, baseSize: 5),
                          children: widget.plant.treatments
                              .asMap()
                              .entries
                              .map((entry) {
                            String treatment = entry.value;

                            return IntrinsicWidth(
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: color.primarylow,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          setResponsiveSize(context,
                                              baseSize: 5)),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  treatment,
                                  textAlign: TextAlign.justify,
                                  style: style.displaySmall(
                                    context,
                                    color: color.primarylow,
                                    fontsize: setResponsiveSize(context,
                                        baseSize: 13.5),
                                    fontweight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 20)),
                      Text(
                        '▣ REMEDY:',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 14),
                            fontweight: FontWeight.w700),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: setResponsiveSize(context, baseSize: 7),
                          runSpacing: setResponsiveSize(context,
                              baseSize: 5), // Vertical space between rows
                          children: widget.plant.remedyList
                              .asMap()
                              .entries
                              .map((entry) {
                            RemedyInfo treatment = entry.value;
                            return IntrinsicWidth(
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() =>
                                      RemedyInfoScreen(remedy: treatment));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(color.primarylow),
                                  shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        setResponsiveSize(context, baseSize: 5),
                                      ),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  treatment.remedyName,
                                  textAlign: TextAlign.justify,
                                  style: style.displaySmall(
                                    context,
                                    color: color.white,
                                    fontsize: setResponsiveSize(context,
                                        baseSize: 13.5),
                                    fontweight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
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
