abstract class SettingEvent {}

class ChangeBackgroundVolumeEvent extends SettingEvent {
  final double volume;
  ChangeBackgroundVolumeEvent(this.volume);
}

class LoadBackgroundVolumeEvent extends SettingEvent {}

