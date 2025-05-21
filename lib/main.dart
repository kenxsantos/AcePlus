import 'package:aceplus/features/card_game/data/datasource/auth_data_source.dart';
import 'package:aceplus/features/card_game/data/datasource/sound_data_source.dart';
import 'package:aceplus/features/card_game/data/datasource/timer_data_source.dart';
import 'package:aceplus/features/card_game/data/datasource/transaction_data_source.dart';
import 'package:aceplus/features/card_game/data/repositories/setting_repository.dart';
import 'package:aceplus/features/card_game/data/repositories/sound_repository.dart';
import 'package:aceplus/features/card_game/data/repositories/transaction_repository.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/get_total_money_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/update_total_money_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/setting_usecase/get_background_volume_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/get_sound_state_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/pause_background_audio_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/resume_background_audio_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/save_sound_state_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/sound_usecase/setup_background_audio_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/transaction_usecase/add_transaction_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/transaction_usecase/get_transaction_by_type_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/transaction_usecase/get_transaction_usecase.dart';
import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/timer_bloc/timer_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/sound_bloc/sound_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/sound_bloc/sound_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:aceplus/router/router.dart';
import 'package:aceplus/shared/utils/bloc_observer.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/card_game/data/model/transaction_model/transaction_model.dart';
import 'features/card_game/data/model/user_model/user_model.dart';
import 'features/card_game/data/repositories/auth_repository.dart';
import 'features/card_game/domain/usecases/auth_usecase/add_auth_usecase.dart';
import 'features/card_game/domain/usecases/auth_usecase/get_all_auths_usecase.dart';
import 'features/card_game/domain/usecases/auth_usecase/get_auth_usecase.dart';
import 'features/card_game/domain/usecases/auth_usecase/mobile_number_exist_usecase.dart';
import 'features/card_game/domain/usecases/auth_usecase/search_auth_usecase.dart';
import 'features/card_game/domain/usecases/setting_usecase/background_volume_usecase.dart';
import 'features/card_game/presentation/bloc/setting_bloc/setting_bloc.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<User>('user');
  await Hive.openBox<Transaction>('transaction');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Update Main dart too much codes use DI.

  await initHive();

  final appRouter = AppRouter();

  final authDataSource = AuthDataSource();
  final transactionDataSource = TransactionDataSource();
  final soundDataSource = SoundDataSource();

  final authRepository = AuthRepositoryImpl(authDataSource);
  final addAuthUsecase = AddAuthUsecase(authRepository);
  final getAllAuthsUsecase = GetAllAuthsUsecase(authRepository);
  final searchAuthUsecase = SearchAuthUsecase(authRepository);
  final getAuthUsecase = GetAuthUsecase(authRepository);
  final mobileNumberExistUsecase = MobileNumberExistUsecase(authRepository);
  final getTotalMoneyUsecase = GetTotalMoneyUsecase(authRepository);
  final updateTotalMoneyUsecase = UpdateTotalMoneyUsecase(authRepository);

  final transactionRepository = TransactionRepositoryImpl(
    transactionDataSource,
  );
  final addTransactionUsecase = AddTransactionUsecase(transactionRepository);
  final getTransactionUsecase = GetTransactionUsecase(transactionRepository);
  final getTransactionByTypeUsecase = GetTransactionByTypeUsecase(
    transactionRepository,
  );

  final soundRepository = SoundRepositoryImpl(soundDataSource: soundDataSource);
  final getSoundStateUsecase = GetSoundStateUsecase(soundRepository);
  final saveSoundStateUsecase = SaveSoundStateUsecase(soundRepository);
  final setupBackgroundAudioUsecase = SetupBackgroundAudioUsecase(
    soundRepository,
  );
  final resumeBackgroundAudioUsecase = ResumeBackgroundAudioUsecase(
    soundRepository,
  );
  final pauseBackgroundAudioUsecase = PauseBackgroundAudioUsecase(
    soundRepository,
  );

  final settingRepository = SettingRepositoryImpl(
    soundDataSource: soundDataSource,
  );
  final backgroundVolumeUsecase = BackgroundVolumeUsecase(settingRepository);
  final getBackgroundVolumeUsecase = GetBackgroundVolumeUsecase(
    settingRepository,
  );

  final isLoggedIn = await AuthUtils.isLoggedIn();
  final userId = await AuthUtils.getUserId();
  print('Is Logged In: $isLoggedIn');
  print('User: $userId');

  // Bloc observer for all blocs
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TimerBloc(ticker: TimerDataSource())),
        BlocProvider(create: (_) => CardBloc()),
        // Provide only one instance of AuthBloc
        BlocProvider(
          create:
              (context) => AuthBloc(
                addAuthUsecase: addAuthUsecase,
                getAllAuthsUsecase: getAllAuthsUsecase,
                searchAuthUsecase: searchAuthUsecase,
                getAuthUsecase: getAuthUsecase,
                mobileNumberExistUsecase: mobileNumberExistUsecase,
              )..add(CheckSession()),
        ),
        BlocProvider<TransactionBloc>(
          create:
              (context) => TransactionBloc(
                addTransactionUsecase: addTransactionUsecase,
                getTransactionUsecase: getTransactionUsecase,
                getTransactionByTypeUsecase: getTransactionByTypeUsecase,
                getTotalMoneyUsecase: getTotalMoneyUsecase,
                updateTotalMoneyUsecase: updateTotalMoneyUsecase,
              ),
        ),
        BlocProvider<BalanceBloc>(
          create:
              (context) =>
                  BalanceBloc(getTotalMoneyUsecase: getTotalMoneyUsecase),
        ),
        BlocProvider<SoundBloc>(
          create:
              (context) => SoundBloc(
                getSoundStateUsecase: getSoundStateUsecase,
                saveSoundStateUsecase: saveSoundStateUsecase,
                setupBackgroundAudioUsecase: setupBackgroundAudioUsecase,
                resumeBackgroundAudioUsecase: resumeBackgroundAudioUsecase,
                pauseBackgroundAudioUsecase: pauseBackgroundAudioUsecase,
              )..add(LoadSoundState()),
        ),
        BlocProvider<SettingBloc>(
          create:
              (_) => SettingBloc(
                backgroundVolumeUsecase: backgroundVolumeUsecase,
                getBackgroundVolumeUsecase: getBackgroundVolumeUsecase,
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
