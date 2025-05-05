import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
class Auth extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  Auth({this.id, required this.email, required this.password});

  @override
  String toString() {
    return 'Auth{id: $id, email: $email, password: $password}';
  }
}