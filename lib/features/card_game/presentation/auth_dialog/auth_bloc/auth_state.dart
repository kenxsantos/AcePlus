import 'package:equatable/equatable.dart';
import '../../../../../core/model/auth_model/auth_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final List<Auth> auths;

  AuthLoaded(this.auths);

  @override
  List<Object?> get props => [auths];
}

class SearchResult extends AuthState {
  final Auth? auth;

  SearchResult(this.auth);

  @override
  List<Object?> get props => [auth];
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
