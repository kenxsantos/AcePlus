import 'package:aceplus/core/model/transaction_model/transaction_model.dart';
import 'package:aceplus/core/model/user_model/user_model.dart';
import 'package:aceplus/core/datasource/auth_data_source.dart';
import 'package:aceplus/core/datasource/sound_data_source.dart';
import 'package:aceplus/core/datasource/timer_data_source.dart';
import 'package:aceplus/core/datasource/transaction_data_source.dart';
import 'package:aceplus/core/repositories/auth_repository.dart';
import 'package:aceplus/core/repositories/sound_repository.dart';
import 'package:aceplus/core/repositories/transaction_repository.dart';
import 'package:aceplus/features/card_game/presentation/auth_dialog/auth_bloc/auth_bloc.dart';
import 'package:aceplus/features/card_game/presentation/auth_dialog/auth_bloc/auth_event.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';
import 'package:aceplus/features/card_game/presentation/home_page/sound_bloc/sound_bloc.dart';
import 'package:aceplus/features/card_game/presentation/home_page/sound_bloc/sound_event.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/balance_bloc/balance_bloc.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_bloc.dart';
import 'package:aceplus/router/router.dart';
import 'package:aceplus/shared/utils/bloc_observer.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<User>('user');
  await Hive.openBox<Transaction>('transaction');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  final appRouter = AppRouter();
  final authDataSource = AuthDataSource();
  final authRepository = AuthRepository(authDataSource);
  final transactionDataSource = TransactionDataSource();
  final transactionRepository = TransactionRepository(transactionDataSource);

  // Temporary just to see all data in the auth box
  final authBloc = AuthBloc(authRepository);
  authBloc.add(LoadUsers());

  //Temporary just to check if there is an existing session
  final isLoggedIn = await AuthUtils.isLoggedIn();
  final userId = await AuthUtils.getUserId();
  print('Is Logged In: $isLoggedIn');
  print('User: $userId');
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TimerBloc(ticker: TimerDataSource())),
        BlocProvider(create: (_) => CardBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository)..add(CheckSession()),
        ),
        BlocProvider<TransactionBloc>(
          create:
              (context) => TransactionBloc(
                repository: transactionRepository,
                userRepository: authRepository,
              ),
        ),
        BlocProvider<BalanceBloc>(
          create: (context) => BalanceBloc(userRepository: authRepository),
        ),
        BlocProvider<SoundBloc>(
          create:
              (context) => SoundBloc(
                soundRepository: SoundRepository(
                  soundDataSource: SoundDataSource(),
                ),
              )..add(LoadSoundState()),
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
