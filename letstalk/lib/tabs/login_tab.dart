import 'package:flutter/material.dart';
import 'package:letstalk/functions/show_snack_bar.dart';
import 'package:letstalk/screens/chat_screen.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({Key? key}) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController usernameSignUpController = TextEditingController(),
                            passwordSignUpController = TextEditingController(),
                            confirmPasswordSignUpController = TextEditingController();
  final TextEditingController usernameController = TextEditingController(),
                            passwordController = TextEditingController();
  bool isSignUpLoading = false,
    isSignInLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Column(
        children: [
          const Text("Crie uma conta!",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),
          ),
          TextField(
            controller: usernameSignUpController,
            decoration: const InputDecoration(
              hintText: "Insira um nome de usuário",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.secondaryColor
                )
              )
            ),
          ),
          TextField(
            controller: passwordSignUpController,
            decoration: const InputDecoration(
              hintText: "Insira uma senha",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.secondaryColor
                )
              )
            ),
          ),
          TextField(
            controller: confirmPasswordSignUpController,
            decoration: const InputDecoration(
              hintText: "Insira a senha novamente",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.secondaryColor
                )
              )
            ),
          ),
          ElevatedButton(
            onPressed: (){
              if(isSignUpLoading || isSignInLoading) return;
              if(usernameSignUpController.text.trim().length > 5 || usernameSignUpController.text.trim().length > 16){
                showSnackBar(context,
                  title: "O nome de usuário deve ter de 5 a 16 caracteres!",
                  titleColor: AppColors.secondaryColor,
                  backgroundColor: AppColors.errorColor
                );
                return;
              }
              if(passwordSignUpController.text.trim().length < 8 || passwordSignUpController.text.trim().length > 16){
                showSnackBar(context,
                  title: "A senha deve ter de 8 a 16 caracteres!",
                  titleColor: AppColors.secondaryColor,
                  backgroundColor: AppColors.errorColor
                );
                return;
              }
              if(passwordSignUpController.text.trim() != confirmPasswordSignUpController.text.trim()){
                showSnackBar(context,
                  title: "As senhas devem ser iguais!",
                  titleColor: AppColors.secondaryColor,
                  backgroundColor: AppColors.errorColor
                );
                return;
              }
              setState(() {
                isSignUpLoading = true;
              });
              Server.signUpWithUsernameAndPassword(usernameSignUpController.text.trim(), passwordSignUpController.text.trim()).then((user){
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
                  setState(() {
                    isSignUpLoading = false;
                  });
                  showSnackBar(context,
                    title: "Não foi possível criar a conta!",
                    titleColor: AppColors.whiteColor,
                    backgroundColor: AppColors.errorColor
                  );
                }
              });
            },
            child: isSignUpLoading ?
              const CircularProgressIndicator(
                color: AppColors.whiteColor,
              ) :
              const Text("Cadastrar-me",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const Text("Ou faça login!",
            style: TextStyle(
              color: AppColors.terciaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              hintText: "Insira seu nome de usuário",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.terciaryColor
                )
              )
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: "Insira sua senha",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.terciaryColor
                )
              )
            ),
          ),
          ElevatedButton(
            onPressed: (){
              if(isSignUpLoading || isSignInLoading) return;
              if(usernameController.text.trim().length > 5 || usernameController.text.trim().length > 16
                || passwordController.text.trim().length < 8 || passwordController.text.trim().length > 16){
                showSnackBar(context,
                  title: "Preencha os campos corretamente!",
                  titleColor: AppColors.secondaryColor,
                  backgroundColor: AppColors.errorColor
                );
                return;
              }
              setState(() {
                isSignInLoading = true;
              });
              Server.loginWithUsernameAndPassword(usernameController.text.trim(), passwordController.text.trim()).then((user){
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
                  setState(() {
                    isSignInLoading = false;
                  });
                  showSnackBar(context,
                    title: "Usuário ou/e senha incorreto(s)!",
                    titleColor: AppColors.whiteColor,
                    backgroundColor: AppColors.errorColor
                  );
                }
              });
            },
            child: isSignInLoading ?
              const CircularProgressIndicator(
                color: AppColors.whiteColor,
              ) :
              const Text("Entrar",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}