import 'package:aceplus/core/model/user_model/user_model.dart';
import 'package:aceplus/features/card_game/data/repositories/auth_repository.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(AuthLoading());
      try {
        final auths = _repository.getAllAuths();
        print('Loaded Users: $auths');
        emit(UserLoaded(auths));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AddAuth>((event, emit) async {
      try {
        final user = User(
          mobileNumber: event.mobileNumber,
          password: event.password,
          totalMoney: 0,
          createdAt: DateTime.now(),
        );

        final mobileNumberExists = _repository.mobileNumberExists(
          user.mobileNumber,
        );

        if (mobileNumberExists) {
          emit(AuthRegisterError('Mobile number already exists'));
        } else {
          await _repository.addAuth(user);

          emit(AuthRegisterSuccess('Account created successfully!'));
        }

        await Future.delayed(Duration(seconds: 3));
        emit(AuthInitial());
      } catch (e) {
        emit(AuthRegisterError('Signup failed: ${e.toString()}'));
      }
    });

    on<SearchUser>((event, emit) async {
      emit(AuthLoading());
      try {
        final id = _repository.searchAuth(event.mobileNumber, event.password);
        if (id != null) {
          final auth = _repository.getAuth(id);

          AuthUtils.setLoggedIn(true, id);

          emit(SearchUserResult(auth));
          emit(AuthSuccess());
        } else {
          emit(AuthLoginError('Invalid credentials, kindly recheck it!'));
          await Future.delayed(Duration(seconds: 3));
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthLoginError('Login failed: ${e.toString()}'));
      }
    });

    on<LogoutAuth>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('userId');
      emit(AuthInitial());
    });

    on<CheckSession>((event, emit) async {
      final isLoggedIn = await AuthUtils.isLoggedIn();
      if (isLoggedIn) {
        final userId = await AuthUtils.getUserId();
        if (userId != null) {
          final auth = _repository.getAuth(userId);
          emit(SearchUserResult(auth));
        } else {
          emit(AuthInitial());
        }
      } else {
        emit(AuthInitial());
      }
    });
  }
}
