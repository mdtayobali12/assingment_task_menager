import 'package:assingment_task_menager/data/models/task_by_status_data.dart';
import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:assingment_task_menager/presentation/controllers/new_task_controller.dart';
import 'package:assingment_task_menager/presentation/screens/add_new_task_screen.dart';
import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/profile_appbar.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:assingment_task_menager/presentation/widgets/task_card.dart';
import 'package:assingment_task_menager/presentation/widgets/task_counter_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _deleteTaskInProgress = false;
  bool _updateTaskInProgress = false;

  @override
  void initState() {
    super.initState();

    _getDataFromApis();
  }

  void _getDataFromApis() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CountTaskByStatusController>(
            builder: (countTaskByStatusController) {
          return Column(
            children: [
              countTaskByStatusController.inProgress
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    )
                  : taskCouterSection(
                      countTaskByStatusController
                              .countByStatuswrapper.listOfTaskBydata ??
                          [],
                    ),
              GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Expanded(
                  child: newTaskController.inprogress &&
                          newTaskController.inprogress &&
                          newTaskController.inprogress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            _getDataFromApis();
                          },
                          child: ListView.builder(
                            itemCount: newTaskController
                                    .newTaskListWrapper.taskList?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                color: AppColors.themeColor,
                                taskItems: newTaskController
                                    .newTaskListWrapper.taskList![index],
                                onDelete: () {
                                  _deleteTaskById(newTaskController
                                      .newTaskListWrapper
                                      .taskList![index]
                                      .sId!);
                                },
                                onEdit: () {
                                  _showUpdateStatusDialog(newTaskController
                                      .newTaskListWrapper
                                      .taskList![index]
                                      .sId!);
                                },
                              );
                            },
                          ),
                        ),
                );
              }),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        onPressed: () {
          final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (result != null && result == true) {
            _getDataFromApis();
          }
        },
        label: const Row(
          children: [
            Icon(Icons.add),
            Text(
              "Add",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget taskCouterSection(List<TaskByStatusData> listOfTaskBydata) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskBydata.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              TaskTitle: listOfTaskBydata[index].sId ?? " ",
              TaskCount: listOfTaskBydata[index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text("New"),
                trailing: Icon(Icons.check),
              ),
              ListTile(
                title: const Text("Completed"),
                onTap: () {
                  _updateTaskById(id, "Completed");
                },
              ),
              ListTile(
                title: const Text("Progress"),
                onTap: () {
                  _updateTaskById(id, "Progress");
                },
              ),
              ListTile(
                title: const Text("Cancelled"),
                onTap: () {
                  _updateTaskById(id, "Cancelled");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(
      Urls.deleteTaskStatus(id),
    );
    _deleteTaskInProgress = false;
    if (response.isSuccess) {
      _getDataFromApis();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMassage ?? 'Delete task hes been failed',
        );
      }
    }
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskInProgress = false;
    if (response.isSuccess) {
      _getDataFromApis();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMassage ?? 'Update task status hes been failed',
        );
      }
    }
  }
}
