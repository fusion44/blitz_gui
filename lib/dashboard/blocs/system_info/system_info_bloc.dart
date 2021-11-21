import 'dart:async';

import '../../../common/subscription_repository.dart';
import 'system_info_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'system_info_event.dart';
part 'system_info_state.dart';

class SystemInfoBloc extends Bloc<SystemInfoBaseEvent, SystemInfoBaseState> {
  final SubscriptionRepository _repo;

  late final StreamSubscription<Map<String, dynamic>>? _sub;

  SystemInfoBloc(this._repo) : super(SystemInfoInitial()) {
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
}
