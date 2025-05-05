import 'package:aceplus/features/card_game/data/datasource/timer_data_source.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';
import 'package:aceplus/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appRouter = AppRouter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TimerBloc(ticker: TimerDataSource())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.router,
        theme: ThemeData(textTheme: GoogleFonts.lemonTextTheme()),
      ),
    ),
  );
}
