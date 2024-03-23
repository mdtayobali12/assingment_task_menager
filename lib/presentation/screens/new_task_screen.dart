import 'package:assingment_task_menager/data/models/count_by_status_wrapper.dart';
import 'package:assingment_task_menager/data/models/task_list_wrapper.dart';
import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/screens/add_new_task_screen.dart';
import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/profile_appbar.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:assingment_task_menager/presentation/widgets/task_card.dart';
import 'package:assingment_task_menager/presentation/widgets/task_counter_card.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskCountByInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();
  bool _getNewTaskListInProgress = false;
  bool _deleteTaskInProgress = false;
  bool _updateTaskInProgress = false;


  @override
  void initState() {
    super.initState();
    _getAllNewTasList();
    _getAllTaskCountByStatus();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    _getAllNewTasList();
    _getAllTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            _getAllTaskCountByInProgress
                ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            )
                : taskCouterSection,
            Expanded(
              child: _getNewTaskListInProgress && _deleteTaskInProgress && _updateTaskInProgress
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : RefreshIndicator(
                onRefresh: () async {
                  _getDataFromApis();
                },
                child: ListView.builder(
                  itemCount: _newTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      color: AppColors.themeColor,
                      taskItems: _newTaskListWrapper.taskList![index],
                      onDelete: () {
                        _deleteTaskById(
                            _newTaskListWrapper.taskList![index].sId!);
                      },
                      onEdit: () {
                        _showUpdateStatusDialog(_newTaskListWrapper
                            .taskList![index].sId!);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
           if (result != null && result == true ) {
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

  Widget get taskCouterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: _countByStatusWrapper.listOfTaskBydata?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              TaskTitle:
              _countByStatusWrapper.listOfTaskBydata![index].sId ?? "",
              TaskCount:
              _countByStatusWrapper.listOfTaskBydata![index].sum ?? 0,
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
              ListTile(title: const Text("Completed"), onTap: () {
                _updateTaskById(id, "Completed");
              },),
              ListTile(title: const Text("Progress"), onTap: () {
                _updateTaskById(id, "Progress");
              },),
              ListTile(title: const Text("Cancelled"), onTap: () {
                _updateTaskById(id, "Cancelled");
              },),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getAllNewTasList() async {
    _getAllTaskCountByInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByInProgress = false;
      setState(() {});
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMassage ??
                'Get Task Count by status has beet failed');
      }
    }
  }

  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInProgress = false;
      setState(() {});
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Get new task list hes been failed');
      }
    }
  }

  Future<void> _deleteTaskById(String id,) async {
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
    final response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(id, status));
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
