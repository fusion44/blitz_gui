import 'dart:async';

import 'package:blitz_gui/common/subscription_repository.dart';
import 'package:blitz_gui/dashboard/blocs/system_info/system_info_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'system_info_event.dart';
part 'system_info_state.dart';

class SystemInfoBloc extends Bloc<SystemInfoEvent, SystemInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

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
      yield SystemInfoState(event.info);
    }
  }

  void _listenSystemEvents() {
    _sub = repo.filteredStream([SseEventTypes.sysStatus])?.listen((event) {
      final i = SystemInfo.fromJson(event['data']);
      add(_SystemInfoUpdate(i));
    });
  }
}
