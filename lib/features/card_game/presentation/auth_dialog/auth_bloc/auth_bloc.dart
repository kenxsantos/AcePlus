import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/repository/aceplus_repository.dart';
import '../../../../../shared/utils/logged_in_checker.dart';
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
        final mobileNumberExists = _repository.mobileNumberExists(
          event.auth.mobileNumber,
        );

        if (mobileNumberExists) {
          emit(AuthRegisterError('Mobile number already exists'));
          print("Mobile number already exists: ${event.auth.mobileNumber}");
        } else {
          await _repository.addAuth(event.auth);
          emit(AuthSuccess('Account created successfully!'));
          print("Registration successful: ${event.auth.mobileNumber}");
        }

        await Future.delayed(Duration(seconds: 3));
        emit(AuthInitial());
      } catch (e) {
        emit(AuthRegisterError(e.toString()));
      }
    });

    on<SearchAuth>((event, emit) async {
      emit(AuthLoading());
      try {
        final id = _repository.searchAuth(event.mobileNumber, event.password);
        if (id != null) {
          final auth = _repository.getAuth(id);
          print('Search Result: $auth');

          AuthUtils.setLoggedIn(true, id);

          emit(SearchResult(auth));
          emit(AuthSuccess('Login successful'));
        } else {
          emit(AuthLoginError('Invalid credentials, kindly recheck it!'));
          await Future.delayed(Duration(seconds: 3));
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthLoginError(e.toString()));
      }
    });

    on<LogoutAuth>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('userId');
      emit(AuthInitial());
    });

    on<DeleteAuth>((event, emit) async {
      try {
        await _repository.deleteAuth(event.id);
        add(LoadAuths());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<CheckSession>((event, emit) async {
      final isLoggedIn = await AuthUtils.isLoggedIn();
      if (isLoggedIn) {
        final userId = await AuthUtils.getUserId();
        if (userId != null) {
          final auth = _repository.getAuth(userId);
          emit(SearchResult(auth));
        } else {
          emit(AuthInitial());
        }
      } else {
        emit(AuthInitial());
      }
    });
  }
}
