import 'package:flutter/material.dart';
import 'package:letstalk/screens/settings_screen.dart';
import 'package:letstalk/tabs/chat_tab.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/utils/custom_floating_action_button_location.dart';
import 'package:letstalk/widgets/custom_floating_action_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Let's Talk",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
            },
            icon: const Icon(Icons.settings,
              color: AppColors.whiteColor,
            )
          )
        ],
      ),
      backgroundColor: AppColors.whiteColor,
      body: const SafeArea(
        child: ChatTab(),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
              MediaQuery.of(context).size.width * (5.1/6),
              MediaQuery.of(context).size.height * (3.9/5),
      ),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}