import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsBaseState> {
  final String _dbName = 'settings';
  final String _keyTheme = 'settings_is_dark';
  final String _keyLanguage = 'settings_language';
  late Box _box;

  SettingsBloc() : super(SettingsState(darkTheme: false));

  @override
  Stream<SettingsBaseState> mapEventToState(SettingsEvent event) async* {
    if (event is AppStartEvent) {
      _box = await Hive.openBox(_dbName);
      if (_box.isEmpty) {
        // set default values
        await _box.putAll({
          _keyLanguage: 'en',
          _keyTheme: false,
        });
        yield SettingsLoadedState();
      } else {
        final lang = await _box.get(_keyLanguage);
        yield SettingsLoadedState(
          darkTheme: await _box.get(_keyTheme),
          langCode: lang,
          currSymbolIsLeft: _getCurrencySymbolPos(lang),
        );
      }
    } else if (event is ToggleThemeEvent) {
      await _box.put(_keyTheme, !state.darkTheme);
      yield state.copyWith(darkTheme: !state.darkTheme);
    } else if (event is ChangeLanguageEvent) {
      final isLeft = _getCurrencySymbolPos(event.languageCode);
      await _box.put(_keyLanguage, event.languageCode);
      yield state.copyWith(
        langCode: event.languageCode,
        currSymbolIsLeft: isLeft,
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
