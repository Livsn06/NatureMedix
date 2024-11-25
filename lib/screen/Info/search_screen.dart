import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../controllers/Search_Controller/search_controller.dart';

class SearchScreen extends StatefulWidget with Application {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with Application {
  @override
  Widget build(BuildContext context) {
    final DashboardController dashControl = Get.put(DashboardController());

    return GetBuilder<SearchingController>(
      init: Get.put(SearchingController()),
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
              'EXPLORE',
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
          padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 17)),
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
                            vertical: setResponsiveSize(context, baseSize: 13),
                            horizontal:
                                setResponsiveSize(context, baseSize: 12),
                          ),
                          border: controller.borderCust,
                          enabledBorder: controller.borderCust,
                          focusedBorder: controller.borderCust,
                          hintText: 'Search...',
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.searchController.clear();
                              },
                              icon: Icon(Icons.clear)),
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
                              setResponsiveSize(context, baseSize: 7))),
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
                '▣ Search result:',
                style: style.displaySmall(
                  context,
                  color: color.primarylow,
                  fontsize: setResponsiveSize(context, baseSize: 15),
                  fontweight: FontWeight.w500,
                  fontstyle: FontStyle.normal,
                ),
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  final filteredPlants = controller.filteredPlants;
                  final filteredRemedies = controller.filteredRemedies;
                  return filteredPlants.isEmpty && filteredRemedies.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                gif.notFound,
                                scale: setResponsiveSize(context, baseSize: 2),
                              ),
                              Text(
                                'No results found',
                                style: style.displaySmall(context,
                                    fontsize: setResponsiveSize(context,
                                        baseSize: 14),
                                    color: color.darkGrey),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          children: [
                            ...filteredPlants.map((plant) => ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        setResponsiveSize(context,
                                            baseSize: 5)),
                                    child: Image.asset(plant.plantImages[0],
                                        width: 50, height: 50),
                                  ),
                                  title: Text(
                                    plant.plantName,
                                    style: style.displaySmall(
                                      context,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 15),
                                      color: color.primarylow,
                                      fontweight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    plant.scientificName,
                                    style: style.displaySmall(
                                      context,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 12),
                                      color: color.primarylow,
                                      fontweight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      controller.incrementSearchCount(
                                        name: plant.plantName,
                                        type: 'plants',
                                      );
                                      dashControl.selectPlant(plant, context);
                                    },
                                    child: Text(
                                      'View',
                                      style: style.displaySmall(
                                        context,
                                        fontsize: setResponsiveSize(context,
                                            baseSize: 13),
                                        color: color.primarylow,
                                        fontweight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )),
                            ...filteredRemedies.map((remedy) => ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        setResponsiveSize(context,
                                            baseSize: 5)),
                                    child: Image.asset(remedy.remedyImages[0],
                                        width: 50, height: 50),
                                  ),
                                  title: Text(
                                    remedy.remedyName,
                                    style: style.displaySmall(
                                      context,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 15),
                                      color: color.primarylow,
                                      fontweight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    remedy.remedyType,
                                    style: style.displaySmall(
                                      context,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 12),
                                      color: color.primarylow,
                                      fontweight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      controller.incrementSearchCount(
                                        name: remedy.remedyName,
                                        type: 'remedies',
                                      );
                                      dashControl.selectRemedy(remedy, context);
                                    },
                                    child: Text(
                                      'View',
                                      style: style.displaySmall(
                                        context,
                                        fontsize: setResponsiveSize(context,
                                            baseSize: 13),
                                        color: color.primarylow,
                                        fontweight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
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
