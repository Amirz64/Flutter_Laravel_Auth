import 'package:flutter/material.dart';
import 'package:flutter3/Models/register_model.dart';
import 'package:flutter3/Service/register.dart';
import 'package:provider/provider.dart';
import '../Components/text_field.dart';
import '../Components/button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Models/register_model.dart
  RegisterModel _model = RegisterModel();

  void dispose() {
    super.dispose();

    _model.username.dispose();
    _model.password.dispose();
    _model.email.dispose();
    _model.confirmPassword.dispose();
  }

  void initState() {
    super.initState();

    _model.username = TextEditingController();
    _model.email = TextEditingController();
    _model.password = TextEditingController();
    _model.confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    // تعریف پرووایدر برای صفحه ثبت نام
    return ChangeNotifierProvider(

      // Service/register.dart
      create: (context) => RegisterRequest(),

      child: Form(
        // برای اعتبار سنجی فرم ها
        key: _model.formkey,
        child: SafeArea(
            child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: Color(0xFFF8F9FA),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.teal,
                title: Text(
                  'ثبت نام',
                  style: TextStyle(fontSize: 24),
                ),
                centerTitle: true,
              ),
              body: Consumer<RegisterRequest>(builder: (context, req, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // ٰView/Components/text_field.dart
                          TxtField(
                            label: 'نام کاربری',
                            controller: _model.username,
                            prefixIcon: Icon(Icons.account_circle_sharp),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'نام کاربری اجباری است';
                              }

                              return null;
                            },
                            errorText: req.model.userTaken == true
                                ? 'نام کاربری موجود است'
                                : null,
                          ),
                          TxtField(
                            label: 'ایمیل',
                            controller: _model.email,
                            prefixIcon: Icon(Icons.email),
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'ایمیل اجباری است';
                              }

                              if (!value.contains('.') ||
                                  !value.contains('@')) {
                                return 'لطفا ایمیل معتبر وارد کنید';
                              }

                              return null;
                            },
                            errorText: req.model.emailTaken == true
                                ? 'ایمیل موجود است'
                                : null,
                          ),
                          TxtField(
                            label: 'رمز عبور',
                            controller: _model.password,
                            prefixIcon: Icon(Icons.lock),
                            isPassword: true,
                            validator: (value) {
                              setState(() {
                                _model.pass = value;
                              });

                              if (value.isEmpty || value == null) {
                                return 'رمز عبور اجباری است';
                              }
                              if (value.isNotEmpty && value.length < 8) {
                                return 'رمز عبور می بایست حداقل ۸ حرف باشد';
                              }

                              return null;
                            },
                          ),
                          TxtField(
                            label: 'تکرار رمز عبور',
                            controller: _model.confirmPassword,
                            prefixIcon: Icon(Icons.password),
                            isPassword: true,
                            validator: (value) {
                              if (value.isEmpty || value == null) {
                                return 'تایید رمز عبور اجباری است';
                              }
                              if (value.isNotEmpty && value.length < 8) {
                                return 'رمز عبور می بایست حداقل ۸ حرف باشد';
                              }

                              if (_model.pass != value) {
                                return 'تایید رمز عبور مطابقت ندارد';
                              }

                              return null;
                            },
                          ),

                          // View/Components/button.dart
                          Button(
                            text: 'ثبت نام',
                            textColor: Colors.white,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_model.formkey.currentState.validate() ||
                                  req.model.userTaken == true) {
                                req.register(
                                  context: context,
                                  username: _model.username.text,
                                  email: _model.email.text,
                                  password: _model.password.text,
                                  confirmpassword: _model.confirmPassword.text,
                                );
                              }
                            },
                            buttonColor: Colors.teal,
                          ),
                          GestureDetector(
                            onTap: () {
                              _model.username.clear();
                              _model.password.clear();
                              _model.confirmPassword.clear();
                              _model.email.clear();

                              Navigator.of(context).pushNamed('/login');
                            },
                            child: Text(
                              ' حساب کاربری دارید؟ وارد شوید',
                              style: TextStyle(
                                  color: Color(0xff0c92eb),
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
