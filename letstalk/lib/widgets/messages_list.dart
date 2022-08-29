import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/widgets/message_tile.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final queryFirestore = Server.getMessages();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Server.getMessages(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return const Center(
            child: Text("Houve um problema ao carregar..."),
          );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.terciaryColor,
            ),
          );
        }
        //TODO
        final data = snapshot.requireData;
        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            print(data);
            return Container();
          },
        );
      },
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (context, index){
        bool isFromSelf = Server.currentUser!.id == _messages[index].owner.id;
        double pl = isFromSelf ? MediaQuery.of(context).size.width / 5 : 0,
              pr = !isFromSelf ? MediaQuery.of(context).size.width / 5 : 0;
        return Padding(
          padding: EdgeInsets.only(left: pl, bottom: 10, top: 10, right: pr),
          child: MessageTile(
            flags: _messages[index].owner.flags,
            user: _messages[index].owner.username,
            isFromSelf: isFromSelf,
            message: _messages[index].message,
            imageUrl: _messages[index].owner.urlImage,
          ),
        );
      },
    );
  }
  */
}