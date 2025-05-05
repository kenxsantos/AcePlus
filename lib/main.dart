import 'package:aceplus/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/data_source/data_source.dart';
import 'core/model/auth_model/auth_model.dart';
import 'core/repository/aceplus_repository.dart';
import 'features/card_game/presentation/auth_dialog/auth_bloc/auth_bloc.dart';
import 'features/card_game/presentation/auth_dialog/auth_bloc/auth_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthAdapter());
  await Hive.openBox<Auth>('auth');

  final appRouter = AppRouter();
  final authDataSource = AuthDataSource();
  final authRepository = AuthRepository(authDataSource);

  // Temporary just to see all data in the auth box
  final authBloc = AuthBloc(authRepository);
  authBloc.add(LoadAuths());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.router,
        theme: ThemeData(textTheme: GoogleFonts.lemonTextTheme()),
      ),
    )
  );
}
