part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final bool darkTheme;
  final String langCode;

  SettingsState({this.darkTheme = false, this.langCode = 'en'});

  SettingsState copyWith({bool darkTheme, String langCode}) {
    final newState = SettingsState(
      darkTheme: darkTheme ?? this.darkTheme,
      langCode: langCode ?? this.langCode,
    );
    return newState;
  }
}
