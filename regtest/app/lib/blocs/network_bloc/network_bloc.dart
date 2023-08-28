import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:regtest_core/core.dart';

import '../../pages/containers/redis_manager.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription<NetworkStateMessage>? _sub;

  NetworkBloc() : super(NetworkState(NetworkStateMessage.checking())) {
    _init();

    on<NetworkEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<_SendNetworkUpdate>((event, emit) {
      emit(NetworkState(event.networkState));
    });
  }

  @override
  Future<void> close() async {
    if (_sub != null) await _sub?.cancel();
    return super.close();
  }

  void _init() async {
    final mgr = NetworkManager();

    try {
      if (!mgr.initialized) await mgr.init();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    _sub = mgr.netStateStream.listen((event) {
      add(_SendNetworkUpdate(event));
    });
    mgr.refresh();

    RedisManager().init();
  }
}
