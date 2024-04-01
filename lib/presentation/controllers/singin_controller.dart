import 'package:assingment_task_menager/data/models/login_response.dart';
import 'package:assingment_task_menager/data/models/response_object.dart';
import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SingInController extends GetxController {
  bool _InProgress = false;
  String? _errorMassage;
  bool get inProgress => _InProgress;
  String get errorMessage =>_errorMassage??" ";

  Future<bool> singIn(String email, String password) async {
    _InProgress = true;
    update();
    Map<String, dynamic> inputParams = {"email": email, "password": password};
    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.login, inputParams,
        fromSingIn: true);
    _InProgress = false;

    if (response.isSuccess) {
      LoginResponse loginResponse = LoginResponse.fromJson(
        response.responseBody,
      );
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);
      print(loginResponse.userData!.firstName);
      update();
      return true;
    } else {
      _errorMassage=response.errorMassage;
      update();
      return false;
    }
  }
}
