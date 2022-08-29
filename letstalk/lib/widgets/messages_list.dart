import 'package:flutter/material.dart';
import 'package:letstalk/models/message.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/widgets/message_tile.dart';

class MessagesList extends StatelessWidget {
  MessagesList({Key? key}) : super(key: key);

  //TODO
  final _messages = <Message>[];

  @override
  Widget build(BuildContext context) {
    return _messages.isNotEmpty ?
      ListView.builder(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index){
          bool isFromSelf = Server.currentUser!.username == _messages[index].owner.username;
          double pl = isFromSelf ? MediaQuery.of(context).size.width / 5 : 0,
                pr = !isFromSelf ? MediaQuery.of(context).size.width / 5 : 0;
          return Padding(
            padding: EdgeInsets.only(left: pl, bottom: 10, top: 10, right: pr),
            child: MessageTile(
              user: _messages[index].owner.username,
              isFromSelf: isFromSelf,
              message: _messages[index].message,
              imageUrl: _messages[index].owner.urlImage,
            ),
          );
        },
      ) :
      const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text("Esta sala está vazia :(",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor
          ),
        ),
      );
  }
}