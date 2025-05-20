import 'package:aceplus/features/card_game/data/datasource/auth_data_source.dart';
import 'package:aceplus/features/card_game/domain/entities/user_entity.dart';
import 'package:aceplus/features/card_game/domain/repositories/auth_repository.dart';
import '../model/user_model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<int?> addAuth(UserEntity userEntity) async {
    final userModel = User.fromEntity(userEntity);
    return await _dataSource.addAuth(userModel);
  }

  @override
  UserEntity? getAuth(int id) {
    final userModel = _dataSource.getAuth(id);
    return userModel?.toEntity();
  }

  @override
  Future<void> deleteAuth(int id) => _dataSource.deleteAuth(id);

  @override
  List<UserEntity> getAllAuths() {
    return _dataSource.getAllAuths().map((user) => user.toEntity()).toList();
  }

  @override
  bool mobileNumberExists(String mobileNumber) {
    return _dataSource.mobileNumberExists(mobileNumber);
  }

  @override
  int? searchAuth(String mobileNumber, String password) {
    return _dataSource.searchAuth(mobileNumber, password);
  }

  @override
  double? getTotalMoney(int userId) {
    return _dataSource.getTotalMoney(userId);
  }

  @override
  Future<void> updateTotalMoney(int userId, double amount) async {
    await _dataSource.updateTotalMoney(userId, amount);
  }
}