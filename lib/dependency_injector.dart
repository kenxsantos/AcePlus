import 'package:aceplus/features/card_game/data/datasource/auth_data_source.dart';
import 'package:aceplus/features/card_game/data/datasource/sound_data_source.dart';
import 'package:aceplus/features/card_game/data/datasource/timer_data_source.dart';
import 'package:aceplus/features/card_game/data/datasource/transaction_data_source.dart';
import 'package:aceplus/features/card_game/data/model/transaction_model/transaction_model.dart';
import 'package:aceplus/features/card_game/data/model/user_model/user_model.dart';
import 'package:aceplus/features/card_game/data/repositories/auth_repository.dart';
import 'package:aceplus/features/card_game/data/repositories/sound_repository.dart';
import 'package:aceplus/features/card_game/data/repositories/transaction_repository.dart';
import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/sound_bloc/sound_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/timer_bloc/timer_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final inj = GetIt.instance;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register Hive Adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionAdapter());

  if (!Hive.isBoxOpen('user')) {
    await Hive.openBox<User>('user');
  }
  if (!Hive.isBoxOpen('transaction')) {
    await Hive.openBox<Transaction>('transaction');
  }

  // Register Data Sources
  inj.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  inj.registerLazySingleton<TransactionDataSource>(
    () => TransactionDataSource(),
  );
  inj.registerLazySingleton<SoundDataSource>(() => SoundDataSource());
  inj.registerLazySingleton<TimerDataSource>(() => TimerDataSource());

  // Register Repositories
  inj.registerLazySingleton<AuthRepository>(
    () => AuthRepository(inj<AuthDataSource>()),
  );
  inj.registerLazySingleton<TransactionRepository>(
    () => TransactionRepository(inj<TransactionDataSource>()),
  );
  inj.registerLazySingleton<SoundRepository>(
    () => SoundRepository(soundDataSource: inj<SoundDataSource>()),
  );

  // Register Blocs
  inj.registerFactory<AuthBloc>(() => AuthBloc(inj<AuthRepository>()));
  inj.registerFactory<CardBloc>(() => CardBloc());
  inj.registerFactory<TimerBloc>(
    () => TimerBloc(ticker: inj<TimerDataSource>()),
  );
  inj.registerFactory<SoundBloc>(
    () => SoundBloc(soundRepository: inj<SoundRepository>()),
  );
  inj.registerFactory<TransactionBloc>(
    () => TransactionBloc(
      repository: inj<TransactionRepository>(),
      userRepository: inj<AuthRepository>(),
    ),
  );
  inj.registerFactory<BalanceBloc>(
    () => BalanceBloc(userRepository: inj<AuthRepository>()),
  );
}
