import 'package:flutter/material.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../utils/responsive.dart';
import 'package:gap/gap.dart';

// Base Card Widget
class BaseCard extends StatelessWidget with Application {
  final String imagePath;
  final String title;
  final String description;
  final IconData bookmarkIcon;
  final VoidCallback onBookmarkTap;
  final double? rating; // Make rating optional

  const BaseCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.bookmarkIcon,
    required this.onBookmarkTap,
    this.rating, // Optional rating
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setResponsiveSize(context, baseSize: 190),
      margin: EdgeInsets.only(right: setResponsiveSize(context, baseSize: 10)),
      child: Card(
        elevation: setResponsiveSize(context, baseSize: 3),
        child: Padding(
          padding: EdgeInsets.all(setResponsiveSize(context, baseSize: 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: setResponsiveSize(context, baseSize: 170),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 10)),
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: setResponsiveSize(context, baseSize: 5),
                    right: setResponsiveSize(context, baseSize: 5),
                    child: Column(
                      children: [
                        Material(
                          elevation: setResponsiveSize(context, baseSize: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                setResponsiveSize(context, baseSize: 5)),
                          ),
                          child: InkWell(
                            onTap: onBookmarkTap,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  setResponsiveSize(context, baseSize: 5)),
                              child: Icon(
                                bookmarkIcon,
                                color: color.valid,
                                size: setResponsiveSize(context, baseSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (rating != null)
                    Positioned(
                      bottom: setResponsiveSize(context, baseSize: 5),
                      right: setResponsiveSize(context, baseSize: 4),
                      child: Material(
                        color: color.whiteOpacity20,
                        elevation: setResponsiveSize(context, baseSize: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              setResponsiveSize(context, baseSize: 5)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: setResponsiveSize(context, baseSize: 6),
                              horizontal:
                                  setResponsiveSize(context, baseSize: 10)),
                          child: Text(
                            rating != null
                                ? '⭐ ${rating!.toStringAsFixed(1)}'
                                : '',
                            style: style.displaySmall(context,
                                color: color.white,
                                fontsize:
                                    setResponsiveSize(context, baseSize: 12),
                                fontweight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Gap(setResponsiveSize(context, baseSize: 10)),
              Text(
                title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: style.displaySmall(context,
                    color: color.primaryhigh,
                    fontsize: setResponsiveSize(context, baseSize: 15),
                    fontweight: FontWeight.w600),
              ),
              Gap(setResponsiveSize(context, baseSize: 3)),
              Text(
                description,
                maxLines: 1,
                softWrap: false,
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
}

// Remedy Card (no rating)
class RemedyPlantCard extends BaseCard {
  const RemedyPlantCard({
    super.key,
    required String imagePath,
    required String title,
    required String description,
    required IconData bookmarkIcon,
    required VoidCallback onBookmarkTap,
    required double rating,
  }) : super(
          imagePath: imagePath,
          title: title,
          description: description,
          bookmarkIcon: bookmarkIcon,
          onBookmarkTap: onBookmarkTap,
          rating: rating,
        );
}

// Recommended Plant Card (no rating)
class RecommendedPlantCard extends BaseCard {
  const RecommendedPlantCard({
    super.key,
    required String imagePath,
    required String title,
    required String description,
    required IconData bookmarkIcon,
    required VoidCallback onBookmarkTap,
  }) : super(
          imagePath: imagePath,
          title: title,
          description: description,
          bookmarkIcon: bookmarkIcon,
          onBookmarkTap: onBookmarkTap,
        );
}

// Popular Herbal Plant Card (with rating)
class PopularHerbalPlantCard extends BaseCard {
  const PopularHerbalPlantCard({
    super.key,
    required String imagePath,
    required String title,
    required String description,
    required IconData bookmarkIcon,
    required VoidCallback onBookmarkTap,
  }) : super(
          imagePath: imagePath,
          title: title,
          description: description,
          bookmarkIcon: bookmarkIcon,
          onBookmarkTap: onBookmarkTap,
        );
}
