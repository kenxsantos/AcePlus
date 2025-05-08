import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends AuthEvent {}

class SearchUser extends AuthEvent {
  final String mobileNumber;
  final String password;

  SearchUser(this.mobileNumber, this.password);

  @override
  List<Object?> get props => [mobileNumber, password];
}

class LogoutAuth extends AuthEvent {}

class AddAuth extends AuthEvent {
  final String mobileNumber;
  final String password;

  AddAuth(this.mobileNumber, this.password);

  @override
  List<Object?> get props => [mobileNumber, password];
}

class DeleteAuth extends AuthEvent {
  final int id;

  DeleteAuth(this.id);

  @override
  List<Object?> get props => [id];
}

class CheckSession extends AuthEvent {}