import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:naturemedix/utils/responsive.dart';
import 'package:naturemedix/utils/_initApp.dart';

import '../routes/screen_routes.dart';

class ValidationAlert extends StatefulWidget {
  final String title;
  final String text;
  final String authType;
  final bool isValid;
  final VoidCallback onpress;

  ValidationAlert(
      {super.key,
      required this.title,
      required this.text,
      required this.authType,
      required this.isValid,
      required this.onpress});

  @override
  _ValidationAlertState createState() => _ValidationAlertState();
}

class _ValidationAlertState extends State<ValidationAlert> with Application {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(setResponsiveSize(context, baseSize: 10)),
        ),
      ),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: setResponsiveSize(context, baseSize: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: setResponsiveSize(context, baseSize: 120),
              decoration: BoxDecoration(
                color: widget.isValid ? color.primary : color.invalid,
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(setResponsiveSize(context, baseSize: 10)),
                  topRight:
                      Radius.circular(setResponsiveSize(context, baseSize: 10)),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.all(setResponsiveSize(context, baseSize: 20)),
                child: Image.asset(
                  widget.isValid ? gif.valid : gif.invalid,
                  fit: BoxFit.contain,
                  scale: setResponsiveSize(context, baseSize: 5),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: setResponsiveSize(context, baseSize: 15),
                  horizontal: setResponsiveSize(context, baseSize: 35)),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: style.displaySmall(context,
                        color: color.primarylow,
                        fontsize: 22,
                        fontweight: FontWeight.w600),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 10)),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: style.displaySmall(context,
                        color: color.darkGrey,
                        fontsize: 17,
                        fontweight: FontWeight.w400),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 5)),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: setResponsiveSize(context, baseSize: 35),
                  vertical: setResponsiveSize(context, baseSize: 10)),
              backgroundColor: widget.isValid ? color.primary : color.invalid,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: widget.onpress,
            child: Text(
              widget.isValid ? 'Continue' : 'Retry',
              textAlign: TextAlign.center,
              style: style.displaySmall(context,
                  color: widget.isValid ? color.white : color.dark,
                  fontsize: 15,
                  fontweight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

// Usage example somewhere in your app:
void showValidationAlert(BuildContext context, String title, String text,
    String authType, bool isValid, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ValidationAlert(
        title: title,
        text: text,
        authType: authType,
        isValid: isValid,
        onpress: onConfirm,
      );
    },
  );
}
