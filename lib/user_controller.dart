import 'package:responsid/models/user_model.dart';
import 'package:hive/hive.dart';

class UserController {
  final Box<User> _userBox;

  UserController(this._userBox);

  Future<void>addUser(User user) async {
    await _userBox.add(user);
  }

  User? getUserByUsername(String username) {
    try{
      return _userBox.values.firstWhere((user) => user.username == username);
    }catch(e) {
      return null;
    }
  }

}