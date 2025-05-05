import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/repository/aceplus_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<LoadAuths>((event, emit) async {
      emit(AuthLoading());
      try {
        final auths = _repository.getAllAuths();
        print('Loaded Auths: $auths');
        emit(AuthLoaded(auths));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AddAuth>((event, emit) async {
      try {
        final emailExists = _repository.emailExists(event.auth.email);

        if (emailExists) {
          emit(AuthError('Email already exists'));
          print("Email already exists: ${event.auth.email}");
        } else {
          await _repository.addAuth(event.auth);
          emit(AuthSuccess('Registration successful'));
          print("Registration successful: ${event.auth.email}");
        }

        await Future.delayed(Duration(seconds: 5));
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<DeleteAuth>((event, emit) async {
      try {
        await _repository.deleteAuth(event.id);
        add(LoadAuths());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}