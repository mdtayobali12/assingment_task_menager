import 'dart:convert';

import 'package:assingment_task_menager/app.dart';
import 'package:assingment_task_menager/presentation/controllers/auth_controller.dart';
import 'package:assingment_task_menager/presentation/screens/auth/sing_in_screen.dart';
import 'package:assingment_task_menager/presentation/screens/auth/update_profile_screen.dart';
import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget get ProfileAppBar{
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title:  GestureDetector(
      onTap: () {
          Navigator.push(
              TaskManager.navigatorKey.currentState!.context,
              MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen(),
              ));

      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: (AuthController.userData!.photo ?? null) != null
                ? MemoryImage(base64Decode(AuthController.userData!.photo!
                .split('data:image/png;base64,')
                .last))
                : null,
          ),
          const SizedBox(width: 10,),
         Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.FullName??" " ,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                   AuthController.userData!.email??" ",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () async{
            await AuthController.clearUserData();

            Navigator.pushAndRemoveUntil(
                TaskManager.navigatorKey.currentState!.context,
                MaterialPageRoute(builder: (context) => const SingInScreen(),), (
                route) => false);
          },icon: const Icon(Icons.logout_outlined), color:Colors.white,)
        ],
      ),
    ),
  );
}