import 'package:flutter/material.dart';

double getResponsiveFontSize({BuildContext? context, double? baseSize = 10}) {
  double screenWidth = MediaQuery.of(context!).size.width;
  return baseSize! * (screenWidth / 375.0);
}

double getResponsivePaddingSize(
    {BuildContext? context, double? basePadding = 10}) {
  double screenWidth = MediaQuery.of(context!).size.width;
  return basePadding! * (screenWidth / 375.0);
}

double getResponsiveDefaultSize(
    {BuildContext? context, double? baseSize = 10}) {
  double screenWidth = MediaQuery.of(context!).size.width;
  return baseSize! * (screenWidth / 375.0);
}
