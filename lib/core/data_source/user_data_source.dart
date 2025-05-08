import 'package:hive/hive.dart';
import '../model/user_model/user_model.dart';

class UserDataSource {
  final Box<User> _userBox = Hive.box<User>('user');

  Future<void> addUser(User user) async {
    await _userBox.put(user.userId, user);
  }

  User? getUser(int userId) {
    return _userBox.get(userId);
  }

  List<User> getAllUsers() {
    return _userBox.values.toList();
  }

  Future<void> updateUser(User user) async {
    await _userBox.put(user.userId, user);
  }
}