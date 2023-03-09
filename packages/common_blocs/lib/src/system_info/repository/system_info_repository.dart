import 'dart:async';
import 'dart:convert';

import 'package:authentication/authentication.dart';
import 'package:common/common.dart';
import 'package:subscription_repository/subscription_repository.dart';

class SystemInfoRepo {
  late final Stream<Map<String, dynamic>> _stream =
      SubscriptionRepository.instanceChecked()
          .filteredStream([SseEventTypes.systemInfo])!;

  SystemInfo? _latestInfo;

  SystemInfo? get latest => _latestInfo;

  Stream<SystemInfo> get systemInfoStream => _stream.map((event) {
        _latestInfo = SystemInfo.fromJson(event['data']);
        return _latestInfo!;
      });

  Future<SystemInfo?> fetchInfo() async {
    final authRepo = AuthRepo.instanceChecked();
    try {
      final url = '${authRepo.baseUrl()}/latest/system/get-system-info';
      final response = await fetch(Uri.parse(url), authRepo.token());
      final b = SystemInfo.fromJson(jsonDecode(response.body));
      return b;
    } catch (e) {
      rethrow;
    }
  }

  //-----------------------------------
  // Singleton
  //-----------------------------------
  static SystemInfoRepo? _instance;
  SystemInfoRepo._internal();

  static SystemInfoRepo instance() {
    _instance ??= SystemInfoRepo._internal();

    return _instance!;
  }

  static SystemInfoRepo instanceChecked() {
    if (_instance == null) {
      throw StateError('SysteminfoRepository is not initialized');
    }

    return SystemInfoRepo.instance();
  }
}
