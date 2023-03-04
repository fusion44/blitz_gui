import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:settings_fragment/src/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsBaseState> {
  late final StreamSubscription<Setting> _sub;

  SettingsBloc()
      : super(SettingsState(
          darkTheme: SettingsRepository.instance().isDark,
          langCode: SettingsRepository.instance().language,
        )) {
    on<SettingsEvent>(_onEvent, transformer: sequential());
    _subscribe();
  }

  Future<void> _subscribe() async {
    _sub = SettingsRepository.instanceChecked().changeNotifier.listen((event) {
      add(_SettingChangedEvent(event));
    });
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    await super.close();
  }

  FutureOr<void> _onEvent(
    SettingsEvent event,
    Emitter<SettingsBaseState> emit,
  ) async {
    var i = SettingsRepository.instance();
    if (!i.initialized) {
      await SettingsRepository.instance().init();
    }

    if (event is ToggleThemeEvent) {
      await i.setIsDark(!state.darkTheme);
      return;
    }

    if (event is ChangeLanguageEvent) {
      await i.setLanguage(event.languageCode);

      return;
    }

    if (event is _SettingChangedEvent) {
      if (event.setting.key == SettingKey.isDark) {
        emit(state.copyWith(darkTheme: event.setting.value));
      } else if (event.setting.key == SettingKey.language) {
        final isLeft = _getCurrencySymbolPos(event.setting.value);
        emit(
          state.copyWith(
            langCode: event.setting.value,
            currSymbolIsLeft: isLeft,
          ),
        );
      }
    }
  }

  bool _getCurrencySymbolPos(String langCode) {
    // TODO: Find how to get where the currency symbol goes for a given lang
    final f =
        NumberFormat.currency(locale: langCode, name: 'abc', decimalDigits: 0);

    var isLeft = false;
    var o = f.format(123);
    if (o.startsWith('abc')) isLeft = true;
    return isLeft;
  }
}
