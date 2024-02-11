import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

enum SettingKey { isDark, language }

class Setting {
  final SettingKey key;
  final dynamic value;

  Setting(this.key, this.value);
}

class SettingsRepository {
  // -------------------------------
  // Class variables and methods
  // -------------------------------
  final String _dbName = 'settings';
  late Box _box;

  final StreamController<Setting> _changeNotifier = StreamController();
  late final _stream = _changeNotifier.stream.asBroadcastStream();
  Stream<Setting> get changeNotifier => _stream;

  Map<String, dynamic> get map => {
        'isDark': _isDark,
        'language': _language,
        'endpoints': _endpointUrls,
      };

  // -------------------------------
  // Endpoint variables and methods
  // -------------------------------
  final String _keyEndpointUrls = 'settings_endpoint_urls';
  final List<String> _endpointUrls = [];

  String get defaultEndpoint => _endpointUrls.first;
  List<String> get endpoints => _endpointUrls;

  Future<void> addEndpoint(String url) async {
    if (_endpointUrls.contains(url)) return;

    _endpointUrls.add(url);
    await _box.put(_keyEndpointUrls, _endpointUrls);
  }

  Future<void> removeEndpoint(String url) async {
    if (!_endpointUrls.contains(url)) return;

    _endpointUrls.remove(url);
    await _box.put(_keyEndpointUrls, _endpointUrls);
  }

  // set a default endpoint
  Future<void> setDefaultEndpoint(String url) async {
    _endpointUrls.remove(url);
    _endpointUrls.insert(0, url);
    await _box.put(_keyEndpointUrls, _endpointUrls);
  }

  // -------------------------------
  // Theme variables and methods
  // -------------------------------
  final String _keyTheme = 'settings_is_dark';
  bool _isDark = false;

  bool get isDark => _isDark;
  Future<void> setIsDark(bool isDark) async {
    await _box.put(_keyTheme, isDark);
    _isDark = isDark;
    _changeNotifier.add(Setting(SettingKey.isDark, _isDark));
  }

  // -------------------------------
  // Language variables and methods
  // -------------------------------
  final String _keyLanguage = 'settings_language';
  String _language = 'en';

  String get language => _language;

  Future<void> setLanguage(String langCode) async {
    await _box.put(_keyLanguage, langCode);
    _language = langCode;
    _changeNotifier.add(Setting(SettingKey.language, _language));
  }

  // -------------------------------
  // Singleton variables and methods
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
        _keyEndpointUrls: [
          'http://0.0.0.0:11111',
          'http://192.168.178.38/api',
          'http://192.168.178.41/api',
          'http://127.0.0.1:8000/',
        ],
      });
    }

    _isDark = await _box.get(_keyTheme);
    _language = await _box.get(_keyLanguage);
    _endpointUrls.clear();
    final res = await _box.get(_keyEndpointUrls);
    if (res != null) _endpointUrls.addAll(res);

    _isInitialized = true;
  }

  Future<void> dispose() async {
    await _changeNotifier.close();
    await _box.close();
  }
}
