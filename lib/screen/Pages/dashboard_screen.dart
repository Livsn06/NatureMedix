import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/controllers/PlantInfo_Control/plantInfos_controller.dart';
import 'package:naturemedix/controllers/Home_Control/dashboard_controller.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';
import '../../components/cust_cardlist.dart';
import '../../components/cust_category.dart';
import '../../controllers/Home_Control/bookmark_controller.dart';
import '../../data/PlantData/plant_data.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';

class DashboardScreen extends StatefulWidget with Application {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with Application {
  final _selectControl = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final controller = Get.put(DashboardController());
  final plantController = Get.put(PlantInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.light,
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
        ));
  }

  List<Widget> _buildContent(
      BuildContext context, DashboardController controller) {
    return [
      if (_isCategorySelected(controller, 'All', 'Future Remedies'))
        _buildFutureRemedies(context, controller),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: setResponsiveSize(context, baseSize: 205),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.primary,
              color.primarylow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(setResponsiveSize(context, baseSize: 20)),
              bottomRight:
                  Radius.circular(setResponsiveSize(context, baseSize: 20)))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: setResponsiveSize(context, baseSize: 10),
            horizontal: setResponsiveSize(context, baseSize: 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(setResponsiveSize(context, baseSize: 30)),
            _buildTitleRow(context),
            Gap(setResponsiveSize(context, baseSize: 10)),
            Text(
              controller.greeting.value,
              style: style.displaySmall(context,
                  color: color.white,
                  fontsize: 22,
                  fontweight: FontWeight.w800),
            ),
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
        Image.asset(logo.second,
            scale: setResponsiveSize(context, baseSize: 8)),
        CircleAvatar(
          backgroundColor: color.primarylow,
          radius: setResponsiveSize(context, baseSize: 15) +
              setResponsiveSize(context, baseSize: 4),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: setResponsiveSize(context, baseSize: 18),
            child: Icon(Icons.notifications_outlined,
                color: color.primarylow,
                size: setResponsiveSize(context, baseSize: 25)),
          ),
        )
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Row(
      children: [
        Expanded(
            child: InkWell(
          onTap: () => controller.goToSearch(),
          child: Material(
            borderRadius:
                BorderRadius.circular(setResponsiveSize(context, baseSize: 7)),
            elevation: 4,
            child: TextFormField(
              enabled: false,
              controller: _selectControl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: setResponsiveSize(context, baseSize: 12),
                  horizontal: setResponsiveSize(context, baseSize: 12),
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
        )),
        Gap(setResponsiveSize(context, baseSize: 10)),
        Material(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 7))),
          child: Padding(
            padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 10)),
            child: Icon(Icons.filter_alt_outlined,
                color: color.primarylow,
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
            baseSize: 15,
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

  Widget _buildFutureRemedies(
      BuildContext context, DashboardController controller) {
    final PlantInfoController plantInfoController = Get.find();

    return Obx(() {
      // Prepare the list of remedies with their respective ratings
      List<Map<String, dynamic>> remediesWithRatings = [];

      for (var plant in plantList) {
        for (var remedy in plant.remedyList) {
          remediesWithRatings.add({
            'remedy': remedy,
            'rating': plantInfoController
                    .overallRatingForRemedy[remedy.remedyName]?.value ??
                0.0, // Default rating if none
          });
        }
      }

      // Sort the remedies list by the rating in descending order
      remediesWithRatings.sort((a, b) {
        double ratingA = a['rating'];
        double ratingB = b['rating'];
        return ratingB.compareTo(ratingA); // Descending order
      });

      // Build the section with the sorted remedies list
      return _buildSection(
        context,
        'Future Remedies',
        remediesWithRatings.map((item) {
          var remedy = item['remedy'];
          var rating = item['rating'];

          return Obx(() {
            // Dynamically fetch the rating for each remedy
            double currentRating = plantInfoController
                    .overallRatingForRemedy[remedy.remedyName]?.value ??
                rating;

            return _buildRemedyCard(
              context,
              remedy,
              controller,
              currentRating, // Pass the specific rating for the remedy
            );
          });
        }).toList(),
      );
    });
  }

  Widget _buildPopularHerbalPlant(
      BuildContext context, DashboardController controller) {
    final PlantInfoController plantInfoController = Get.find();

    return Obx(() {
      // Create a list of popular plants
      List<PlantData> popularPlant = List.from(plantList);

      // Sort the list based on reaction count in descending order
      popularPlant.sort((a, b) {
        int reactionA =
            plantInfoController.plantReactions[a.plantName]?.value ?? 0;
        int reactionB =
            plantInfoController.plantReactions[b.plantName]?.value ?? 0;
        return reactionB.compareTo(reactionA); // Sort in descending order
      });

      // Update reaction counts for each plant dynamically
      for (var plant in popularPlant) {
        plantInfoController.updateReactionCount(plant.plantName);
      }

      // Build the section with the sorted plants list
      return _buildSection(
        context,
        'Popular Herbal Plant',
        popularPlant.map((plant) {
          // Retrieve reaction count using the plant's name
          int reactionCount =
              plantInfoController.plantReactions[plant.plantName]?.value ?? 0;

          return _PopularHerbalPlantCard(
            context,
            plant,
            controller,
            reactionCount, // Pass the specific reaction count
          );
        }).toList(),
      );
    });
  }

  Widget _buildRecommendedHerbalPlant(
      BuildContext context, DashboardController controller) {
    List<PlantData> randomizedPlants = List.from(plantList);
    return _buildSection(
        context,
        'Recommended Herbal Plant',
        randomizedPlants
            .map((plant) =>
                _RecommendedHerbalPlantCard(context, plant, controller))
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
        GestureDetector(
          onTap: () {
            if (title == 'Future Remedies') {
              // Pass remedyList for Future Remedies
              controller.gotoSeeAll(plantList, title);
            } else if (title == 'Popular Herbal Plant') {
              // Pass plantList for Popular Herbal Plant
              controller.gotoSeeAll(plantList, title);
            } else {
              // Default, pass plantList or appropriate list for Recommendation
              controller.gotoSeeAll(plantList, title);
            }
          },
          child: Text(
            'See all',
            style: style.displaySmall(context,
                color: color.primary,
                fontsize: setResponsiveSize(context, baseSize: 14),
                fontweight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _PopularHerbalPlantCard(BuildContext context, PlantData plant,
      DashboardController controller, int totalReactions) {
    final bookmarkController = Get.put(BookmarkController());

    return Obx(() {
      bool isBookmarked = bookmarkController.isPlantBookmarked(plant);
      return GestureDetector(
        onTap: () => controller.selectPlant(plant, context),
        child: Stack(
          children: [
            PopularHerbalPlantCard(
                imagePath: plant.plantImages[0],
                title: plant.plantName,
                description: plant.scientificName,
                bookmarkIcon:
                    isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                onBookmarkTap: () {
                  if (isBookmarked) {
                    bookmarkController.removeBookmark(plant, context);
                  } else {
                    bookmarkController.addBookmark(plant);
                  }
                },
                totalReactions: totalReactions)
          ],
        ),
      );
    });
  }

  Widget _RecommendedHerbalPlantCard(
    BuildContext context,
    PlantData plant,
    DashboardController controller,
  ) {
    final bookmarkController = Get.put(BookmarkController());

    return Obx(() {
      bool isBookmarked = bookmarkController.isPlantBookmarked(plant);
      return GestureDetector(
        onTap: () => controller.selectPlant(plant, context),
        child: Stack(
          children: [
            RecommendedPlantCard(
              imagePath: plant.plantImages[0],
              title: plant.plantName,
              description: plant.scientificName,
              bookmarkIcon:
                  isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              onBookmarkTap: () {
                if (isBookmarked) {
                  bookmarkController.removeBookmark(plant, context);
                } else {
                  bookmarkController.addBookmark(plant);
                }
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRemedyCard(BuildContext context, RemedyInfo remedy,
      DashboardController controller, double rating) {
    final bookmarkController = Get.put(BookmarkController());

    // Call fetchRating when the widget is built

    return Obx(() {
      bool isBookmarked = bookmarkController.isRemedyBookmarked(remedy);

      return GestureDetector(
        onTap: () => controller.selectRemedy(remedy, context),
        child: Stack(
          children: [
            RemedyPlantCard(
              imagePath: remedy.remedyImages[0],
              title: remedy.remedyName,
              description: remedy.remedyType,
              bookmarkIcon:
                  isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              onBookmarkTap: () {
                if (isBookmarked) {
                  bookmarkController.removeRemedyBookmark(remedy, context);
                } else {
                  bookmarkController.addRemedyBookmark(remedy);
                }
              },
              rating: rating,
            ),
          ],
        ),
      );
    });
  }
}
