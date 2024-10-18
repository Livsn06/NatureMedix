import 'package:flutter/material.dart';
import 'package:naturemedix/utils/_initApp.dart';
import 'package:naturemedix/utils/responsive.dart';

class CheckBoxs extends StatelessWidget with Application {
  final bool isRememberMeChecked;
  final ValueChanged<bool?> onChanged;

  CheckBoxs(
      {super.key, required this.isRememberMeChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Checkbox(
            value: isRememberMeChecked,
            activeColor: isRememberMeChecked ? color.primarylow : color.white,
            onChanged: onChanged,
          ),
          Text(
            'By continuing, you agree to our User Agreement and\nacknowledge that you understand the Privacy Policy.',
            textAlign: TextAlign.left,
            style: style.displaySmall(context,
                color: color.primarylow,
                fontsize: setResponsiveSize(context, baseSize: 11),
                fontweight: FontWeight.w400),
          ),
        ],
      );
}
