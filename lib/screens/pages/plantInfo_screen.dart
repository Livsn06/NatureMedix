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
  final PlantBasicInfo plant;
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
                          widget.plant.plantImage,
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
                            child: Icon(Icons.favorite_border),
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
                              child: Icon(Icons.nature_outlined),
                            ),
                          ),
                        ),
                        NeoBox(
                          borderRadius: BorderRadius.circular(
                              setResponsiveSize(context, baseSize: 0)),
                          child: Padding(
                            padding: EdgeInsets.all(
                                setResponsiveSize(context, baseSize: 12)),
                            child: Icon(Icons.text_rotation_angledown),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Gap(setResponsiveSize(context, baseSize: 25)),
                Container(
                  color: color.white,
                  height: MediaQuery.of(context).size.height * 0.70,
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
                            widget.plant.plantName,
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
                        'Scientific Name: ${widget.plant.scientificName}',
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
                            fontsize: setResponsiveSize(context, baseSize: 13),
                            fontweight: FontWeight.w500),
                      ),
                      Gap(setResponsiveSize(context, baseSize: 10)),
                      Text(
                        widget.plant.description,
                        textAlign: TextAlign.justify,
                        style: style.displaySmall(context,
                            color: color.primarylow,
                            fontsize: setResponsiveSize(context, baseSize: 13),
                            fontweight: FontWeight.w400),
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
