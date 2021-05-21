import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(darkTheme: false));

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is ToggleThemeEvent) {
      yield state.copyWith(darkTheme: !state.darkTheme);
    } else if (event is ChangeLanguageEvent) {
      yield state.copyWith(langCode: event.languageCode);
    }
  }
}
