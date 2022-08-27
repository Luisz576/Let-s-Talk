import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String title, Color? backgroundColor, Color? titleColor}){
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(title,
        style: TextStyle(
          color: titleColor,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
    )
  );
}