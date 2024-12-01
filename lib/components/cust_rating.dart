import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:naturemedix/models/remedy_info.dart';
import 'package:naturemedix/Utils/_initApp.dart';
import 'package:naturemedix/Utils/responsive.dart';

class CustRating extends StatefulWidget {
  final Function(double rating) onRatingSubmit;
  final RemedyInfo remedy;

  const CustRating({
    super.key,
    required this.onRatingSubmit,
    required this.remedy,
    required num initialRating,
  });

  @override
  _CustRatingState createState() => _CustRatingState();
}

class _CustRatingState extends State<CustRating> with Application {
  double _selectedRating = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(setResponsiveSize(context, baseSize: 12)),
        ),
      ),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        width: setResponsiveSize(context, baseSize: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: setResponsiveSize(context, baseSize: 140),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.primary,
                    color.primarylow,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(setResponsiveSize(context, baseSize: 10)),
                  topRight:
                      Radius.circular(setResponsiveSize(context, baseSize: 10)),
                ),
              ),
              child: Padding(
                  padding:
                      EdgeInsets.all(setResponsiveSize(context, baseSize: 10)),
                  child: Image.asset(gif.rating, scale: 4)),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: setResponsiveSize(context, baseSize: 20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(setResponsiveSize(context, baseSize: 20)),
                    Text(
                      'RATE ${widget.remedy.remedyName.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: style.displaySmall(
                        context,
                        color: color.primarylow,
                        fontsize: 18,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                    Gap(setResponsiveSize(context, baseSize: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: color.warning,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    Gap(setResponsiveSize(context, baseSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color.primary,
            padding: EdgeInsets.symmetric(
              horizontal: setResponsiveSize(context, baseSize: 35),
              vertical: setResponsiveSize(context, baseSize: 10),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onRatingSubmit(_selectedRating);
          },
          child: Text(
            'Submit',
            textAlign: TextAlign.center,
            style: style.displaySmall(
              context,
              color: Colors.white,
              fontsize: 15,
              fontweight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
