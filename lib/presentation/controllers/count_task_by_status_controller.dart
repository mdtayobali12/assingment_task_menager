import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:get/get.dart';

import '../../data/models/count_by_status_wrapper.dart';

class CountTaskByStatusController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  String? _errorMessage;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  bool get inProgress => _inProgress;

  String get errorMessage =>
      _errorMessage ?? "Fetch Count by task status failed! ";

  CountByStatusWrapper get countByStatuswrapper => _countByStatusWrapper;

  Future<bool> getCountByTaskStatus() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    _inProgress = false;
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage;
    }
    update();
    return isSuccess;
  }
}
