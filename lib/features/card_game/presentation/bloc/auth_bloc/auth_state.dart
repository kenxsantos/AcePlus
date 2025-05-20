import 'package:equatable/equatable.dart';
import '../../../data/model/user_model/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class UserLoaded extends AuthState {
  final List<User> users;

  UserLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class SearchUserResult extends AuthState {
  final User? user;

  SearchUserResult(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthSuccess extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  final String message;

  AuthRegisterSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoginError extends AuthState {
  final String message;

  AuthLoginError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthRegisterError extends AuthState {
  final String message;

  AuthRegisterError(this.message);

  @override
  List<Object?> get props => [message];
}
