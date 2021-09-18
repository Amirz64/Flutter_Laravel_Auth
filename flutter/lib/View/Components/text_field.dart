// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  TxtField({
    Key key,
    this.label,
    this.errorText,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  TextEditingController controller;
  String label, errorText;
  Icon prefixIcon;
  String Function(String) validator;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            errorText: errorText,
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
