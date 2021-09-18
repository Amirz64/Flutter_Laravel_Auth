import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChangePasswordModel {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  BuildContext context;

  String url = 'http://10.0.2.2:8000/api/change/password';
  static String token = Hive.box('user').get('token');

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
