import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/Home_Control/bookmark_controller.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../controllers/PlantInfo_Control/plantInfo_controller.dart';
import '../../models/plant_info.dart';
import 'control_screen.dart';

class GridlistScreen extends StatefulWidget {
  GridlistScreen({super.key, required this.plantList, required this.title});
  List<PlantData> plantList;
  String title;

  @override
  State<GridlistScreen> createState() => _GridlistScreenState();
}

class _GridlistScreenState extends State<GridlistScreen> with Application {
  final PlantInfoController plantInfoController =
      Get.put(PlantInfoController());

  @override
  Widget build(BuildContext context) {
    final DashboardController dashControl = Get.put(DashboardController());

    return GetBuilder<BookmarkController>(
      init: Get.put(BookmarkController()),
      builder: (controller) => Scaffold(
        backgroundColor: color.light,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            iconTheme: IconThemeData(color: color.primary),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.primary, color.primarylow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            leading: InkWell(
              onTap: () =>
                  Get.offAll(() => const ControlScreen(), arguments: 0),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: color.white,
                size: setResponsiveSize(context, baseSize: 18),
              ),
            ),
            title: Text(
              widget.title.toUpperCase(),
              style: style.displaySmall(
                context,
                color: color.white,
                fontsize: setResponsiveSize(context, baseSize: 15),
                fontweight: FontWeight.w500,
                fontspace: 2,
                fontstyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 7)),
                      elevation: 4,
                      child: TextFormField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical:
                                  setResponsiveSize(context, baseSize: 13),
                              horizontal:
                                  setResponsiveSize(context, baseSize: 12)),
                          border: controller.borderCust,
                          enabledBorder: controller.borderCust,
                          focusedBorder: controller.borderCust,
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search,
                              color: color.primarylow,
                              size: setResponsiveSize(context, baseSize: 25)),
                        ),
                      ),
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 10)),
                  InkWell(
                    onTap: () => controller.toggleSort(),
                    child: Material(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            setResponsiveSize(context, baseSize: 7)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 11)),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Icon(
                              controller.ascendingSort.value
                                  ? Icons.sort_outlined
                                  : Icons.filter_list,
                              color: color.primarylow,
                              size: setResponsiveSize(context, baseSize: 25),
                            ),
                            Positioned(
                              bottom: setResponsiveSize(context, baseSize: -1),
                              right: setResponsiveSize(context, baseSize: -1),
                              child: Text(
                                controller.ascendingSort.value ? 'A-Z' : 'Z-A',
                                style: TextStyle(
                                  color: color.primarylow,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      setResponsiveSize(context, baseSize: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(setResponsiveSize(context, baseSize: 20)),
              Text(
                '▣ ${widget.title} list:',
                style: style.displaySmall(
                  context,
                  color: color.primarylow,
                  fontsize: setResponsiveSize(context, baseSize: 15),
                  fontweight: FontWeight.w500,
                  fontstyle: FontStyle.normal,
                ),
              ),
              const Divider(),
              Gap(setResponsiveSize(context, baseSize: 10)),
              Expanded(
                child: Obx(() {
                  final bookmarks = controller.filteredBookmarks;
                  return bookmarks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                gif.notFound,
                                scale: setResponsiveSize(context, baseSize: 2),
                              ),
                              Text(
                                'No bookmark found',
                                style: style.displaySmall(context,
                                    fontsize: setResponsiveSize(context,
                                        baseSize: 14),
                                    color: color.darkGrey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.plantList.length,
                          itemBuilder: (context, index) {
                            final plant = widget.plantList[index];
                            return FutureBuilder<double>(
                              future: plantInfoController
                                  .getOverallRating(plant.plantName),
                              builder: (context, snapshot) {
                                double rating = snapshot.data ?? 0.0;
                                return InkWell(
                                  onTap: () =>
                                      dashControl.selectPlant(plant, context),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          setResponsiveSize(context,
                                              baseSize: 10)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(setResponsiveSize(
                                          context,
                                          baseSize: 10)),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                setResponsiveSize(context,
                                                    baseSize: 5)),
                                            child: Image.asset(
                                              plant.plantImages[0],
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Gap(setResponsiveSize(context,
                                              baseSize: 12)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  plant.plantName,
                                                  style: style.displaySmall(
                                                    context,
                                                    color: color.primarylow,
                                                    fontsize: setResponsiveSize(
                                                        context,
                                                        baseSize: 16),
                                                    fontweight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Scientific Name: ${plant.scientificName}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: style.displaySmall(
                                                    context,
                                                    color: color.primarylow,
                                                    fontsize: setResponsiveSize(
                                                        context,
                                                        baseSize: 12),
                                                    fontweight: FontWeight.w400,
                                                    fontstyle: FontStyle.italic,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    for (int i = 1; i <= 5; i++)
                                                      Icon(
                                                        Icons.star,
                                                        color: i <= rating
                                                            ? color.warning
                                                            : color.darkGrey,
                                                        size: setResponsiveSize(
                                                            context,
                                                            baseSize: 15),
                                                      ),
                                                    Gap(setResponsiveSize(
                                                        context,
                                                        baseSize: 10)),
                                                    Text(
                                                      rating.toStringAsFixed(1),
                                                      style: style.displaySmall(
                                                        context,
                                                        color: color.primary,
                                                        fontsize:
                                                            setResponsiveSize(
                                                                context,
                                                                baseSize: 12),
                                                        fontweight:
                                                            FontWeight.w400,
                                                        fontstyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(setResponsiveSize(context,
                                                    baseSize: 5)),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Wrap(
                                                    spacing: setResponsiveSize(
                                                        context,
                                                        baseSize: 7),
                                                    runSpacing:
                                                        setResponsiveSize(
                                                            context,
                                                            baseSize: 5),
                                                    children: widget
                                                        .plantList[index]
                                                        .treatments
                                                        .map((treatment) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 2),
                                                        child: Chip(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: color
                                                                      .valid,
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            label: Text(treatment,
                                                                style: TextStyle(
                                                                    fontSize: setResponsiveSize(
                                                                        context,
                                                                        baseSize:
                                                                            12),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: color
                                                                        .primarylow)),
                                                            labelPadding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    setResponsiveSize(
                                                                        context,
                                                                        baseSize:
                                                                            5),
                                                                vertical:
                                                                    setResponsiveSize(
                                                                        context,
                                                                        baseSize:
                                                                            0))),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
