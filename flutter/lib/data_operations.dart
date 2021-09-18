import 'package:hive/hive.dart';


// ذخیره و تغییر در در لوکال دیتابیس
saveData({String username, email, token}) {
  Hive.box('data').put('isLogined', true);
  Hive.box('user').put('username', username);
  Hive.box('user').put('email', email);
  Hive.box('user').put('token', token);
}

// پاکسازی و تغییر در لوکال دیتابیس
clearData() {
  Hive.box('data').put('isLogined', false);
  Hive.box('user').clear();
}
