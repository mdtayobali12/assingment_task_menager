import 'dart:convert';
import 'dart:developer';
import 'package:assingment_task_menager/app.dart';
import 'package:assingment_task_menager/data/models/response_object.dart';
import 'package:assingment_task_menager/presentation/controllers/auth_controller.dart';
import 'package:assingment_task_menager/presentation/screens/auth/sing_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url)async {
    try {
      log(url);
      log( AuthController.accessToken.toString());
      final Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.accessToken ?? ""});

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: true,
          statusCode: 200,
          responseBody: decodedResponse,
        );
      }else if(response.statusCode==401){
        _moveToSingIn();
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: "",
        );
      }else
   {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: "",
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
        isSuccess: false,
        statusCode: -1,
        responseBody: " ",
        errorMassage: e.toString(),
      );
    }
  }

  static Future<ResponseObject> postRequest(String url,
      Map<String, dynamic> body, {bool fromSingIn = false}) async {
    try {
      log(url);
      log(body.toString());
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          'token': AuthController.accessToken ?? " "
        },
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: true,
          statusCode: 200,
          responseBody: decodedResponse,
        );
      }else if(response.statusCode ==401){
       if(fromSingIn) {
         return ResponseObject(
             isSuccess: false,
             statusCode: response.statusCode,
             responseBody: "",
             errorMassage: "Email or Password incorrect. Try again"
         );
       }else{
         _moveToSingIn();
         return ResponseObject(
           isSuccess: false,
           statusCode: response.statusCode,
           responseBody: "",
         );
       }
      } else {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: "",
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
        isSuccess: false,
        statusCode: -1,
        responseBody: " ",
        errorMassage: e.toString(),
      );
    }
  }
 static void _moveToSingIn(){
      AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManager.navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const SingInScreen(),
        ),
        (route) => false);
  }
}
