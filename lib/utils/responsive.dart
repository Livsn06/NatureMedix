import 'package:flutter/material.dart';

double setResponsiveSize(BuildContext context, {double baseSize = 10.0}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return baseSize * (screenWidth / 375.0);
}
