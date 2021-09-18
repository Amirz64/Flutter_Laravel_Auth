import 'package:flutter/material.dart';

class RegisterModel {
  String pass;
  
  TextEditingController password;
  TextEditingController username;
  TextEditingController confirmPassword;
  TextEditingController email;

  final formkey = GlobalKey<FormState>();
}

class RegisterModelApi {
  Map data;

  bool emailTaken = false;
  bool userTaken = false;

  String url = 'http://10.0.2.2:8000/api/register';

  Map<String, String> requestHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
}
