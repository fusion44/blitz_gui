import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';

part 'bitcoin_core_container_event.dart';
part 'bitcoin_core_container_state.dart';

class BitcoinCoreContainerBloc
    extends Bloc<BitcoinCoreContainerEvent, BitcoinCoreContainerState> {
  final String containerId;

  StreamSubscription<ContainerStatusMessage>? _sub;

  @override
  Future<void> close() async {
    await _unSubStatuses();
    super.close();
  }

  BitcoinCoreContainerBloc(this.containerId)
      : super(BitcoinCoreStatusUpdate.fromContainer(containerId)) {
    on<SettingsUpdatedEvent>((event, emit) async {
      await NetworkManager().updateContainerOptions(containerId, event.options);

      emit(
        BitcoinCoreStatusUpdate(
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

    on<StartBitcoinCoreContainerEvent>((event, emit) async {
      _subStatuses();
      await NetworkManager().startContainer(containerId);
    });

    on<StopBitcoinCoreContainerEvent>((event, emit) async {
      await NetworkManager().stopContainer(containerId);
    });

    on<DeleteBitcoinCoreContainerEvent>((event, emit) async {
      await NetworkManager().deleteContainer(containerId);
    });

    on<_BitcoinCoreStatusUpdate>((event, emit) async {
      if (event.status.status == ContainerStatus.deleted) {
        final lastState = state;
        if (lastState is BitcoinCoreStatusUpdate) {
          emit(
            BitcoinCoreStatusUpdate(
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

      final c = NetworkManager().nodeMap[containerId] as BitcoinCoreContainer;
      emit(
        BitcoinCoreStatusUpdate(
          event.status,
          c.name,
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
        NetworkManager().findContainerById<BitcoinCoreContainer>(containerId);

    if (c == null) {
      throw StateError('BitcoinCoreContainer with ID $containerId not found');
    }

    _sub = c.statusStream.listen((event) {
      add(_BitcoinCoreStatusUpdate(event));
    });

    try {
      final event = await c.statusStream.last;
      add(_BitcoinCoreStatusUpdate(event));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _unSubStatuses() async {
    await _sub?.cancel();
    _sub = null;
  }
}
