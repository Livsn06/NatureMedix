import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:naturemedix/utils/responsive.dart';
import 'package:naturemedix/utils/_initApp.dart';

class LoadingAlert extends StatefulWidget {
  final String title;
  final String subtitle;

  const LoadingAlert({super.key, required this.title, required this.subtitle});

  @override
  _LoadingAlertState createState() => _LoadingAlertState();
}

class _LoadingAlertState extends State<LoadingAlert> with Application {
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
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(setResponsiveSize(context, baseSize: 20)),
                  child: Image.asset(
                    gif.loading,
                    fit: BoxFit.contain,
                    scale: setResponsiveSize(context, baseSize: 5),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: color.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        setResponsiveSize(context, baseSize: 10)),
                    bottomRight: Radius.circular(
                        setResponsiveSize(context, baseSize: 10)),
                  )),
              padding: EdgeInsets.symmetric(
                  vertical: setResponsiveSize(context, baseSize: 30),
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
                  Gap(setResponsiveSize(context, baseSize: 20)),
                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: style.displaySmall(context,
                        color: color.darkGrey,
                        fontsize: 16,
                        fontweight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showLoadingAlert(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingAlert(title: title, subtitle: subtitle);
    },
  );
}

void hideLoadingAlert(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
