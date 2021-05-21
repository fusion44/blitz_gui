part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final isDarkTheme;

  SettingsState({this.isDarkTheme = false});

  SettingsState copyWith({bool darkTheme}) =>
      SettingsState(isDarkTheme: isDarkTheme ?? darkTheme);
}
