import 'package:flutter/material.dart';
import 'package:naturemedix/utils/_initApp.dart';
import '../utils/responsive.dart';

class TextFormFields extends StatelessWidget with Application {
  TextFormFields({
    super.key,
    required this.control,
    required this.labeltext,
    required this.iconData,
    required this.isPassword,
    this.onPressed,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.validator,
  });

  final TextEditingController control;
  final String labeltext;
  final IconData iconData;
  final bool isPassword;
  final Function? onPressed;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(setResponsiveSize(context, baseSize: 10)),
          borderSide: BorderSide(color: color.primarylow),
        ),
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
