import 'package:hive/hive.dart';

import '../../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int? userId;

  @HiveField(1)
  final String mobileNumber;

  @HiveField(2)
  final String password;

  @HiveField(3)
  double totalMoney;

  @HiveField(4)
  final DateTime createdAt;

  User({
    this.userId,
    required this.mobileNumber,
    required this.password,
    required this.totalMoney,
    required this.createdAt,
  });

  factory User.fromEntity(UserEntity entity) {
    return User(
      userId: entity.userId,
      mobileNumber: entity.mobileNumber,
      password: entity.password,
      totalMoney: entity.totalMoney,
      createdAt: entity.createdAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      mobileNumber: mobileNumber,
      password: password,
      totalMoney: totalMoney,
      createdAt: createdAt,
    );
  }

  @override
  String toString() {
    return 'User{User Id: $userId, Mobile Number: $mobileNumber, Password: $password, Total Money: $totalMoney, Created At: $createdAt}';
  }
}
