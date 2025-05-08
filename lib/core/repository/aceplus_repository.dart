import '../data_source/data_source.dart';
import '../model/auth_model/auth_model.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  Future<int?> addAuth(Auth auth) => _dataSource.addAuth(auth);

  Auth? getAuth(int id) => _dataSource.getAuth(id);

  Future<void> deleteAuth(int id) => _dataSource.deleteAuth(id);

  List<Auth> getAllAuths() => _dataSource.getAllAuths();

  bool mobileNumberExists(String mobileNumber) => _dataSource.mobileNumberExists(mobileNumber);

  int? searchAuth(String mobileNumber, String password) {
    return _dataSource.searchAuth(mobileNumber, password);
  }
}