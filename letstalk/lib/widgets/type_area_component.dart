import 'package:flutter/material.dart';
import 'package:letstalk/functions/show_snack_bar.dart';
import 'package:letstalk/services/files.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/widgets/expanded_icon_button.dart';

class TypeAreaComponent extends StatefulWidget {
  const TypeAreaComponent({Key? key}) : super(key: key);

  @override
  State<TypeAreaComponent> createState() => _TypeAreaComponentState();
}

class _TypeAreaComponentState extends State<TypeAreaComponent> {
  final typeController = TextEditingController();
  bool isUploadingSomething = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: TextField(
                controller: typeController,
                maxLength: 160,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                buildCounter: (context, {currentLength = 0, isFocused = false, maxLength}) => null,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  hintText: "Escreva aqui...",
                  hintStyle: TextStyle(
                    color: AppColors.hintGrayColor
                  ),
                  labelText: "Escreva aqui sua mensagem",
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none
                ),
              ),
            ),
            ExpandedIconButton(
              flex: 1,
              onPressed: (){
                if(isUploadingSomething){ return; }
                setState(() {
                  isUploadingSomething = true;
                });
                Files.pickImage().then((file) {
                  if(file != null){
                    Server.sendImage(file,
                      whenComplete: (){
                        setState(() {
                          isUploadingSomething = false;
                        });
                      },
                      whenError: (){
                        showSnackBar(context,
                          title: "Não foi possível enviar a imagem!",
                          backgroundColor: AppColors.errorColor,
                          titleColor: AppColors.whiteColor
                        );
                        setState(() {
                          isUploadingSomething = false;
                        });
                      }
                    );
                  }else{
                    showSnackBar(context,
                      title: "Nenhum imagem selecionada!",
                      backgroundColor: AppColors.errorColor,
                      titleColor: AppColors.whiteColor
                    );
                    setState(() {
                      isUploadingSomething = false;
                    });
                  }
                });
              },
              icon: Icons.photo,
              iconColor: AppColors.whiteColor,
            ),
            ExpandedIconButton(
              flex: 1,
              onPressed: (){
                if(isUploadingSomething){ return; }
                setState(() {
                  isUploadingSomething = true;
                });
                Files.takePhoto().then((file) {
                  if(file != null){
                    Server.sendImage(file,
                      whenComplete: (){
                        setState(() {
                          isUploadingSomething = false;
                        });
                      },
                      whenError: (){
                        showSnackBar(context,
                          title: "Não foi possível enviar a imagem!",
                          backgroundColor: AppColors.errorColor,
                          titleColor: AppColors.whiteColor
                        );
                        setState(() {
                          isUploadingSomething = false;
                        });
                      }
                    );
                  }else{
                    showSnackBar(context,
                      title: "Nenhum imagem selecionada!",
                      backgroundColor: AppColors.errorColor,
                      titleColor: AppColors.whiteColor
                    );
                    setState(() {
                      isUploadingSomething = false;
                    });
                  }
                });
              },
              icon: Icons.camera_alt,
              iconColor: AppColors.whiteColor,
            ),
            isUploadingSomething ? const CircularProgressIndicator(
              color: AppColors.whiteColor,
            ) : ExpandedIconButton(
              flex: 1,
              onPressed: (){
                if(isUploadingSomething){ return; }
                if(typeController.text.trim().isNotEmpty){
                  setState(() {
                    isUploadingSomething = true;
                  });
                  FocusScope.of(context).unfocus();
                  Server.sendMessage(typeController.text.trim()).then((res){
                    if(!res){
                      showSnackBar(context,
                        title: "Não foi possível enviar...",
                        titleColor: AppColors.whiteColor,
                        backgroundColor: AppColors.errorColor,
                        duration: const Duration(milliseconds: 500)
                      );
                    }else{
                      typeController.clear();
                    }
                    setState(() {
                      isUploadingSomething = false;
                    });
                  });
                }
              },
              icon: Icons.send,
              iconColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}