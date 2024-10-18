import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/Home_Control/bookmark_controller.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/utils/NeoBox.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../models/plant_model.dart';

class PlantInfoScreen extends StatefulWidget {
  final PlantData plant;
  const PlantInfoScreen({super.key, required this.plant});

  @override
  State<PlantInfoScreen> createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> with Application {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
      init: Get.find<BookmarkController>(),
      builder: (controller) {
        final isBookmarked = controller.isBookmarked(widget.plant);

        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: color.primary),
            centerTitle: true,
            backgroundColor: color.primary,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin:
                    EdgeInsets.all(setResponsiveSize(context, baseSize: 12)),
                child: Material(
                  elevation: setResponsiveSize(context, baseSize: 3),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: color.dark,
                    size: setResponsiveSize(context, baseSize: 15),
                  ),
                ),
              ),
            ),
            title: Text(
              'PLANT INFO',
              style: style.displaySmall(context,
                  color: color.white,
                  fontsize: setResponsiveSize(context, baseSize: 15),
                  fontweight: FontWeight.w500,
                  fontspace: 2,
                  fontstyle: FontStyle.normal),
            ),
          ),
          backgroundColor: color.lightGrey,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(setResponsiveSize(context, baseSize: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeoBox(
                      borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 0)),
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 12)),
                        child: Image.asset(
                          widget.plant.plantBasicInfo.plantImage,
                          fit: BoxFit.cover,
                          height: setResponsiveSize(context, baseSize: 200),
                          width: setResponsiveSize(context, baseSize: 200),
                        ),
                      ),
                    ),
                    Gap(setResponsiveSize(context, baseSize: 20)),
                    Column(
                      children: [
                        NeoBox(
                          borderRadius: BorderRadius.circular(
                              setResponsiveSize(context, baseSize: 0)),
                          child: Padding(
                            padding: EdgeInsets.all(
                                setResponsiveSize(context, baseSize: 12)),
                            child: const Icon(Icons.favorite_border),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  setResponsiveSize(context, baseSize: 40)),
                          child: NeoBox(
                            borderRadius: BorderRadius.circular(
                                setResponsiveSize(context, baseSize: 0)),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  setResponsiveSize(context, baseSize: 12)),
                              child: const Icon(Icons.nature_outlined),
                            ),
                          ),
                        ),
                        NeoBox(
                          borderRadius: BorderRadius.circular(
                              setResponsiveSize(context, baseSize: 0)),
                          child: Padding(
                            padding: EdgeInsets.all(
                                setResponsiveSize(context, baseSize: 12)),
                            child: const Icon(Icons.text_rotation_angledown),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Gap(setResponsiveSize(context, baseSize: 25)),
                Container(
                  color: color.white,
                  height: MediaQuery.of(context).size.height * 0.80,
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
                            widget.plant.plantBasicInfo.plantName,
                            style: style.displaySmall(context,
                                color: color.primarylow,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 20),
                                fontweight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () {
                              if (isBookmarked) {
                                controller.removeBookmark(
                                    widget.plant, context);
                              } else {
                                controller.addBookmark(widget.plant);
                              }
                            },
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline_rounded,
                              color: color.primarylow,
                              size: setResponsiveSize(context, baseSize: 25),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Scientific Name: ${widget.plant.plantBasicInfo.scientificName}',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 13),
                            fontweight: FontWeight.w400,
                            fontstyle: FontStyle.italic),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        'DESCRIPTION:',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 12),
                            fontweight: FontWeight.w500),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text(
                        widget.plant.plantBasicInfo.description,
                        textAlign: TextAlign.justify,
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 13),
                            fontweight: FontWeight.w400),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 25)),
                      Text(
                        'TREATMENT:',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 12),
                            fontweight: FontWeight.w500),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Wrap(
                        spacing: setResponsiveSize(context, baseSize: 7),
                        runSpacing: setResponsiveSize(context,
                            baseSize: 5), // Vertical space between rows
                        children: widget.plant.remedyInfo.treatments
                            .asMap()
                            .entries
                            .map((entry) {
                          String treatment = entry.value;

                          return IntrinsicWidth(
                            child: TextButton(
                              onPressed: () {
                                // Perform action for this treatment
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
                                treatment,
                                textAlign: TextAlign.justify,
                                style: style.displaySmall(
                                  context,
                                  color: color.white,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 13),
                                  fontweight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 20)),
                      Text(
                        'REMEDY:',
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 12),
                            fontweight: FontWeight.w500),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Wrap(
                        spacing: setResponsiveSize(context, baseSize: 7),
                        runSpacing: setResponsiveSize(context,
                            baseSize: 5), // Vertical space between rows
                        children: widget.plant.plantBasicInfo.remedy
                            .asMap()
                            .entries
                            .map((entry) {
                          String treatment = entry.value;

                          return IntrinsicWidth(
                            child: TextButton(
                              onPressed: () {
                                // Perform action for this treatment
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
                                treatment,
                                textAlign: TextAlign.justify,
                                style: style.displaySmall(
                                  context,
                                  color: color.white,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 13),
                                  fontweight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
