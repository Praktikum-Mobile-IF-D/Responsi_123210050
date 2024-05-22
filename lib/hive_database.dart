import 'package:responsid/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  static late Box<User> userBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    userBox = await Hive.openBox<User>('Users');
  }

  static Box<User> getUserBox() => userBox;
}