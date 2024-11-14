import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:naturemedix/utils/responsive.dart';
import 'package:naturemedix/utils/_initApp.dart';

class ConfirmValidationAlert extends StatefulWidget {
  final String title;
  final String text;
  final VoidCallback onConfirm;
  final String iconImage;

  const ConfirmValidationAlert({
    super.key,
    required this.title,
    required this.text,
    required this.onConfirm,
    required this.iconImage,
  });

  @override
  _ConfirmValidationAlertState createState() => _ConfirmValidationAlertState();
}

class _ConfirmValidationAlertState extends State<ConfirmValidationAlert>
    with Application {
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
                color: color.primary,
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
                  widget.iconImage,
                  fit: BoxFit.contain,
                  scale: setResponsiveSize(context, baseSize: 6),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: setResponsiveSize(context, baseSize: 35),
                    vertical: setResponsiveSize(context, baseSize: 10)),
                backgroundColor: color.invalid,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: style.displaySmall(context,
                    color: color.white,
                    fontsize: 15,
                    fontweight: FontWeight.w600),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: setResponsiveSize(context, baseSize: 35),
                    vertical: setResponsiveSize(context, baseSize: 10)),
                backgroundColor: color.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: widget.onConfirm,
              child: Text(
                'Confirm',
                textAlign: TextAlign.center,
                style: style.displaySmall(context,
                    color: color.white,
                    fontsize: 15,
                    fontweight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Usage example somewhere in your app:
void showConfirmValidation(BuildContext context, String title, String text,
    VoidCallback onConfirm, String iconImage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmValidationAlert(
          title: title, text: text, onConfirm: onConfirm, iconImage: iconImage);
    },
  );
}
