import 'package:flutter/material.dart';
import 'package:naturemedix/utils/_initApp.dart';

import '../utils/responsive.dart';

class CustElevatedbtn extends StatelessWidget with Application {
  const CustElevatedbtn(
      {super.key,
      required this.onPressed,
      required this.child,
      required this.colors});

  final VoidCallback? onPressed;
  final Widget child;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: setResponsiveSize(context, baseSize: 3),
          backgroundColor: colors,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(setResponsiveSize(context, baseSize: 13)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: setResponsiveSize(context, baseSize: 17)),
          child: child,
        ));
  }
}
