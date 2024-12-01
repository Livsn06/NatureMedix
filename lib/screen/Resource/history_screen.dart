import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/cust_tilelist.dart';
import 'package:naturemedix/controllers/Home_Control/bookmark_controller.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/screen/Pages/control_screen.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';

class HistoryScreen extends StatefulWidget with Application {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with Application {
  @override
  Widget build(BuildContext context) {
    final BookmarkController bookControl = Get.put(BookmarkController());
    final DashboardController dashControl = Get.put(DashboardController());

    final List<String> filterOptions = ["All", "Today", "Yesterday", "Old"];

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      bookControl.loadHistory();
    }

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
              onTap: () =>
                  Get.offAll(() => const ControlScreen(), arguments: 4),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: color.white,
                size: setResponsiveSize(context, baseSize: 18),
              ),
            ),
            title: Text(
              'HISTORY',
              style: style.displaySmall(
                context,
                color: color.white,
                fontsize: setResponsiveSize(context, baseSize: 15),
                fontweight: FontWeight.w500,
                fontspace: 2,
                fontstyle: FontStyle.normal,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: color.white,
                ),
                onPressed: () {
                  controller.removeAllBookmark(context);
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 17)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar and sorting
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
              Gap(setResponsiveSize(context, baseSize: 10)),

              DropdownButton<String>(
                dropdownColor: color.white,
                value: controller.selectedFilter.value,
                underline: const SizedBox.shrink(),
                items: filterOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    alignment: AlignmentDirectional.centerStart,
                    value: value,
                    child: Text(
                      '▣  $value',
                      style: style.displaySmall(
                        context,
                        color: color.primarylow,
                        fontsize: setResponsiveSize(context, baseSize: 15),
                        fontweight: FontWeight.w500,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.setFilter(newValue);
                  }
                },
              ),

              const Divider(),

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
                          itemCount: bookmarks.length,
                          itemBuilder: (context, index) {
                            final item = bookmarks[index];
                            if (item is PlantData) {
                              return InkWell(
                                onTap: () =>
                                    dashControl.selectPlant(item, context),
                                child: CardList(
                                  requestImage: Image.asset(item.plantImages[0],
                                      width: 70, height: 70),
                                  requestTitle: Text(item.plantName),
                                  subRequestTitle: Text(
                                      'Scientific Name: ${item.scientificName}'),
                                  settingsTapped: null,
                                  deleteTapped: (context) =>
                                      controller.removeBookmark(item, context),
                                ),
                              );
                            } else if (item is RemedyInfo) {
                              return InkWell(
                                onTap: () =>
                                    dashControl.selectRemedy(item, context),
                                child: CardList(
                                  requestImage: Image.asset(
                                      item.remedyImages[0],
                                      width: 70,
                                      height: 70),
                                  requestTitle: Text(item.remedyName),
                                  subRequestTitle:
                                      Text('Remedy type: ${item.remedyType}'),
                                  settingsTapped: null,
                                  deleteTapped: (context) => controller
                                      .removeRemedyBookmark(item, context),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                }),
              ),
              Gap(setResponsiveSize(context, baseSize: 70)),
            ],
          ),
        ),
      ),
    );
  }
}
