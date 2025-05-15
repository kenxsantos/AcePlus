import 'package:aceplus/core/model/user_model/user_model.dart';
import 'package:aceplus/features/card_game/data/datasource/auth_data_source.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  Future<int?> addAuth(User user) => _dataSource.addAuth(user);

  User? getAuth(int id) => _dataSource.getAuth(id);

  Future<void> deleteAuth(int id) => _dataSource.deleteAuth(id);

  List<User> getAllAuths() => _dataSource.getAllAuths();

  bool mobileNumberExists(String mobileNumber) =>
      _dataSource.mobileNumberExists(mobileNumber);

  int? searchAuth(String mobileNumber, String password) {
    return _dataSource.searchAuth(mobileNumber, password);
  }

  double? getTotalMoney(int userId) => _dataSource.getTotalMoney(userId);

  Future<void> updateTotalMoney(int userId, double amount) async {
    await _dataSource.updateTotalMoney(userId, amount);
  }
}
