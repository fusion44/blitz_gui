import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';

part 'bitcoin_core_container_event.dart';
part 'bitcoin_core_container_state.dart';

class BitcoinCoreContainerBloc
    extends Bloc<BitcoinCoreContainerEvent, BitcoinCoreContainerState> {
  final BitcoinCoreContainer container;

  StreamSubscription<ContainerStatusMessage>? _sub;

  @override
  Future<void> close() async {
    await _sub?.cancel();
    super.close();
  }

  BitcoinCoreContainerBloc(this.container)
      : super(BitcoinCoreContainerInitial()) {
    on<StartBitcoinCoreContainerEvent>((event, emit) async {
      await NetworkManager().startContainer(container);
    });

    on<StopBitcoinCoreContainerEvent>((event, emit) async {
      await NetworkManager().stopContainer(container);
    });

    on<_BitcoinCoreStatusUpdate>((event, emit) {
      emit(BitcoinCoreStatusUpdate(event.status));
    });

    _sub = container.statusStream.listen((event) {
      add(_BitcoinCoreStatusUpdate(event));
    });
  }
}
