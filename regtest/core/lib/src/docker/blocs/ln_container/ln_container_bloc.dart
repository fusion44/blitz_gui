import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';

part 'ln_container_event.dart';
part 'ln_container_state.dart';

class LnContainerBloc extends Bloc<LnContainerEvent, LnContainerState> {
  final String containerId;

  StreamSubscription<ContainerStatusMessage>? _sub;

  @override
  Future<void> close() async {
    await _unSubStatuses();
    super.close();
  }

  LnContainerBloc(this.containerId)
      : super(LnStatusUpdate.fromContainer(containerId)) {
    on<LnSettingsUpdatedEvent>((event, emit) async {
      await NetworkManager().updateContainerOptions(containerId, event.options);

      emit(
        LnStatusUpdate(
          ContainerStatusMessage(
            ContainerStatus.uninitialized,
            'Settings updated.',
          ),
          event.options.name,
          event.options.image,
          event.options.workDir,
        ),
      );
    });

    on<StartLnContainerEvent>((event, emit) async {
      _subStatuses();
      await NetworkManager().startContainer(containerId);
    });

    on<StopLnContainerEvent>((event, emit) async {
      await NetworkManager().stopContainer(containerId);
    });

    on<DeleteLnContainerEvent>((event, emit) async {
      await NetworkManager().deleteContainer(containerId);
    });

    on<_LnStatusUpdate>((event, emit) async {
      if (event.status.status == ContainerStatus.deleted) {
        final lastState = state;
        if (lastState is LnStatusUpdate) {
          emit(
            LnStatusUpdate(
              event.status,
              lastState.name,
              lastState.image,
              lastState.workDir,
            ),
          );
        }

        await _unSubStatuses();
        return;
      }

      final c = NetworkManager().nodeMap[containerId] as LnContainer;
      emit(
        LnStatusUpdate(
          event.status,
          c.containerName,
          c.image,
          c.workDir,
        ),
      );
    });

    _subStatuses();
  }

  Future<void> _subStatuses() async {
    _sub?.cancel();

    final c = NetworkManager().findContainerById<LnContainer>(containerId);

    if (c == null) {
      throw StateError('LndContainer with ID $containerId not found');
    }

    _sub = c.statusStream.listen((event) {
      add(_LnStatusUpdate(event));
    });

    try {
      final event = await c.statusStream.last;
      add(_LnStatusUpdate(event));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _unSubStatuses() async {
    await _sub?.cancel();
    _sub = null;
  }
}
