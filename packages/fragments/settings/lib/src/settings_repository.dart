import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

enum SettingKey { isDark, language }

class Setting {
  final SettingKey key;
  final dynamic value;

  Setting(this.key, this.value);
}

class SettingsRepository {
  final String _dbName = 'settings';

  final String _keyTheme = 'settings_is_dark';
  bool _isDark = false;

  final String _keyLanguage = 'settings_language';
  String _language = 'en';

  late Box _box;

  bool get isDark => _isDark;

  final StreamController<Setting> _changeNotifier = StreamController();
  late final _stream = _changeNotifier.stream.asBroadcastStream();

  Stream<Setting> get changeNotifier => _stream;

  Future<void> setIsDark(bool isDark) async {
    await _box.put(_keyTheme, isDark);
    _isDark = isDark;
    _changeNotifier.add(Setting(SettingKey.isDark, _isDark));
  }

  String get language => _language;

  Future<void> setLanguage(String langCode) async {
    await _box.put(_keyLanguage, langCode);
    _language = langCode;
    _changeNotifier.add(Setting(SettingKey.language, _language));
  }

  Map<String, dynamic> get map => {
        'isDark': _isDark,
        'language': _language,
      };

  // -------------------------------
  // Singleton stuff
  // -------------------------------

  bool _isInitialized = false;
  SettingsRepository._internal();
  static SettingsRepository? _instance;

  static SettingsRepository instance() {
    _instance ??= SettingsRepository._internal();

    return _instance!;
  }

  static SettingsRepository instanceChecked() {
    if (_instance == null) {
      throw StateError('SettingsRepository is not initialized');
    }

    return SettingsRepository.instance();
  }

  bool get initialized => _isInitialized;

  Future<void> init() async {
    _box = await Hive.openBox(_dbName);
    if (_box.isEmpty) {
      // set default values
      await _box.putAll({
        _keyLanguage: 'en',
        _keyTheme: false,
      });
    }

    _isDark = await _box.get(_keyTheme);
    _language = await _box.get(_keyLanguage);

    _isInitialized = true;
  }

  Future<void> dispose() async {
    await _changeNotifier.close();
    await _box.close();
  }
}
