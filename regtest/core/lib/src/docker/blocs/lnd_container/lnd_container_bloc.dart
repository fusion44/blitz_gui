import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';

part 'lnd_container_event.dart';
part 'lnd_container_state.dart';

class LndContainerBloc extends Bloc<LndContainerEvent, LndContainerState> {
  final String containerId;

  StreamSubscription<ContainerStatusMessage>? _sub;

  @override
  Future<void> close() async {
    await _unSubStatuses();
    super.close();
  }

  LndContainerBloc(this.containerId)
      : super(LndStatusUpdate.fromContainer(containerId)) {
    on<LndSettingsUpdatedEvent>((event, emit) async {
      await NetworkManager().updateContainerOptions(containerId, event.options);

      emit(
        LndStatusUpdate(
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

    on<StartLndContainerEvent>((event, emit) async {
      _subStatuses();
      await NetworkManager().startContainer(containerId);
    });

    on<StopLndContainerEvent>((event, emit) async {
      await NetworkManager().stopContainer(containerId);
    });

    on<DeleteLndContainerEvent>((event, emit) async {
      await NetworkManager().deleteContainer(containerId);
    });

    on<_LndStatusUpdate>((event, emit) async {
      if (event.status.status == ContainerStatus.deleted) {
        final lastState = state;
        if (lastState is LndStatusUpdate) {
          emit(
            LndStatusUpdate(
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

      final c = NetworkManager().nodeMap[containerId] as LndContainer;
      emit(
        LndStatusUpdate(
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

    final c = NetworkManager().findContainerById<LndContainer>(containerId);

    if (c == null) {
      throw StateError('LndContainer with ID $containerId not found');
    }

    _sub = c.statusStream.listen((event) {
      add(_LndStatusUpdate(event));
    });

    try {
      final event = await c.statusStream.last;
      add(_LndStatusUpdate(event));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _unSubStatuses() async {
    await _sub?.cancel();
    _sub = null;
  }
}
