import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_management/app.dart';
import 'package:task_management/data/models/response_object.dart';
import 'package:task_management/presentation/controller/auth_controller.dart';
import 'package:task_management/presentation/screens/auth/sign_in_screen.dart';

class NetworkCaller{
  static Future<ResponseObject> getRequest(String url) async{
    try{
      final Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.accessToken ?? ''});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return ResponseObject(
            statusCode: 200, responseBody: decodeResponse, isSuccess: true);
      }
      else if(response.statusCode == 401){
        _moveToSignIn();
        return ResponseObject(
            statusCode: response.statusCode,
            responseBody: '',
            isSuccess: false);
      }
      else {
        return ResponseObject(
            statusCode: response.statusCode,
            responseBody: '',
            isSuccess: false);
      }
    }catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMassage: e.toString());
    }
  }
  static Future<ResponseObject> postRequest(String url , Map<String , dynamic> body,{bool fromSignIn = false}) async{
    try{
      log(url);
      log(body.toString());
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'content-type': 'application/json' , 'token': AuthController.accessToken ??''});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        return ResponseObject(
            statusCode: 200, responseBody: decodeResponse, isSuccess: true);
      }else if(response.statusCode == 401){
        if(fromSignIn){
          return ResponseObject(
              isSuccess: false,
              statusCode: response.statusCode,
              responseBody: '',
              errorMassage: 'Email/Password is incorrect! Try Again');
        }
        else{
          _moveToSignIn();
          return ResponseObject(
              statusCode: response.statusCode,
              responseBody: '',
              isSuccess: false);
        }
      }
      else {
        return ResponseObject(
            statusCode: response.statusCode,
            responseBody: '',
            isSuccess: false);
      }
    }catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMassage: e.toString());
    }
  }
  static Future<void> _moveToSignIn() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentState!.context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }
}