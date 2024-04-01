import 'package:assingment_task_menager/data/models/response_object.dart';
import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:get/get.dart';

class SingUpController extends GetxController {
  bool _InProgress = false;
  String? _errorMassage;

  bool get inProgress => _InProgress;

  String get errorMessage => _errorMassage ?? "Login failed ! Try again";
  String get errorMessageSuccess => _errorMassage ?? 'Registration success! Please login';

  Future<bool> singUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    _InProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password
    };
    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.registration, inputParams,
        fromSingIn: true);

    _InProgress = false;

    if (response.isSuccess) {
      update();
      return true;
    }else{
      _errorMassage = response.errorMassage;
      return false;
    }

    }
  }

