part of 'settings_bloc.dart';

abstract class SettingsBaseState {
  final bool darkTheme;
  final String langCode;
  final bool currSymbolIsLeft;
  SettingsBaseState({
    this.darkTheme = false,
    this.langCode = 'en',
    this.currSymbolIsLeft = false,
  });

  SettingsBaseState copyWith({
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

@immutable
class SettingsState extends SettingsBaseState {
  SettingsState({
    darkTheme = false,
    langCode = 'en',
    currSymbolIsLeft = false,
  }) : super(
          darkTheme: darkTheme,
          langCode: langCode,
          currSymbolIsLeft: currSymbolIsLeft,
        );
}

@immutable
class SettingsLoadedState extends SettingsBaseState {
  SettingsLoadedState({
    darkTheme = false,
    langCode = 'en',
    currSymbolIsLeft = false,
  }) : super(
          darkTheme: darkTheme,
          langCode: langCode,
          currSymbolIsLeft: currSymbolIsLeft,
        );
}
