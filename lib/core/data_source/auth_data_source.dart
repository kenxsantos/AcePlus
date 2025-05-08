import 'package:hive_flutter/hive_flutter.dart';
import '../model/user_model/user_model.dart';

class AuthDataSource {
  final Box<User> _userBox = Hive.box<User>('user');

  Future<int?> addAuth(User user) async {
    final int id = (_userBox.keys.isEmpty ? 0 : _userBox.keys.last as int) + 1;
    final newAuth = User(
      userId: id,
      mobileNumber: user.mobileNumber,
      password: user.password,
      totalMoney: user.totalMoney,
      createdAt: user.createdAt,
    );
    await _userBox.put(id, newAuth);
    return id;
  }

  int? searchAuth(String mobileNumber, String password) {
    try {
      return _userBox.values
          .firstWhere(
            (auth) =>
        auth.mobileNumber == mobileNumber && auth.password == password,
      )
          .userId;
    } catch (e) {
      return null;
    }
  }

  User? getAuth(int id) {
    return _userBox.get(id);
  }

  Future<void> deleteAuth(int id) async {
    await _userBox.delete(id);
  }

  List<User> getAllAuths() {
    return _userBox.values.toList();
  }

  bool mobileNumberExists(String mobileNumber) {
    return _userBox.values.any((auth) => auth.mobileNumber == mobileNumber);
  }

  double? getTotalMoney(int userId) {
    final user = _userBox.get(userId);
    return user?.totalMoney;
  }
}
