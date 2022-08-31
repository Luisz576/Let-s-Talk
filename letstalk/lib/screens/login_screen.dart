import 'package:flutter/material.dart';
import 'package:letstalk/functions/show_snack_bar.dart';
import 'package:letstalk/screens/chat_screen.dart';
import 'package:letstalk/services/database.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/tabs/login_tab.dart';
import 'package:letstalk/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Database.getSavedToken().then((token){
      if(token != null){
        Server.loginWithToken(token).then((user){
          if(user != null){
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ),
              (route) => false
            );
            showSnackBar(context,
              title: "Conectado com sucesso!",
              titleColor: AppColors.whiteColor,
              backgroundColor: AppColors.sucessColor
            );
          }else{
            setState((){
              isLoading = false;
            });
            showSnackBar(context,
              title: "Token Inválido",
              titleColor: AppColors.whiteColor,
              backgroundColor: AppColors.errorColor
            );
          }
        });
      }else{
        setState((){
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ?
      const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ) :
      Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text("Let's Talk",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor
            ),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        body: const SafeArea(
          child: LoginTab(),
        ),
      );
  }
}