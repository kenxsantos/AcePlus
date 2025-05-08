import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final int authId;

  @HiveField(2)
  final String totalMoney;

  User({required this.userId, required this.authId, required this.totalMoney});

  @override
  String toString() {
    return 'Transaction{User Id: $userId, Auth Id: $authId, Total Money: $totalMoney}';
  }
}
