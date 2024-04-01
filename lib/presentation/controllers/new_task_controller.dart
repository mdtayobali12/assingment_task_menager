import 'package:assingment_task_menager/data/models/task_list_wrapper.dart';
import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:get/get.dart';

class NewTaskController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  bool get inprogress => _inProgress;

  String get errorMessage => _errorMessage ?? "";

  TaskListWrapper get newTaskListWrapper => _newTaskListWrapper;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    } else {
      _errorMessage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
