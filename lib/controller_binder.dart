import 'package:assingment_task_menager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:assingment_task_menager/presentation/controllers/new_task_controller.dart';
import 'package:assingment_task_menager/presentation/controllers/singin_controller.dart';
import 'package:assingment_task_menager/presentation/controllers/sinup_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SingInController());
    Get.lazyPut(() => SingUpController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
  }

}