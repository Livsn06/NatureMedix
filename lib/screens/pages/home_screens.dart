import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/cust_textformfield.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

import '../../data/PlantData/plant_data.dart';
import '../../models/plant_model.dart';

class DashboardScreen extends StatefulWidget with Application {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with Application {
  final _selectControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) => Scaffold(
        body: Column(
          children: [
            _buildHeader(context),
            _buildCategoryChips(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _buildContent(context, controller),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(
      BuildContext context, DashboardController controller) {
    return [
      if (controller.selectedCategory.value == 'All' ||
          controller.selectedCategory.value == 'Future Remedies')
        _buildFutureRemedies(context),
      if (controller.selectedCategory.value == 'All' ||
          controller.selectedCategory.value == 'Plants')
        _buildPopularHerbalPlant(context, controller),
      if (controller.selectedCategory.value == 'All' ||
          controller.selectedCategory.value == 'Recommendation')
        _buildRecommendedHerbalPlant(context, controller),
      SizedBox(height: setResponsiveSize(context, baseSize: 80)),
    ];
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: setResponsiveSize(context, baseSize: 200),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius:
            BorderRadius.circular(setResponsiveSize(context, baseSize: 15)),
        image: DecorationImage(image: AssetImage(image.BG7), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(setResponsiveSize(context, baseSize: 30)),
            _buildTitleRow(context),
            Gap(setResponsiveSize(context, baseSize: 15)),
            _buildSearchBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Uncover Rare Medicinal \nPlant Collections',
          style: style.displaySmall(context,
              color: color.white, fontsize: 22, fontweight: FontWeight.w600),
        ),
        Material(
          shape: const CircleBorder(),
          elevation: setResponsiveSize(context, baseSize: 2),
          child: CircleAvatar(
            radius: setResponsiveSize(context, baseSize: 18),
            backgroundColor: color.white,
            child: Icon(Icons.notifications_outlined,
                color: color.primarylow,
                size: setResponsiveSize(context, baseSize: 25)),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormFields(
            control: _selectControl,
            labeltext: 'Search anything here...',
            iconData: Icons.search,
            isPassword: false,
          ),
        ),
        Gap(setResponsiveSize(context, baseSize: 5)),
        Material(
          color: color.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 8))),
          child: Padding(
            padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 12)),
            child: Icon(Icons.filter_alt_outlined,
                color: color.white,
                size: setResponsiveSize(context, baseSize: 25)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: setResponsiveSize(context, baseSize: 10),
          bottom: setResponsiveSize(context, baseSize: 10),
          left: setResponsiveSize(context, baseSize: 15),
          right: setResponsiveSize(context, baseSize: 15)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['All', 'Future Remedies', 'Plants', 'Recommendation']
              .map((label) => CategoryChip(label))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFutureRemedies(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(context, baseSize: 20),
          horizontal: setResponsiveSize(context, baseSize: 15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Future Remedies',
                style: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 15),
                    fontweight: FontWeight.w500),
              ),
              Text(
                'See all',
                style: style.displaySmall(context,
                    color: color.primary,
                    fontsize: setResponsiveSize(context, baseSize: 14),
                    fontweight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(),
          //Remedies Display
          SizedBox(
            height: setResponsiveSize(context, baseSize: 250),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: remedies.length,
              itemBuilder: (BuildContext context, int index) {
                RemedyInfo remedy = remedies[index];

                return Container(
                  width: setResponsiveSize(context, baseSize: 180),
                  margin: EdgeInsets.only(
                      right: setResponsiveSize(context, baseSize: 10)),
                  child: Card(
                    elevation: setResponsiveSize(context, baseSize: 3),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: setResponsiveSize(context, baseSize: 10),
                        vertical: setResponsiveSize(context, baseSize: 10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: setResponsiveSize(context, baseSize: 160),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    setResponsiveSize(context, baseSize: 10)),
                              ),
                              image: DecorationImage(
                                image: AssetImage(remedy.remedyImage),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 10)),
                          Text(
                            remedy.remedyName,
                            style: style.displaySmall(context,
                                color: color.primaryhigh,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 15),
                                fontweight: FontWeight.w600),
                          ),
                          Gap(setResponsiveSize(context, baseSize: 3)),
                          Text(
                            remedy.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: style.displaySmall(context,
                                color: color.darkGrey,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 13),
                                fontweight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  //Popular herbal plant
  Widget _buildPopularHerbalPlant(
      BuildContext context, DashboardController controller) {
    return Padding(
      padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Herbal Plant',
                style: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 15),
                    fontweight: FontWeight.w500),
              ),
              Text(
                'See all',
                style: style.displaySmall(context,
                    color: color.primary,
                    fontsize: setResponsiveSize(context, baseSize: 14),
                    fontweight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            height: setResponsiveSize(context, baseSize: 250),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plants.length,
              itemBuilder: (BuildContext context, int index) {
                PlantBasicInfo plant = plants[index];
                return GestureDetector(
                  onTap: () => controller.selectPlant(plant, context),
                  child: Container(
                    width: setResponsiveSize(context, baseSize: 180),
                    margin: EdgeInsets.only(
                        right: setResponsiveSize(context, baseSize: 10)),
                    child: Card(
                      elevation: setResponsiveSize(context, baseSize: 3),
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: setResponsiveSize(context, baseSize: 160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      setResponsiveSize(context, baseSize: 10)),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(plant.plantImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Gap(setResponsiveSize(context, baseSize: 10)),
                            Text(
                              plant.plantName,
                              style: style.displaySmall(context,
                                  color: color.primaryhigh,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 15),
                                  fontweight: FontWeight.w600),
                            ),
                            Gap(setResponsiveSize(context, baseSize: 3)),
                            Text(
                              plant.scientificName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: style.displaySmall(context,
                                  color: color.darkGrey,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 13),
                                  fontweight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedHerbalPlant(
      BuildContext context, DashboardController controller) {
    List<PlantBasicInfo> randomizedPlants = List.from(plants)..shuffle();

    return Padding(
      padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Herbal Plant',
                style: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 15),
                    fontweight: FontWeight.w500),
              ),
              Text(
                'See all',
                style: style.displaySmall(context,
                    color: color.primary,
                    fontsize: setResponsiveSize(context, baseSize: 14),
                    fontweight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            height: setResponsiveSize(context, baseSize: 250),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: randomizedPlants.length,
              itemBuilder: (BuildContext context, int index) {
                PlantBasicInfo plant = randomizedPlants[index];

                return GestureDetector(
                  onTap: () => controller.selectPlant(plant, context),
                  child: Container(
                    width: setResponsiveSize(context, baseSize: 180),
                    margin: EdgeInsets.only(
                        right: setResponsiveSize(context, baseSize: 10)),
                    child: Card(
                      elevation: setResponsiveSize(context, baseSize: 3),
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: setResponsiveSize(context, baseSize: 160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      setResponsiveSize(context, baseSize: 10)),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(plant.plantImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Gap(setResponsiveSize(context, baseSize: 10)),
                            Text(
                              plant.plantName,
                              style: style.displaySmall(context,
                                  color: color.primaryhigh,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 15),
                                  fontweight: FontWeight.w600),
                            ),
                            Gap(setResponsiveSize(context, baseSize: 3)),
                            Text(
                              plant.scientificName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: style.displaySmall(context,
                                  color: color.darkGrey,
                                  fontsize:
                                      setResponsiveSize(context, baseSize: 13),
                                  fontweight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget with Application {
  final String label;

  CategoryChip(this.label);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        bool isSelected = controller.selectedCategory.value == label;
        return GestureDetector(
          onTap: () {
            controller.selectCategory(label);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: setResponsiveSize(context, baseSize: 12),
              vertical: setResponsiveSize(context, baseSize: 8),
            ),
            margin:
                EdgeInsets.only(right: setResponsiveSize(context, baseSize: 8)),
            decoration: BoxDecoration(
              color: isSelected ? color.primary : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 10)),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? color.white : color.darkGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
