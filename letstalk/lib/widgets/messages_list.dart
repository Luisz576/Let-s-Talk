import 'package:flutter/material.dart';
import 'package:letstalk/models/message.dart';
import 'package:letstalk/services/server.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/utils/call_me.dart';
import 'package:letstalk/widgets/message_tile.dart';
import 'package:letstalk/widgets/message_tile_error.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final _scrollController = ScrollController();
  List<Message> messages = [];

  void _scrollDown() {
    if(_scrollController.hasClients){
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  void initState(){
    super.initState();
    CallMe.add("scroll_down_chat", _scrollDown);
    _registerServerListener();
  }

  _registerServerListener(){
    Server.getMessages().listen((data) async{
      List<Message> newMessages = [];
      for(Future<Message> message in data){
        newMessages.add(await message);
      }
      setState((){
        messages.clear();
        messages = newMessages;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length,
      physics: const BouncingScrollPhysics(),
      reverse: true,
      itemBuilder: (context, index) {
        if(messages[index].owner == null){
          return Padding(
            padding: EdgeInsets.only(left: 10,bottom: 10, top: 10, right: MediaQuery.of(context).size.width / 5),
            child: const MessageTileError()
          );
        }
        bool isFromSelf = Server.currentUser!.id == messages[index].owner!.id;
        double pl = isFromSelf ? MediaQuery.of(context).size.width / 5 : 10,
        pr = !isFromSelf ? MediaQuery.of(context).size.width / 5 : 10;
        return Padding(
          padding: EdgeInsets.only(left: pl, bottom: 10, top: 10, right: pr),
          child: MessageTile(
            id: messages[index].id,
            flags: messages[index].owner!.flags,
            user: messages[index].owner!.username,
            isFromSelf: isFromSelf,
            message: messages[index].message,
            imageUrl: messages[index].owner!.urlImage,
            deleted: messages[index].deleted,
            messageImage: messages[index].imageUrl
          ),
        );
      },
    );
  }
}