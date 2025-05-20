import 'package:aceplus/features/card_game/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<int?> addAuth(UserEntity userEntity);

  UserEntity? getAuth(int id);

  Future<void> deleteAuth(int id);

  List<UserEntity> getAllAuths();

  bool mobileNumberExists(String mobileNumber);

  int? searchAuth(String mobileNumber, String password);

  double? getTotalMoney(int userId);

  Future<void> updateTotalMoney(int userId, double amount);
}
