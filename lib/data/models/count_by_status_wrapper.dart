import 'package:assingment_task_menager/data/models/task_by_status_data.dart';

class CountByStatusWrapper {
  String? status;
  List<TaskByStatusData>? listOfTaskBydata;

  CountByStatusWrapper({this.status, this.listOfTaskBydata});

  CountByStatusWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskBydata = <TaskByStatusData>[];
      json['data'].forEach((v) {
        listOfTaskBydata!.add( TaskByStatusData.fromJson(v));
      });
    }
  }

}

