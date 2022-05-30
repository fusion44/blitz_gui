import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsBaseState> {
  final String _dbName = 'settings';
  final String _keyTheme = 'settings_is_dark';
  final String _keyLanguage = 'settings_language';
  late Box _box;

  SettingsBloc() : super(SettingsState(darkTheme: false)) {
    on<SettingsEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    SettingsEvent event,
    Emitter<SettingsBaseState> emit,
  ) async {
    if (event is AppStartEvent) {
      _box = await Hive.openBox(_dbName);
      if (_box.isEmpty) {
        // set default values
        await _box.putAll({
          _keyLanguage: 'en',
          _keyTheme: false,
        });
        emit(SettingsLoadedState());
      } else {
        final lang = await _box.get(_keyLanguage);
        emit(
          SettingsLoadedState(
            darkTheme: await _box.get(_keyTheme),
            langCode: lang,
            currSymbolIsLeft: _getCurrencySymbolPos(lang),
          ),
        );
      }
    } else if (event is ToggleThemeEvent) {
      await _box.put(_keyTheme, !state.darkTheme);
      emit(state.copyWith(darkTheme: !state.darkTheme));
    } else if (event is ChangeLanguageEvent) {
      final isLeft = _getCurrencySymbolPos(event.languageCode);
      await _box.put(_keyLanguage, event.languageCode);
      emit(
        state.copyWith(
          langCode: event.languageCode,
          currSymbolIsLeft: isLeft,
        ),
      );
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
