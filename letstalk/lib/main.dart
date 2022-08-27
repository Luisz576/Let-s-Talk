import 'package:flutter/material.dart';
import 'package:letstalk/screens/login_screen.dart';

void main(){
  runApp(const LetsTalk());
}

class LetsTalk extends StatelessWidget {
  const LetsTalk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Let's Talk",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}