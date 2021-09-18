import 'package:flutter/material.dart';

class LoginModel {
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  final formkey = GlobalKey<FormState>();
}

class LoginModelApi {
  Map data;

  String url = 'http://10.0.2.2:8000/api/login';

  Map<String, String> requestHeader = {
    'Accept': 'application/json',
    'Content-type': 'application/json'
  };
}
