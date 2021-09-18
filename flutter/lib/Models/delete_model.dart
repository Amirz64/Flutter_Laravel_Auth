import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DeleteAccountModel {
  TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  String url = 'http://10.0.2.2:8000/api/delete';
  static String token = Hive.box('user').get('token');

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

class DeleteTokenModel {
  String url = 'http://10.0.2.2:8000/api/delete/token';

  static String token = Hive.box('user').get('token');

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
