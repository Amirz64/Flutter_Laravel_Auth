import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter3/Models/register_model.dart';
import 'package:flutter3/View/Components/snackbar.dart';
import 'package:flutter3/data_operations.dart';
import 'package:http/http.dart' as http;


class RegisterRequest extends ChangeNotifier {
  RegisterModelApi _model = RegisterModelApi();

  RegisterModelApi get model => _model;

  Future register({
    BuildContext context,
    String username,
    password,
    email,
    confirmpassword,
  }) async {
    http.Response register = await http.post(
      Uri.parse(_model.url),
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmpassword,
      }),
      headers: _model.requestHeader,
    );

    _model.data = json.decode(register.body);

    if (_model.data['username'] != null &&
        _model.data['username'][0] == 'The username has already been taken.')
      _model.userTaken = true;
    else
      _model.userTaken = false;

    if (_model.data['email'] != null &&
        _model.data['email'][0] == 'The email has already been taken.')
      _model.emailTaken = true;
    else
      _model.emailTaken = false;

    if (_model.data['message'] == 'ip is available') {
      showSnackBar(
        color: Colors.red,
        context: context,
        text: 'امکان ثبت نام برای شما وجود ندارد',
      );
    }

    print(_model.data);

    if (register.statusCode == 201) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      saveData(
        username: _model.data['username'],
        email: _model.data['email'],
        token: _model.data['token'],
      );
    }

    notifyListeners();
  }
}
