import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter3/Models/delete_model.dart';
import 'package:flutter3/View/Components/snackbar.dart';
import 'package:flutter3/data_operations.dart';
import 'package:http/http.dart' as http;

class DeleteAccountRequest extends ChangeNotifier {
  DeleteAccountModel _model = DeleteAccountModel();
  DeleteAccountModel get model => _model;

  Future deleteAccount(
      {String username, password, BuildContext context}) async {
    http.Response delete = await http.delete(Uri.parse(_model.url),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: _model.requestHeaders);

    switch (delete.statusCode) {
      case 200:
        clearData();
        showSnackBar(
          context: context,
          color: Colors.teal,
          text: 'حساب شما با موفقیت حذف شد',
        );
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/signup', (route) => false);
        break;

      case 404:
        showSnackBar(
          context: context,
          color: Colors.red,
          text: 'رمز عبور اشتباه است',
        );
        break;

      case 401:
        showSnackBar(
          context: context,
          color: Colors.red,
          text: 'خطا در اعتبارسنجی توکن - لطفا دوباره وارد شوید',
        );
        break;
    }
  }
}

class DeleteTokenRequest extends ChangeNotifier {
  DeleteTokenModel _model = DeleteTokenModel();

  Future deleteToken({String username, BuildContext context}) async {
    http.Response deleteToken = await http.delete(Uri.parse(_model.url),
        body: jsonEncode({
          'username': username,
        }),
        headers: _model.requestHeaders);

    switch (deleteToken.statusCode) {
      case 401:
        clearData();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/signup', (route) => false);
        showSnackBar(
          context: context,
          color: Colors.red,
          text: 'خطا در اعتبارسنجی توکن - لطفا دوباره وارد شوید',
        );
        break;

      case 200:
        clearData();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/signup', (route) => false);
        showSnackBar(
          context: context,
          color: Colors.teal,
          text: 'شما با موفقیت از حساب خود خارج شدید',
        );
        break;

      case 404:
        showSnackBar(
          context: context,
          color: Colors.red,
          text: 'خطا',
        );
        break;
    }
  }
}
