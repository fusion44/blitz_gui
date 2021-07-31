import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/subscription_repository.dart';
import 'system_info_model.dart';

part 'system_info_event.dart';
part 'system_info_state.dart';

class SystemInfoBloc extends Bloc<SystemInfoEvent, SystemInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  SystemInfo? _lastInfo;

  DateTime _lastUpdateTime = DateTime.now();

  SystemInfoBloc(this.repo) : super(SystemInfoInitial());

  @override
  Stream<SystemInfoBaseState> mapEventToState(
    SystemInfoEvent event,
  ) async* {
    if (event is StartListenSystemInfo) {
      _listenSystemEvents();
    } else if (event is StopListenSystemInfo) {
      await _sub?.cancel();
    } else if (event is _SystemInfoUpdate) {
      var ul = 0.0;
      var dl = 0.0;

      if (_lastInfo != null && _lastInfo?.networksBytesSent != null) {
        final t = DateTime.now();
        final deltaT = t.difference(_lastUpdateTime).inMilliseconds;
        final bytesSent = _lastInfo?.networksBytesSent ?? 0.0;
        final bytesRecv = _lastInfo?.networksBytesReceived ?? 0.0;
        ul = ((event.info.networksBytesSent! - bytesSent) / 1024);
        dl = ((event.info.networksBytesReceived! - bytesRecv) / 1024);
        ul /= deltaT;
        dl /= deltaT;
        _lastUpdateTime = t;
      }

      _lastInfo = event.info;
      yield SystemInfoState(event.info, ul, dl);
    }
  }

  void _listenSystemEvents() {
    _sub = repo.filteredStream([SseEventTypes.sysStatus])?.listen((event) {
      final i = SystemInfo.fromJson(event['data']);
      add(_SystemInfoUpdate(i));
    });
  }
}
