import 'dart:async';

import 'package:common/common.dart';
import 'package:common_blocs/src/system_info/repository/system_info_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'system_info_event.dart';
part 'system_info_state.dart';

class SystemInfoBloc extends Bloc<SystemInfoBaseEvent, SystemInfoBaseState> {
  late final StreamSubscription? _sub;

  SystemInfoBloc() : super(SystemInfoInitial()) {
    final repo = SystemInfoRepo.instance();
    on<StartListenSystemInfo>((event, emit) {
      repo.latest != null ? emit(SystemInfoState(repo.latest!)) : null;

      _sub = repo.systemInfoStream
          .listen((event) => add(_SystemInfoUpdate(event)));
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
