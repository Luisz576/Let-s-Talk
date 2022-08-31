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

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState(){
    super.initState();
    CallMe.add("scroll_down_chat", _scrollDown);
  }

  @override
  Widget build(BuildContext context) {
    //TODO FIX STREAM THAT RELOAD ALL LIST
    return StreamBuilder<List<Future<Message>>>(
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
        final data = snapshot.requireData;
        return ListView.builder(
          controller: _scrollController,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return FutureBuilder<Message>(
              future: data[index],
              builder: (context, asyncSnapshot){
                if(asyncSnapshot.hasError){
                  return Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: MediaQuery.of(context).size.width / 5),
                    child: const MessageTileError()
                  );
                }
                if(asyncSnapshot.connectionState == ConnectionState.waiting){
                  return Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: MediaQuery.of(context).size.width / 5),
                      child:Container(
                      color: AppColors.fifthColor,
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Loading...",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                      )
                    )
                  );
                }
                if(asyncSnapshot.data!.owner == null){
                  return Padding(
                    padding: EdgeInsets.only(left: 10,bottom: 10, top: 10, right: MediaQuery.of(context).size.width / 5),
                    child: const MessageTileError()
                  );
                }
                bool isFromSelf = Server.currentUser!.id == asyncSnapshot.data!.owner!.id;
                double pl = isFromSelf ? MediaQuery.of(context).size.width / 5 : 10,
                      pr = !isFromSelf ? MediaQuery.of(context).size.width / 5 : 10;
                return Padding(
                  padding: EdgeInsets.only(left: pl, bottom: 10, top: 10, right: pr),
                  child: MessageTile(
                    id: asyncSnapshot.data!.id,
                    flags: asyncSnapshot.data!.owner!.flags,
                    user: asyncSnapshot.data!.owner!.username,
                    isFromSelf: isFromSelf,
                    message: asyncSnapshot.data!.message,
                    imageUrl: asyncSnapshot.data!.owner!.urlImage,
                    deleted: asyncSnapshot.data!.deleted,
                    messageImage: asyncSnapshot.data!.imageUrl
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}