import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';

part 'blitz_api_container_event.dart';
part 'blitz_api_container_state.dart';

class BlitzApiContainerBloc
    extends Bloc<BlitzApiContainerEvent, BlitzApiContainerState> {
  final String containerId;

  StreamSubscription<ContainerStatusMessage>? _sub;

  @override
  Future<void> close() async {
    await _unSubStatuses();
    super.close();
  }

  BlitzApiContainerBloc(this.containerId)
      : super(BlitzApiStatusUpdate.fromContainer(containerId)) {
    on<BlitzApiSettingsUpdatedEvent>((event, emit) async {
      // NetworkManager internally creates a new Container, so we have
      // to resubscribe to get status information from the new container
      await _unSubStatuses();
      await NetworkManager().updateContainerOptions(containerId, event.options);
      await _subStatuses();

      emit(
        BlitzApiStatusUpdate(
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

    on<StartBlitzApiContainerEvent>((event, emit) async {
      _subStatuses();
      await NetworkManager().startContainer(containerId);
    });

    on<StopBlitzApiContainerEvent>((event, emit) async {
      await NetworkManager().stopContainer(containerId);
    });

    on<DeleteBlitzApiContainerEvent>((event, emit) async {
      await NetworkManager().deleteContainer(containerId);
    });

    on<_BlitzApiStatusUpdate>((event, emit) async {
      if (event.status.status == ContainerStatus.deleted) {
        final lastState = state;
        if (lastState is BlitzApiStatusUpdate) {
          emit(
            BlitzApiStatusUpdate(
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

      final c = NetworkManager().nodeMap[containerId] as BlitzApiContainer;
      emit(
        BlitzApiStatusUpdate(
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

    final c =
        NetworkManager().findContainerById<BlitzApiContainer>(containerId);

    if (c == null) {
      throw StateError('BlitzApiContainer with ID $containerId not found');
    }

    _sub = c.statusStream.listen((event) {
      add(_BlitzApiStatusUpdate(event));
    });

    try {
      final event = await c.statusStream.last;
      add(_BlitzApiStatusUpdate(event));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _unSubStatuses() async {
    await _sub?.cancel();
    _sub = null;
  }
}
