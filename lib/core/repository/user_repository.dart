import '../data_source/user_data_source.dart';
import '../model/user_model/user_model.dart';

class UserRepository {
  final UserDataSource _dataSource;

  UserRepository(this._dataSource);

  Future<void> addUser(User user) async {
    await _dataSource.addUser(user);
  }

  User? getUser(int userId) {
    return _dataSource.getUser(userId);
  }

  List<User> getAllUsers() {
    return _dataSource.getAllUsers();
  }

  Future<void> updateUser(User user) async {
    await _dataSource.updateUser(user);
  }
}