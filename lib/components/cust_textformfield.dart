import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../utils/responsive.dart';

class TextFormFields extends StatelessWidget with Application {
  TextFormFields({
    super.key,
    this.control,
    required this.labeltext,
    required this.isPassword,
    this.onPressed,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.validator,
    this.IconSufix,
    this.iconData,
  });

  final TextEditingController? control;
  final String labeltext;
  final IconData? iconData;
  final IconData? IconSufix;
  final bool isPassword;
  final Function? onPressed;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final String? Function(String?)? validator;
  bool readOnly = false;

  @override
  Widget build(BuildContext context) {
    final custBorder = OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(setResponsiveSize(context, baseSize: 10)),
        borderSide: BorderSide(color: Application().color.lightGrey, width: 2));
    return TextFormField(
      readOnly: readOnly,
      controller: control,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: labeltext,
        hintStyle: TextStyle(color: color.darkGrey),
        filled: true,
        fillColor: color.white,
        prefixIcon: Icon(
          iconData,
          color: color.primarylow,
          size: setResponsiveSize(context, baseSize: 20),
        ),
        enabledBorder: custBorder,
        border: custBorder,
        focusedBorder: custBorder,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
      ),
      validator: validator,
    );
  }
}
