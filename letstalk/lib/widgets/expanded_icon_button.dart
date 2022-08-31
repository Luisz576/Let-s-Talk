import 'package:flutter/material.dart';

class ExpandedIconButton extends StatelessWidget {
  final int flex;
  final Function() onPressed;
  final IconData icon;
  final Color iconColor;
  const ExpandedIconButton({required this.icon, required this.onPressed, required this.iconColor, required this.flex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor,),
      ),
    );
  }
}