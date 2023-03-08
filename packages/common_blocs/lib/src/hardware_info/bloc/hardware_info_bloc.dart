import 'dart:async';
import 'dart:convert';

import 'package:authentication/authentication.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'hardware_info_event.dart';
part 'hardware_info_state.dart';

class HardwareInfoBloc extends Bloc<HardwareInfoEvent, HardwareInfoBaseState> {
  final SubscriptionRepository _subRepo;
  final AuthRepo _authRepo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  HardwareInfo? _lastInfo;

  DateTime _lastUpdateTime = DateTime.now();

  HardwareInfoBloc(this._subRepo, this._authRepo)
      : super(HardwareInfoInitial()) {
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
        ul = ((event.info.networksBytesSent - bytesSent) / 1024);
        dl = ((event.info.networksBytesReceived - bytesRecv) / 1024);
        ul /= deltaT;
        dl /= deltaT;
        _lastUpdateTime = t;
      }

      _lastInfo = event.info;
      emit(HardwareInfoState(event.info, ul, dl));
    }
  }

  void _listenHardwareEvents() {
    _sub = _subRepo.filteredStream([SseEventTypes.hardwareInfo])?.listen(
      (event) {
        final i = HardwareInfo.fromJson(event['data']);
        add(_HardwareInfoUpdate(i));
      },
    );
  }

  void _warmup() async {
    try {
      final url = '${_authRepo.baseUrl()}/latest/system/hardware-info';
      final response = await fetch(Uri.parse(url), _authRepo.token());
      final b = HardwareInfo.fromJson(jsonDecode(response.body));
      add(_HardwareInfoUpdate(b));
    } catch (e) {
      add(_HardwareInfoErrorEvent(e.toString()));
    } finally {
      _listenHardwareEvents();
    }
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
