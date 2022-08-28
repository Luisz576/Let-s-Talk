import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letstalk/functions/show_snack_bar.dart';
import 'package:letstalk/screens/login_screen.dart';
import 'package:letstalk/services/database.dart';
import 'package:letstalk/services/files.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/widgets/custom_input.dart';
import 'package:letstalk/widgets/editable_camp.dart';
import 'package:letstalk/widgets/large_button.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool isUploading = false, isChangingPassword = false;
  final TextEditingController currentPassowordController = TextEditingController(),
                              newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(Server.currentUser == null){
      Navigator.pop(context);
      return const Text("Error...");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      child: Column(
        children: [
          const Text("Configurações",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 28
            ),
          ),
          const SizedBox(height: 20,),
          EditableCamp(
            onIconSaveIsPressed: (text){
              if(text.length < 5 || text.length > 16){
                showSnackBar(context,
                  title: "Nome de usuário inválido!",
                  titleColor: AppColors.whiteColor,
                  backgroundColor: AppColors.errorColor,
                );
                return;
              }
              if(text == Server.currentUser!.username){
                showSnackBar(context,
                  title: "Nenhuma alteração detectada!",
                  titleColor: AppColors.whiteColor,
                  backgroundColor: AppColors.errorColor,
                );
                return;
              }
              Server.changeUsername(text).then((res) {
                if(res){
                  showSnackBar(context,
                    title: "Nome de usuário alterado!",
                    titleColor: AppColors.whiteColor,
                    backgroundColor: AppColors.sucessColor,
                  );
                  setState((){});
                }else{
                  showSnackBar(context,
                    title: "Não foi possível alterar o nome de usuário!",
                    titleColor: AppColors.whiteColor,
                    backgroundColor: AppColors.errorColor,
                  );
                }
              });
            },
            maxLength: 16,
            hintText: Server.currentUser!.username,
            style: EditableCampStyle(
              iconColor: AppColors.terciaryColor
            ),
          ),
          const SizedBox(height: 20,),
          LargeButton(
            onPressed: (){
              Files.pickImage().then((file) {
                if(file != null){
                  setState(() {
                    isUploading = true;
                  });
                  Server.changeProfileImage(file).then((res){
                    if(res){
                      showSnackBar(context,
                        title: "Imagem alterada com sucesso!",
                        backgroundColor: AppColors.sucessColor,
                        titleColor: AppColors.whiteColor
                      );
                    }else{
                      showSnackBar(context,
                        title: "Não foi possível alterar a imagem de perfil!",
                        backgroundColor: AppColors.errorColor,
                        titleColor: AppColors.whiteColor
                      );
                    }
                    setState(() {
                      isUploading = false;
                    });
                  });
                }else{
                  showSnackBar(context,
                    title: "Nenhum imagem selecionada!",
                    backgroundColor: AppColors.errorColor,
                    titleColor: AppColors.whiteColor
                  );
                }
              });
            },
            backgroundColor: AppColors.secondaryColor,
            child: isUploading ?
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              ) :
              const Text("Trocar foto de perfil",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 18
                ),
              ),
          ),
          const SizedBox(height: 20,),
          CustomInput(
            controller: currentPassowordController,
            borderColor: AppColors.secondaryColor,
            hintColor: AppColors.hintSecondaryColor,
            hintText: "Senha atual",
            obscureText: true,
          ),
          const SizedBox(height: 20,),
          CustomInput(
            controller: newPasswordController,
            borderColor: AppColors.secondaryColor,
            hintColor: AppColors.hintSecondaryColor,
            hintText: "Senha nova",
            obscureText: true,
          ),
          const SizedBox(height: 20,),
          LargeButton(
            onPressed: (){
              if(currentPassowordController.text.trim().length < 8 || currentPassowordController.text.trim().length > 16
                || newPasswordController.text.trim().length < 8 || newPasswordController.text.trim().length > 16){
                  showSnackBar(context,
                    title: "A senha deve ter de 8 a 16 caracteres!",
                    backgroundColor: AppColors.errorColor,
                    titleColor: AppColors.whiteColor
                  );
                  return;
              }
              if(currentPassowordController.text.trim() != newPasswordController.text.trim()){
                showSnackBar(context,
                  title: "As senhas devem ser iguais",
                  backgroundColor: AppColors.errorColor,
                  titleColor: AppColors.whiteColor
                );
                return;
              }
              setState(() {
                isChangingPassword = true;
              });
              Server.changePassword(currentPassowordController.text.trim(), newPasswordController.text.trim()).then((res){
                setState(() {
                  isChangingPassword = false;
                });
                if(res){
                  showSnackBar(context,
                    title: "Senha alterada com sucesso!",
                    backgroundColor: AppColors.sucessColor,
                    titleColor: AppColors.whiteColor
                  );
                }else{
                  showSnackBar(context,
                    title: "Não foi possível alterar a senha!",
                    backgroundColor: AppColors.errorColor,
                    titleColor: AppColors.whiteColor
                  );
                }
              });
            },
            backgroundColor: AppColors.secondaryColor,
            child: isChangingPassword ?
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              ) :
              const Text("Alterar senha",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
          ),
          const SizedBox(height: 20,),
          LargeButton(
            onPressed: (){
              Database.unsaveToken().then((res){
                if(res){
                  Server.logout();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                  showSnackBar(context,
                    title: "Deslogado com sucesso!",
                    backgroundColor: AppColors.sucessColor,
                    titleColor: AppColors.whiteColor
                  );
                }else{
                  showSnackBar(context,
                    title: "Erro ao deslogar...",
                    backgroundColor: AppColors.errorColor,
                    titleColor: AppColors.whiteColor
                  );
                }
              });
            },
            backgroundColor: AppColors.terciaryColor,
            child: const Text("Logout",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          )
        ],
      ),
    );
  }
}