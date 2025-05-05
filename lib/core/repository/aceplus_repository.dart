import '../data_source/data_source.dart';
import '../model/auth_model/auth_model.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  Future<void> addAuth(Auth auth) => _dataSource.addAuth(auth);

  Auth? getAuth(int id) => _dataSource.getAuth(id);

  Future<void> deleteAuth(int id) => _dataSource.deleteAuth(id);

  List<Auth> getAllAuths() => _dataSource.getAllAuths();
}