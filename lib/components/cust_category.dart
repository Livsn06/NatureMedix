import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/Home_Control/dashboard_controller.dart';
import '../utils/_initApp.dart';
import '../utils/responsive.dart';

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
              color: isSelected ? color.primary : Colors.white,
              borderRadius: BorderRadius.circular(
                  setResponsiveSize(context, baseSize: 5)),
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
