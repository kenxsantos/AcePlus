import 'package:equatable/equatable.dart';
import '../../../../../core/model/auth_model/auth_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAuths extends AuthEvent {}

class AddAuth extends AuthEvent {
  final Auth auth;

  AddAuth(this.auth);

  @override
  List<Object?> get props => [auth];
}

class DeleteAuth extends AuthEvent {
  final int id;

  DeleteAuth(this.id);

  @override
  List<Object?> get props => [id];
}