import 'package:flutter/material.dart';
import 'package:letstalk/utils/app_colors.dart';
import 'package:letstalk/utils/call_me.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  State<CustomFloatingActionButton> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  bool _isNotInTheEnd = false;

  setThatIsNotInTheEnd(){
    setState(() {
      _isNotInTheEnd = true;
    });
  }

  setThatIsInTheEnd(){
    setState(() {
      _isNotInTheEnd = false;
    });
  }

  @override
  void initState(){
    super.initState();
    CallMe.add("is_not_in_the_end_chat_list", setThatIsNotInTheEnd);
    CallMe.add("is_in_the_end_chat_list", setThatIsInTheEnd);
  }

  @override
  Widget build(BuildContext context) {
    return _isNotInTheEnd ? FloatingActionButton.small(
      onPressed: () => CallMe.call("scroll_down_chat"),
      backgroundColor: AppColors.terciaryColor,
      child: const Icon(Icons.arrow_downward,
        color: AppColors.whiteColor,
      ),
    ) : Container();
  }
}