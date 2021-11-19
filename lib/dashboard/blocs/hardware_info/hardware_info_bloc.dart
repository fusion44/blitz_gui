import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../common/subscription_repository.dart';
import 'hardware_info_model.dart';

part 'hardware_info_event.dart';
part 'hardware_info_state.dart';

class HardwareInfoBloc extends Bloc<HardwareInfoEvent, HardwareInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  HardwareInfo? _lastInfo;

  DateTime _lastUpdateTime = DateTime.now();

  HardwareInfoBloc(this.repo) : super(HardwareInfoInitial()) {
    on<HardwareInfoEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    HardwareInfoEvent event,
    Emitter<HardwareInfoBaseState> emit,
  ) async {
    if (event is StartListenHardwareInfo) {
      _warmup();
    } else if (event is StopListenHardwareInfo) {
      await _sub?.cancel();
    } else if (event is _HardwareInfoErrorEvent) {
      emit(HardwareInfoErrorState(event.message));
    } else if (event is _HardwareInfoUpdate) {
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
      emit(HardwareInfoState(event.info, ul, dl));
    }
  }

  void _listenHardwareEvents() {
    _sub = repo.filteredStream([SseEventTypes.hardwareInfo])?.listen((event) {
      final i = HardwareInfo.fromJson(event['data']);
      add(_HardwareInfoUpdate(i));
    });
  }

  void _warmup() async {
    try {
      var response =
          await Dio().get('http://127.0.0.1:8000/v1/system/hardware-info');
      final b = HardwareInfo.fromJson(response.data);
      add(_HardwareInfoUpdate(b));
    } catch (e) {
      add(_HardwareInfoErrorEvent(e.toString()));
    } finally {
      _listenHardwareEvents();
    }
  }
}
