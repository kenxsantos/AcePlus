import 'package:hive_flutter/hive_flutter.dart';
import '../model/auth_model/auth_model.dart';


class AuthDataSource {
  final Box<Auth> _authBox = Hive.box<Auth>('auth');

  Future<void> addAuth(Auth auth) async {
    final int id = (_authBox.keys.isEmpty ? 0 : _authBox.keys.last as int) + 1;
    final newAuth = Auth(id: id, email: auth.email, password: auth.password);
    await _authBox.put(id, newAuth);
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

  bool emailExists(String email) {
    return _authBox.values.any((auth) => auth.email == email);
  }
}