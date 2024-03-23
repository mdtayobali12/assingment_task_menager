import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isErrorMessage ? Colors.red : AppColors.themeColor,
      content: Text(message),
    ),
  );
}
