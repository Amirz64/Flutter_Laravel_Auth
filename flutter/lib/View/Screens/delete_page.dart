import 'package:flutter/material.dart';
import 'package:flutter3/Service/delete.dart';
import 'package:flutter3/View/Components/button.dart';
import 'package:flutter3/View/Components/text_field.dart';
import 'package:flutter3/View/Components/modal_bottm_sheet.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class DeleteAccountView extends StatefulWidget {
  DeleteAccountView({Key key}) : super(key: key);

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  // Models/delete_model.dart
  DeleteAccountRequest _delmodel = DeleteAccountRequest();

  @override
  void dispose() {
    super.dispose();
    _delmodel.model.password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Service/delete.dart
      create: (context) => DeleteAccountRequest(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color(0xFFfafafa),
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              'حذف حساب',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: Consumer<DeleteAccountRequest>(
            builder: (context, req, child) => Center(
                child: Form(
              key: req.model.formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // View/Components/text_field.dart
                  TxtField(
                    label: 'رمز عبور ',
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock),
                    controller: req.model.password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'رمز عبور نباید خالی باشد';
                      }
                      if (value.isNotEmpty && value.length < 8) {
                        return 'رمز عبور باید حداقل شامل ۸ حرف باشد';
                      }
                      return null;
                    },
                  ),
                  // View/Components/button.dart
                  Button(
                    text: 'حذف',
                    textColor: Colors.white,
                    buttonColor: Color(0xFFB81616),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (req.model.formkey.currentState.validate()) {
                        // View/Components/modal_bottom_sheet.dart
                        modalBottomSheet(
                            context: context,
                            onConfirmed: () {
                              Navigator.of(context).pop();
                              req.deleteAccount(
                                context: context,
                                username: Hive.box('user').get('username'),
                                password: req.model.password.text,
                              );
                            });
                      }
                    },
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
