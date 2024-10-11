import 'package:flutter/material.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../utils/responsive.dart';

class CustIcon extends StatefulWidget {
  final IconData? icon;
  final ShapeBorder? shapes;
  final Color? backColor;
  final Color? iconColor;
  final double value;
  final double iconSize;

  CustIcon({
    super.key,
    required this.icon,
    required this.shapes,
    this.backColor,
    this.iconColor,
    required this.value,
    required this.iconSize,
  });

  @override
  State<CustIcon> createState() => _CustIconState();
}

class _CustIconState extends State<CustIcon> with Application {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backColor ?? color.white,
      shape: widget.shapes,
      elevation: setResponsiveSize(context, baseSize: 2),
      child: Padding(
        padding:
            EdgeInsets.all(setResponsiveSize(context, baseSize: widget.value)),
        child: Icon(
          widget.icon,
          color: widget.iconColor ?? color.white,
          size: setResponsiveSize(context, baseSize: widget.iconSize),
        ),
      ),
    );
  }
}
