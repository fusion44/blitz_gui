import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
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
      // TODO: Find how to get where the currency symbol goes for a given lang
      final f = NumberFormat.currency(
        locale: event.languageCode,
        name: 'abc',
        decimalDigits: 0,
      );

      var isLeft = false;
      var o = f.format(123);
      if (o.startsWith('abc')) isLeft = true;

      yield state.copyWith(
        langCode: event.languageCode,
        currSymbolIsLeft: isLeft,
      );
    }
  }
}
