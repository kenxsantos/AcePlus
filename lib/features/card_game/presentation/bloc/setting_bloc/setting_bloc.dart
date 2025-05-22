import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/setting_usecase/background_volume_usecase.dart';
import '../../../domain/usecases/setting_usecase/get_background_volume_usecase.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final BackgroundVolumeUsecase backgroundVolumeUsecase;
  final GetBackgroundVolumeUsecase getBackgroundVolumeUsecase;

  SettingBloc({
    required this.backgroundVolumeUsecase,
    required this.getBackgroundVolumeUsecase,
  }) : super(const SettingState(volume: 100)) {
    on<ChangeBackgroundVolumeEvent>(_onChangeVolume);
    on<LoadBackgroundVolumeEvent>(_onLoadVolume);
  }

  Future<void> _onChangeVolume(
      ChangeBackgroundVolumeEvent event, Emitter<SettingState> emit) async {
    await backgroundVolumeUsecase(event.volume);
    emit(state.copyWith(volume: event.volume));
  }

  Future<void> _onLoadVolume(
      LoadBackgroundVolumeEvent event, Emitter<SettingState> emit) async {
    final volume = await getBackgroundVolumeUsecase();
    emit(state.copyWith(volume: volume));
  }
}

