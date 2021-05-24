part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final bool darkTheme;
  final String langCode;
  final bool currSymbolIsLeft;
  SettingsState({
    this.darkTheme = false,
    this.langCode = 'en',
    this.currSymbolIsLeft = false,
  });

  SettingsState copyWith({
    bool darkTheme,
    String langCode,
    bool currSymbolIsLeft,
  }) {
    final newState = SettingsState(
      darkTheme: darkTheme ?? this.darkTheme,
      langCode: langCode ?? this.langCode,
      currSymbolIsLeft: currSymbolIsLeft ?? this.currSymbolIsLeft,
    );
    return newState;
  }
}
