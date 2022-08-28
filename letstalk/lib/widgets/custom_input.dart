import 'package:flutter/material.dart';
import 'package:letstalk/utils/app_colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Color hintColor, borderColor;
  final bool obscureText;
  const CustomInput({this.controller, this.obscureText = false, this.hintText, this.hintColor = AppColors.primaryColor, this.borderColor = AppColors.primaryColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor
          )
        ),
      ),
    );
  }
}