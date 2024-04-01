import 'package:assingment_task_menager/controller_binder.dart';
import 'package:assingment_task_menager/presentation/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/utils/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey:TaskManager.navigatorKey ,
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      home: const SplashScreen(),
      theme: _themeData,
      initialBinding: ControllerBinder(),
    );
  }
  final ThemeData _themeData = ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.themeColor,
          foregroundColor: AppColors.iconColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: AppColors.themeColor,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16))),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
      ),
      chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )
      )
  );

}