import 'package:flutter/material.dart';
import 'package:flutter3/Models/changepass_model.dart';
import 'package:flutter3/Service/change_password.dart';
import 'package:flutter3/View/Components/button.dart';
import 'package:flutter3/View/Components/text_field.dart';
import 'package:flutter3/View/Components/modal_bottm_sheet.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({Key key}) : super(key: key);

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  // Models/changepass_model.dart
  ChangePasswordModel _model = ChangePasswordModel();

  @override
  void dispose() {
    super.dispose();
    _model.newPassword.dispose();
    _model.oldPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //Service/change_password.dart
      create: (context) => ChangePasswordRequest(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color(0xFFfafafa),
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              'تغییر رمز',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: Consumer<ChangePasswordRequest>(
            builder: (context, req, child) => Form(
              key: req.model.formKey,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // View/Components/text_field.dart
                  TxtField(
                    label: 'رمز عبور فعلی',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock),
                    controller: req.model.oldPassword,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'رمز عبور فعلی اجباری است';
                      }
                      if (value.isNotEmpty && value.length < 8) {
                        return 'رمز عبور می بایست حداقل ۸ حرف باشد';
                      }

                      return null;
                    },
                  ),
                  TxtField(
                    label: 'رمز عبور جدید',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock),
                    controller: req.model.newPassword,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'رمز عبور فعلی اجباری است';
                      }
                      if (value.isNotEmpty && value.length < 8) {
                        return 'رمز عبور می بایست حداقل ۸ حرف باشد';
                      }
                      if (req.model.oldPassword.text == value &&
                          value.length >= 8) {
                        return 'رمز فعلی و جدید نباید مشابه باشند';
                      }

                      return null;
                    },
                  ),

                  // View/Components/button.dart
                  Button(
                    text: 'تغییر',
                    textColor: Colors.white,
                    buttonColor: Colors.blue,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (req.model.formKey.currentState.validate()) {
                        modalBottomSheet(
                            context: context,
                            onConfirmed: () {
                              Navigator.pop(context);
                              ChangePasswordRequest().changePassword(
                                context: context,
                                username: Hive.box('user').get('username'),
                                oldPassword: req.model.oldPassword.text,
                                newPassword: req.model.newPassword.text,
                              );
                            });
                      }
                    },
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
