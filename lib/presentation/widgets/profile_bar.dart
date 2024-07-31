import 'package:flutter/material.dart';
import 'package:task_management/app.dart';
import 'package:task_management/presentation/controller/auth_controller.dart';
import 'package:task_management/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_management/presentation/screens/update_profile_screen.dart';

import '../utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
            TaskManagerApp.navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      },
      child: Row(
        children: [
          const CircleAvatar(),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AuthController.userData?.firstName} ${AuthController.userData?.lastName}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    '${AuthController.userData!.email} ',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          await AuthController.clearUserData();
          Navigator.pushAndRemoveUntil(
              TaskManagerApp.navigatorKey.currentState!.context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        },
        icon: const Icon(Icons.logout),
        color: Colors.black,
      )
    ],
    backgroundColor: AppColors.themeColor,
  );
}
