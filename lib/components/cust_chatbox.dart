import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:naturemedix/components/cust_rating.dart';
import 'package:naturemedix/controllers/PlantInfo_Control/plantInfos_controller.dart';
import 'package:naturemedix/models/feedback_data.dart';
import 'package:naturemedix/models/remedy_info.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class RemedyFeedbackScreen extends StatefulWidget {
  const RemedyFeedbackScreen({super.key, required this.rateRemedy});
  final RemedyInfo rateRemedy;

  @override
  State<RemedyFeedbackScreen> createState() => _RemedyFeedbackScreenState();
}

class _RemedyFeedbackScreenState extends State<RemedyFeedbackScreen>
    with Application {
  final PlantInfoController plantInfoController =
      Get.put(PlantInfoController());

  void _submitRating(double rating) async {
    await plantInfoController.saveRating(
      widget.rateRemedy.remedyName,
      rating,
    );
    plantInfoController.updateRemedyRating(
        widget.rateRemedy.remedyName, rating);
  }

  int selectedRating = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '▣ RATING & FEEDBACK:',
          style: style.InterSmallText(context,
              color: color.primarylow,
              fontsize: setResponsiveSize(context, baseSize: 15),
              fontweight: FontWeight.w700),
        ),
        Gap(setResponsiveSize(context, baseSize: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 160,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: selectedRating,
                  hint: const Text('Filter by Rating'),
                  items: [1, 2, 3, 4, 5].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        '$value RATING STARS\'${value > 1 ? 's' : ''}',
                        style: style.InterSmallText(
                          context,
                          color: color.primarylow,
                          fontsize: setResponsiveSize(context, baseSize: 13),
                          fontweight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedRating = newValue!;
                    });
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustRating(
                      remedy: widget.rateRemedy,
                      initialRating: (plantInfoController
                              .overallRatingForRemedy[
                                  widget.rateRemedy.remedyName]
                              ?.value ??
                          0),
                    );
                  },
                );
              },
              child: Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_comment_outlined,
                    color: color.primary,
                  ),
                ),
              ),
            )
          ],
        ),
        Gap(setResponsiveSize(context, baseSize: 10)),
        selectedRating == null
            ? const Center(child: Text('No rating yet'))
            : Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: feedbackList
                            .where(
                                (feedback) => feedback.rating == selectedRating)
                            .length,
                        itemBuilder: (context, index) {
                          final feedback = feedbackList
                              .where((feedback) =>
                                  feedback.rating == selectedRating)
                              .toList()[index];
                          return Card(
                            elevation: 3,
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: ListTile(
                                  isThreeLine: true,
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(feedback.avatar),
                                  ),
                                  title: Text(
                                    feedback.name,
                                    style: style.InterSmallText(
                                      context,
                                      color: color.primarylow,
                                      fontsize: setResponsiveSize(context,
                                          baseSize: 17),
                                      fontweight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => index < feedback.rating
                                              ? Text('★',
                                                  style: style.InterSmallText(
                                                    context,
                                                    color: color.warning,
                                                    fontsize: setResponsiveSize(
                                                        context,
                                                        baseSize: 17),
                                                    fontweight: FontWeight.w500,
                                                  ))
                                              : Text('★',
                                                  style: style.InterSmallText(
                                                    context,
                                                    color: color.darkGrey,
                                                    fontsize: setResponsiveSize(
                                                        context,
                                                        baseSize: 17),
                                                    fontweight: FontWeight.w500,
                                                  )),
                                        ),
                                      ),
                                      Text(
                                        DateFormat('MMMM, dd, yyyy: hh:mm a')
                                            .format(feedback.date),
                                        style: style.InterSmallText(
                                          context,
                                          color: color.primarylow,
                                          fontsize: setResponsiveSize(context,
                                              baseSize: 13),
                                          fontweight: FontWeight.w500,
                                        ),
                                      ),
                                      const Gap(8),
                                      Text(
                                        feedback.feedback.toString(),
                                        style: style.InterSmallText(
                                          context,
                                          color: color.primarylow,
                                          fontsize: setResponsiveSize(context,
                                              baseSize: 15),
                                          fontweight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.visible,
                                        maxLines: null,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
