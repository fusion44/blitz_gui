import 'dart:async';

import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'system_info_event.dart';
part 'system_info_state.dart';

class SystemInfoBloc extends Bloc<SystemInfoBaseEvent, SystemInfoBaseState> {
  final SubscriptionRepository _repo = SubscriptionRepository.instanceChecked();

  late final StreamSubscription<Map<String, dynamic>>? _sub;

  SystemInfoBloc() : super(SystemInfoInitial()) {
    on<StartListenSystemInfo>((event, emit) {
      _sub = _repo.filteredStream([SseEventTypes.systemInfo])?.listen((event) {
        final i = SystemInfo.fromJson(event['data']);
        add(_SystemInfoUpdate(i));
      });
    });

    on<_SystemInfoUpdate>((event, emit) {
      emit(SystemInfoState(event.info));
    });

    on<StopListenSystemInfo>((event, emit) async {
      await _sub?.cancel();
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
