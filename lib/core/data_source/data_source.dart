import 'package:hive_flutter/hive_flutter.dart';
import '../model/auth_model/auth_model.dart';


class AuthDataSource {
  final Box<Auth> _authBox = Hive.box<Auth>('auth');

  Future<int?> addAuth(Auth auth) async {
    final int id = (_authBox.keys.isEmpty ? 0 : _authBox.keys.last as int) + 1;
    final newAuth = Auth(id: id, mobileNumber: auth.mobileNumber, password: auth.password);
    await _authBox.put(id, newAuth);
    return id;
  }

  Auth? getAuth(int id) {
    return _authBox.get(id);
  }

  Future<void> deleteAuth(int id) async {
    await _authBox.delete(id);
  }

  List<Auth> getAllAuths() {
    return _authBox.values.toList();
  }

  bool mobileNumberExists(String mobileNumber) {
    return _authBox.values.any((auth) => auth.mobileNumber == mobileNumber);
  }

  int? searchAuth(String mobileNumber, String password) {
    try {
      return _authBox.values.firstWhere(
            (auth) => auth.mobileNumber == mobileNumber && auth.password == password,
      ).id;
    } catch (e) {
      return null;
    }
  }
}