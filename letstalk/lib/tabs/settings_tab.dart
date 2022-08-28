import 'package:flutter/material.dart';
import 'package:letstalk/functions/show_snack_bar.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/widgets/editable_camp.dart';
import 'package:letstalk/widgets/large_button.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool isUploading = false;

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
            onPressed: () async{
              //TODO
              setState(() {
                isUploading = true;
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