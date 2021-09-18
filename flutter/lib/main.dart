import 'package:flutter/material.dart';
import 'package:flutter3/View/Screens/changepass_page.dart';
import 'package:flutter3/View/Screens/delete_page.dart';
import 'package:flutter3/View/Screens/home_page.dart';
import 'package:flutter3/View/Screens/login_page.dart';
import 'View/Screens/register_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  await Hive.openBox('data');

  runApp(
    MyApp(),
  );
}

bool isLogined = Hive.box('data').get('isLogined', defaultValue: false);

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //تعیین فونت برنامه
        fontFamily: 'Vazir',
      ),
      debugShowCheckedModeBanner: false,

      // در حالت عادی : صفحه ثبت نام
      home: isLogined ? HomeView() : RegisterView(),

      //تعریف صفحات
      routes: {
        '/login': (BuildContext context) => LoginView(),
        '/signup': (BuildContext context) => RegisterView(),
        '/home': (BuildContext context) => HomeView(),
        '/changePassword': (BuildContext context) => ChangePasswordView(),
        '/deleteAccount': (BuildContext context) => DeleteAccountView(),
      },
    );
  }
}
