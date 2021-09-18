import 'package:hive/hive.dart';

class HomeModel {
  String username = Hive.box('user').get('username');
  String email = Hive.box('user').get('email');
}
