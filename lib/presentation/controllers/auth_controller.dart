import 'dart:convert';

import 'package:assingment_task_menager/data/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? accessToken;
  static UserData? userData;

  static Future<void> saveUserData(UserData userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("userData", jsonEncode(userData.toJson()));
    AuthController.userData =userData;
  }

  static Future<UserData?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('userData');
    if (result == null) {
      return null;
    }

    final user = UserData.fromJson(jsonDecode(result));
    AuthController.userData =user;
    return user;
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<bool> isUserLogedIn() async {
    final result = await getUserToken();
    accessToken = result;
    bool loginState = result != null;
    if(loginState==true){
      await getUserData();
    }
    return loginState;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
