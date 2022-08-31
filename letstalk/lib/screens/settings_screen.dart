import 'package:flutter/material.dart';
import 'package:letstalk/tabs/settings_tab.dart';
import 'package:letstalk/utils/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Let's Talk",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
          ),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: const SafeArea(
        child: SettingsTab(),
      ),
    );
  }
}