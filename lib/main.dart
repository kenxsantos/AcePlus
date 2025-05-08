import 'package:aceplus/core/model/transaction_model/transaction_model.dart';
import 'package:aceplus/router/router.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/data_source/data_source.dart';
import 'core/data_source/transaction_data_source.dart';
import 'core/data_source/user_data_source.dart';
import 'core/model/auth_model/auth_model.dart';
import 'core/model/user_model/user_model.dart';
import 'core/repository/aceplus_repository.dart';
import 'core/repository/transaction_repository.dart';
import 'core/repository/user_repository.dart';
import 'features/card_game/presentation/auth_dialog/auth_bloc/auth_bloc.dart';
import 'features/card_game/presentation/auth_dialog/auth_bloc/auth_event.dart';
import 'features/card_game/presentation/wallet_page/transaction_bloc/transaction_bloc.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AuthAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Auth>('auth');
  await Hive.openBox<User>('user');
  await Hive.openBox<Transaction>('transactions');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  final appRouter = AppRouter();
  final authDataSource = AuthDataSource();
  final authRepository = AuthRepository(authDataSource);
  final userDataSource = UserDataSource();
  final userRepository = UserRepository(userDataSource);
  final transactionDataSource = TransactionDataSource();
  final transactionRepository = TransactionRepository(transactionDataSource);

  // Temporary just to see all data in the auth box
  final authBloc = AuthBloc(authRepository, userRepository);
  authBloc.add(LoadAuths());
  authBloc.add(LoadUsers());

  //Temporary just to check if there is an existing session
  final isLoggedIn = await AuthUtils.isLoggedIn();
  final userId = await AuthUtils.getUserId();
  print('Is Logged In: $isLoggedIn');
  print('User: $userId');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository, userRepository)),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository, userRepository)..add(CheckSession()),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(
            repository: transactionRepository,
            userRepository: userRepository,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.router,
        theme: ThemeData(textTheme: GoogleFonts.lemonTextTheme()),
      ),
    ),
  );
}
