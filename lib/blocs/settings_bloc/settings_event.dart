part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ToggleThemeEvent extends SettingsEvent {}

class ChangeLanguageEvent extends SettingsEvent {
  final String languageCode;

  ChangeLanguageEvent(this.languageCode);
}
