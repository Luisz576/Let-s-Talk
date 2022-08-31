import 'package:flutter/material.dart';
import 'package:letstalk/widgets/messages_list.dart';
import 'package:letstalk/widgets/type_area_component.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          flex: 5,
          child: MessagesList(),
        ),
        Expanded(
          flex: 1,
          child: TypeAreaComponent(),
        )
      ],
    );
  }
}