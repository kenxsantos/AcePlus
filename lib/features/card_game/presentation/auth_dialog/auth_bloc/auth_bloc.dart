import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        final mobileNumberExists = _repository.mobileNumberExists(event.auth.mobileNumber);

        if (mobileNumberExists) {
          emit(AuthError('Mobile number already exists'));
          print("Mobile number already exists: ${event.auth.mobileNumber}");
        } else {
          await _repository.addAuth(event.auth);
          emit(AuthSuccess('Registration successful'));
          print("Registration successful: ${event.auth.mobileNumber}");
        }

        await Future.delayed(Duration(seconds: 5));
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SearchAuth>((event, emit) async {
      emit(AuthLoading());
      try {
        final id = _repository.searchAuth(event.mobileNumber, event.password);
        if (id != null) {
          final auth = _repository.getAuth(id);
          print('Search Result: $auth');

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setInt('userId', id);

          emit(SearchResult(auth));
        } else {
          emit(AuthError('Either the mobile number or password is incorrect'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
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
  }
}