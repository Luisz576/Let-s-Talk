import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letstalk/firebase_options.dart';
import 'package:letstalk/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

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