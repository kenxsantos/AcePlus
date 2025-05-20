class UserEntity {
  final int? userId;
  final String mobileNumber;
  final String password;
  final double totalMoney;
  final DateTime createdAt;

  UserEntity({
    this.userId,
    required this.mobileNumber,
    required this.password,
    required this.totalMoney,
    required this.createdAt,
  });
}
