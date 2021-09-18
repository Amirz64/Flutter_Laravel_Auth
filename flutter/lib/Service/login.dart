import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter3/Models/login_model.dart';
import 'package:flutter3/View/Components/snackbar.dart';
import 'package:http/http.dart' as http;
import '../data_operations.dart';

class LoginRequest extends ChangeNotifier {
  LoginModelApi _model = LoginModelApi();
  LoginModelApi get model => _model;

  Future login({BuildContext context, String username, String password}) async {
    http.Response login = await http.post(Uri.parse(_model.url),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: _model.requestHeader);

    _model.data = json.decode(login.body);

    if (login.statusCode == 202) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      saveData(
        username: _model.data['username'],
        email: _model.data['email'],
        token: _model.data['token'],
      );
    }

    if (_model.data['error'] != null) {
      showSnackBar(
        color: Colors.red,
        context: context,
        text: 'خطا در اعتبار سنجی اطلاعات',
      );
    }

    notifyListeners();
  }
}
