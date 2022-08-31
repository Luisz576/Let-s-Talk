import 'package:flutter/material.dart';
import 'package:letstalk/models/enums/flag.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';

class MessageTile extends StatelessWidget {
  final String user, message, id;
  final List<Flag> flags;
  final String? imageUrl, messageImage;
  final bool isFromSelf, deleted;
  const MessageTile({required this.deleted, required this.messageImage, required this.id, required this.user, required this.message, required this.flags, required this.isFromSelf, this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isFromSelf ? AppColors.fourthColor : AppColors.fifthColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFromSelf ? Row(
              children: [
                deleted || !isFromSelf ?
                Container() :
                IconButton(
                  onPressed: (){
                    Server.deleteMessage(id);
                  },
                  icon: const Icon(Icons.delete,
                    color: AppColors.terciaryColor,
                  )
                ),
                Expanded(
                  child: Container(),
                ),
                Row(
                  children: flags.map(
                    (flag) => Icon(flag.getIcon(),
                      color: AppColors.terciaryColor,
                      size: 16,
                    )
                  ).toList(),
                ),
                const SizedBox(width: 3,),
                Text(user,
                  style: const TextStyle(
                    color: AppColors.terciaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 10,),
                imageUrl != null && imageUrl!.trim().isNotEmpty ? CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl!),
                ) : CircleAvatar(
                  child: Container(),
                ),
              ],
            ) : Row(
              children: [
                imageUrl != null && imageUrl!.trim().isNotEmpty ? CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl!),
                ) : CircleAvatar(
                  child: Container(),
                ),
                const SizedBox(width: 10,),
                Text(user,
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 3,),
                Row(
                  children: flags.map(
                    (flag) => Icon(flag.getIcon(),
                      color: AppColors.terciaryColor,
                      size: 16,
                    )
                  ).toList(),
                ),
                Expanded(
                  child: Container(),
                ),
                deleted || !isFromSelf ?
                Container() :
                IconButton(
                  onPressed: (){
                    Server.deleteMessage(id);
                  },
                  icon: const Icon(Icons.delete,
                    color: AppColors.terciaryColor,
                  )
                ),
              ],
            ),
            const SizedBox(height: 20,),
            deleted ?
            Text("Mensagem deletada!",
              style: TextStyle(
                color: isFromSelf ? AppColors.terciaryColor : AppColors.blackColor,
                fontSize: 14,
                fontStyle: FontStyle.italic
              ),
            ) :
            messageImage != null && messageImage!.trim().isNotEmpty ?
            Image.network(messageImage!,
              loadingBuilder: (context, child, loadingProgress){
                if(loadingProgress != null){
                  return const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  );
                }else{
                  return child;
                }
              },
            )
            : Text(message,
              style: TextStyle(
                color: isFromSelf ? AppColors.terciaryColor : AppColors.blackColor,
                fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}