import 'package:flutter/material.dart';
import 'package:letstalk/functions/show_snack_bar.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';

class TypeAreaComponent extends StatelessWidget {
  final typeController = TextEditingController();
  TypeAreaComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: typeController,
                maxLength: 160,
                buildCounter: (context, {currentLength = 0, isFocused = false, maxLength}) => null,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  hintText: "Escreva aqui...",
                  hintStyle: TextStyle(
                    color: AppColors.hintGrayColor
                  ),
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: (){
                  if(typeController.text.trim().isNotEmpty){
                    Server.sendMessage(typeController.text.trim()).then((res){
                      if(!res){
                        showSnackBar(context,
                          title: "Não foi possível enviar...",
                          titleColor: AppColors.whiteColor,
                          backgroundColor: AppColors.errorColor,
                          duration: const Duration(milliseconds: 500)
                        );
                      }else{
                        typeController.text = "";
                      }
                    });
                  }
                },
                icon: const Icon(Icons.send, color: AppColors.whiteColor,),
              ),
            )
          ],
        ),
      ),
    );
  }
}