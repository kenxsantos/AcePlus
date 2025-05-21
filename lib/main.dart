import 'package:aceplus/dependency_injector.dart';
import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/sound_bloc/sound_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/timer_bloc/timer_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/sound_bloc/sound_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:aceplus/router/router.dart';
import 'package:aceplus/shared/utils/bloc_observer.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  final appRouter = AppRouter();

  final isLoggedIn = await AuthUtils.isLoggedIn();
  final userId = await AuthUtils.getUserId();
  print('Is Logged In: $isLoggedIn');
  print('User: $userId');

  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => inj<TimerBloc>()),
        BlocProvider(create: (_) => inj<CardBloc>()),
        BlocProvider(
          create:
              (_) =>
                  inj<AuthBloc>()
                    ..add(LoadUsers())
                    ..add(CheckSession()),
        ),
        BlocProvider(create: (_) => inj<TransactionBloc>()),
        BlocProvider(create: (_) => inj<BalanceBloc>()),
        BlocProvider<SoundBloc>(
          create: (_) => inj<SoundBloc>()..add(LoadSoundState()),
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
