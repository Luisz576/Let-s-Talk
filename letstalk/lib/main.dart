import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letstalk/screens/login_screen.dart';

void main(){
  runApp(const LetsTalk());
}

class LetsTalk extends StatelessWidget {
  const LetsTalk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const MaterialApp(
      title: "Let's Talk",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}