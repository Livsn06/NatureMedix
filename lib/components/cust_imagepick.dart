import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class ImagePickerDialog extends StatelessWidget with Application {
  final Function(XFile?) onCaptureImage;
  final Function() onSelectMultiple;
  ImagePickerDialog(
      {super.key,
      required this.onCaptureImage,
      required this.onSelectMultiple});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: setResponsiveSize(context, baseSize: 250),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: color.white,
          borderRadius: BorderRadius.all(
              Radius.circular(setResponsiveSize(context, baseSize: 20)))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gap(setResponsiveSize(context, baseSize: 15)),
          Text('Choose an option',
              textAlign: TextAlign.center,
              style: style.displaySmall(context,
                  color: Application().color.dark,
                  fontsize: 18,
                  fontweight: FontWeight.w400)),
          Gap(setResponsiveSize(context, baseSize: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      onSelectMultiple();
                      Navigator.pop(context);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 10)),
                      elevation: setResponsiveSize(context, baseSize: 3),
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 20)),
                        child:
                            Icon(Icons.photo, color: color.primary, size: 35),
                      ),
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 10)),
                  Text('Photo Library',
                      textAlign: TextAlign.center,
                      style: style.smallText(context,
                          color: Application().color.dark,
                          fontsize: 15,
                          fontweight: FontWeight.w500)),
                ],
              ),
              Gap(setResponsiveSize(context, baseSize: 60)),
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      onCaptureImage(image);
                      Navigator.pop(context);
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(
                          setResponsiveSize(context, baseSize: 10)),
                      elevation: setResponsiveSize(context, baseSize: 3),
                      child: Padding(
                        padding: EdgeInsets.all(
                            setResponsiveSize(context, baseSize: 20)),
                        child:
                            Icon(Icons.camera, color: color.primary, size: 35),
                      ),
                    ),
                  ),
                  Gap(setResponsiveSize(context, baseSize: 10)),
                  Text('Take Photo',
                      textAlign: TextAlign.center,
                      style: style.smallText(context,
                          color: Application().color.dark,
                          fontsize: 15,
                          fontweight: FontWeight.w500)),
                ],
              )
            ],
          ),
          Gap(setResponsiveSize(context, baseSize: 20)),
        ],
      ),
    );
  }
}
