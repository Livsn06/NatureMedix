import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/components/cust_textformfield.dart';
import 'package:naturemedix/controllers/Auth_Control/login_controller.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../components/cust_category.dart';
import '../../data/PlantData/plant_data.dart';
import '../../models/plant_model.dart';

class DashboardScreen extends StatefulWidget with Application {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with Application {
  final _selectControl = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: Get.put(LoginController()),
        builder: (sp) {
          sp.getDataFromSharedPreferences();
          return Scaffold(
              body: Column(
            children: [
              _buildHeader(context, sp.name.toString()),
              _buildCategoryChips(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _buildContent(context, controller),
                  ),
                ),
              ),
            ],
          ));
        });
  }

  List<Widget> _buildContent(
      BuildContext context, DashboardController controller) {
    return [
      if (_isCategorySelected(controller, 'All', 'Future Remedies'))
        _buildFutureRemedies(context),
      if (_isCategorySelected(controller, 'All', 'Plants'))
        _buildPopularHerbalPlant(context, controller),
      if (_isCategorySelected(controller, 'All', 'Recommendation'))
        _buildRecommendedHerbalPlant(context, controller),
      SizedBox(height: setResponsiveSize(context, baseSize: 80)),
    ];
  }

  bool _isCategorySelected(DashboardController controller,
      String defaultCategory, String specificCategory) {
    return controller.selectedCategory.value == defaultCategory ||
        controller.selectedCategory.value == specificCategory;
  }

  Widget _buildHeader(BuildContext context, String displayName) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(setResponsiveSize(context, baseSize: 30)),
            _buildTitleRow(context, displayName),
            Gap(setResponsiveSize(context, baseSize: 15)),
            _buildSearchBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context, String displayName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${controller.greeting()}\n',
                style: style.displaySmall(context,
                    color: color.white,
                    fontsize: 23,
                    fontweight: FontWeight.w600), // Larger text
              ),
              TextSpan(
                text: displayName.toUpperCase(),
                style: style.displaySmall(context,
                    color: color.white,
                    fontsize: 20,
                    fontweight: FontWeight.w600), // Smaller text
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: setResponsiveSize(context, baseSize: 18),
          backgroundColor: color.white,
          child: Icon(Icons.notifications_outlined,
              color: color.primarylow,
              size: setResponsiveSize(context, baseSize: 25)),
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
      padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(
            context,
            baseSize: 10,
          ),
          horizontal: setResponsiveSize(context, baseSize: 15)),
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
    return _buildSection(
        context,
        'Future Remedies',
        remedies
            .map((remedy) => _buildCard(context, remedy.remedyImage,
                remedy.remedyName, remedy.description))
            .toList());
  }

  Widget _buildPopularHerbalPlant(
      BuildContext context, DashboardController controller) {
    return _buildSection(
        context,
        'Popular Herbal Plant',
        plants
            .map((plant) => _buildPlantCard(context, plant, controller))
            .toList());
  }

  Widget _buildRecommendedHerbalPlant(
      BuildContext context, DashboardController controller) {
    List<PlantBasicInfo> randomizedPlants = List.from(plants);
    return _buildSection(
        context,
        'Recommended Herbal Plant',
        randomizedPlants
            .map((plant) => _buildPlantCard(context, plant, controller))
            .toList());
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: setResponsiveSize(context, baseSize: 20),
          horizontal: setResponsiveSize(context, baseSize: 15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, title),
          Divider(),
          SizedBox(
            height: setResponsiveSize(context, baseSize: 260),
            child: ListView(scrollDirection: Axis.horizontal, children: items),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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
    );
  }

  Widget _buildCard(BuildContext context, String imagePath, String title,
      String description) {
    return Container(
      width: setResponsiveSize(context, baseSize: 180),
      margin: EdgeInsets.only(right: setResponsiveSize(context, baseSize: 10)),
      child: Card(
        elevation: setResponsiveSize(context, baseSize: 3),
        child: Padding(
          padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: setResponsiveSize(context, baseSize: 160),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      setResponsiveSize(context, baseSize: 10)),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.fill),
                ),
              ),
              Gap(setResponsiveSize(context, baseSize: 10)),
              Text(
                title,
                style: style.displaySmall(context,
                    color: color.primaryhigh,
                    fontsize: setResponsiveSize(context, baseSize: 15),
                    fontweight: FontWeight.w600),
              ),
              Gap(setResponsiveSize(context, baseSize: 3)),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: style.displaySmall(context,
                    color: color.darkGrey,
                    fontsize: setResponsiveSize(context, baseSize: 13),
                    fontweight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, PlantBasicInfo plant,
      DashboardController controller) {
    return GestureDetector(
      onTap: () => controller.selectPlant(plant, context),
      child: _buildCard(
          context, plant.plantImage, plant.plantName, plant.scientificName),
    );
  }
}
