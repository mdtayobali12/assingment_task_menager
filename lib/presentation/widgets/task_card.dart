import 'package:assingment_task_menager/data/models/task_items.dart';
import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskItems,
    required this.onDelete,
    required this.onEdit, required this.color,
  });
  final TaskItems taskItems;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Color color ;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskItems.title??"", style:const TextStyle(fontWeight: FontWeight.bold,  ),),
            Text(taskItems.description??" "),
            Text("Date: ${taskItems.createdDate ?? " "}"),
            Row(

              children: [
               Chip(
                 backgroundColor:color,
                  label: Text(taskItems.status??"", style:const TextStyle(color:Colors.white)),
                ),
                const Spacer(),
                IconButton(
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.themeColor,
                    )),
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}


