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
    await _sub?.cancel();
    super.close();
  }

  BitcoinCoreContainerBloc(this.containerId)
      : super(BitcoinCoreContainerInitial()) {
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
      await NetworkManager().startContainer(containerId);
    });

    on<StopBitcoinCoreContainerEvent>((event, emit) async {
      await NetworkManager().stopContainer(containerId);
    });

    on<_BitcoinCoreStatusUpdate>((event, emit) {
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

  void _subStatuses() {
    _sub?.cancel();

    final c = NetworkManager().nodeMap[containerId] as BitcoinCoreContainer;
    _sub = c.statusStream.listen((event) {
      add(_BitcoinCoreStatusUpdate(event));
    });
  }
}
