// cust_rating.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:naturemedix/utils/responsive.dart';
import 'package:naturemedix/utils/_initApp.dart';

import '../models/client_data.dart';

class CustClientdialog extends StatefulWidget {
  final ClientData request;

  const CustClientdialog({
    super.key,
    required this.request,
  });

  @override
  _CustClientdialogState createState() => _CustClientdialogState();
}

class _CustClientdialogState extends State<CustClientdialog> with Application {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(setResponsiveSize(context, baseSize: 10)),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: setResponsiveSize(context, baseSize: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: setResponsiveSize(context, baseSize: 180),
              decoration: BoxDecoration(
                color: color.valid,
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(setResponsiveSize(context, baseSize: 10)),
                  topRight:
                      Radius.circular(setResponsiveSize(context, baseSize: 10)),
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      setResponsiveSize(context, baseSize: 5)),
                  child: Image.file(File(widget.request.imagePaths[0]),
                      width: 350, height: 200, fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        setResponsiveSize(context, baseSize: 10)),
                    bottomRight: Radius.circular(
                        setResponsiveSize(context, baseSize: 10)),
                  )),
              padding: EdgeInsets.symmetric(
                  vertical: setResponsiveSize(context, baseSize: 20),
                  horizontal: setResponsiveSize(context, baseSize: 35)),
              child: Column(
                children: [
                  Text(
                    widget.request.title,
                    textAlign: TextAlign.center,
                    style: style.displaySmall(context,
                        color: color.primarylow,
                        fontsize: 22,
                        fontweight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat.yMMMd()
                        .format(widget.request.createdAt)
                        .toString(),
                    style: style.displaySmall(context,
                        fontsize: setResponsiveSize(context, baseSize: 13),
                        color: color.darkGrey,
                        fontweight: FontWeight.w500,
                        fontstyle: FontStyle.italic),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 20)),
                  Text(
                    maxLines: 3,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    widget.request.description,
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
      actions: [
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
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Okay',
            textAlign: TextAlign.center,
            style: style.displaySmall(context,
                color: color.white, fontsize: 15, fontweight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
