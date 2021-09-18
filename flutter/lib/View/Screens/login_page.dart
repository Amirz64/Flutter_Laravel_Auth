import 'package:flutter/material.dart';
import 'package:flutter3/Models/login_model.dart';
import 'package:flutter3/Service/login.dart';
import 'package:flutter3/View/Components/button.dart';
import 'package:flutter3/View/Components/text_field.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Models/login_model.dart
  LoginModel _model = LoginModel();

  void dispose() {
    super.dispose();

    _model.username.dispose();
    _model.password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Service/login.dart
      create: (context) => LoginRequest(),
      child: Form(
        key: _model.formkey,
        child: SafeArea(
            child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: Color(0xFFF8F9FA),
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text(
                  'صفحه ورود',
                  style: TextStyle(fontSize: 24),
                ),
                centerTitle: true,
              ),
              body: Consumer<LoginRequest>(builder: (context, req, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          // View/Components/text_field.dart
                          TxtField(
                            controller: _model.username,
                            label: 'نام کاربری',
                            prefixIcon: Icon(Icons.account_circle_sharp),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'نام کاربری اجباری است';
                              }

                              return null;
                            },
                          ),

                          TxtField(
                            controller: _model.password,
                            label: 'رمز عبور',
                            prefixIcon: Icon(Icons.lock),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'رمز عبور اجباری است';
                              }
                              if (value.isNotEmpty && value.length < 8) {
                                return 'رمز عبور می بایست حداقل ۸ حرف باشد';
                              }
                              if (value.length > 30) {
                                return 'password cant be more than 30 chracter';
                              }

                              return null;
                            },
                            isPassword: true,
                          ),

                          // Button
                          // View/Components/button.dart
                          Button(
                            text: 'ورود',
                            textColor: Colors.white,
                            buttonColor: Colors.teal,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_model.formkey.currentState.validate()) {
                                req.login(
                                  context: context,
                                  username: _model.username.text,
                                  password: _model.password.text,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
        )),
      ),
    );
  }
}
