import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final void Function() onPressed;
  const LargeButton({required this.onPressed, required this.child, this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: child,
          ),
        ),
      )
    );
  }
}