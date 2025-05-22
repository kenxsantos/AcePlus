import 'package:aceplus/features/card_game/domain/entities/user_entity.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/add_auth_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/get_all_auths_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/get_auth_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/mobile_number_exist_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/search_auth_usecase.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAllAuthsUsecase getAllAuthsUsecase;
  final GetAuthUsecase getAuthUsecase;
  final AddAuthUsecase addAuthUsecase;
  final MobileNumberExistUsecase mobileNumberExistUsecase;
  final SearchAuthUsecase searchAuthUsecase;

  AuthBloc({
    required this.getAllAuthsUsecase,
    required this.getAuthUsecase,
    required this.addAuthUsecase,
    required this.mobileNumberExistUsecase,
    required this.searchAuthUsecase,
  }) : super(AuthInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(AuthLoading());
      try {
        final auths = getAllAuthsUsecase;
        emit(UserLoaded(auths as List<UserEntity>));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AddAuth>((event, emit) async {
      try {
        final user = UserEntity(
          mobileNumber: event.mobileNumber,
          password: event.password,
          totalMoney: 0,
          createdAt: DateTime.now(),
        );

        final mobileNumberExists = mobileNumberExistUsecase.call(
          user.mobileNumber,
        );

        if (mobileNumberExists) {
          emit(AuthRegisterError('Mobile number already exists'));
        } else {
          await addAuthUsecase.call(user);

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
        final id = searchAuthUsecase.call(event.mobileNumber, event.password);
        if (id != null) {
          final auth = getAuthUsecase.call(id);

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
          final auth = getAuthUsecase.call(userId);
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
