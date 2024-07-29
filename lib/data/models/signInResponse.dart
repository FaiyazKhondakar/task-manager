import 'package:task_management/data/models/userData.dart';

class SignInResponse {
  String? status;
  String? token;
  UserData? userData;

  SignInResponse({this.status, this.token, this.userData});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}

