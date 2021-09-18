import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter3/Models/changepass_model.dart';
import 'package:flutter3/View/Components/snackbar.dart';
import 'package:http/http.dart' as http;

class ChangePasswordRequest extends ChangeNotifier {
  ChangePasswordModel _model = ChangePasswordModel();
  ChangePasswordModel get model => _model;
  
  Future changePassword(
      {String oldPassword, newPassword, username, BuildContext context}) async {
    http.Response change = await http.put(Uri.parse(_model.url),
        body: jsonEncode({
          'username': username,
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: _model.requestHeaders);

    switch (change.statusCode) {
      case 404:
        showSnackBar(
          context: context,
          color: Colors.red,
          text: 'رمز عبور اشتباه است',
        );
        break;
      case 200:
        showSnackBar(
          context: context,
          color: Colors.teal,
          text: 'رمز عبور با موفقیت تغییر کرد',
        );
        break;
      case 401:
        showSnackBar(
          context: context,
          color: Colors.red,
          text: 'خطا در اعتبارسنجی توکن - لطفا دوباره وارد شوید',
        );
        break;

        case 404 : 
        showSnackBar(
          context: context,
          color: Colors.red,
          text:'خطا',
        );
    }
  }
}
