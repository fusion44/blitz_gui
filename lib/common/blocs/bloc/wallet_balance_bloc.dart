import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../subscription_repository.dart';

part 'wallet_balance_event.dart';
part 'wallet_balance_state.dart';

class WalletBalanceBloc
    extends Bloc<WalletBalanceBaseEvent, WalletBalanceBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  WalletBalanceBloc(this.repo) : super(WalletBalanceInitial());

  @override
  Stream<WalletBalanceBaseState> mapEventToState(
    WalletBalanceBaseEvent event,
  ) async* {
    if (event is StartListenWalletBalance) {
      _warmup();
    } else if (event is StopListenWalletBalance) {
      await _sub?.cancel();
    } else if (event is _WalletBalanceUpdate) {
      yield WalletBalanceUpdated(event.balance);
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([SseEventTypes.walletBalance])?.listen((event) {
      final b = WalletBalance.fromJson(event['data']);
      add(_WalletBalanceUpdate(b));
    });
  }

  void _warmup() async {
    var response =
        await Dio().get('http://127.0.0.1:8000/lightning/getbalance');
    final b = WalletBalance.fromJson(response.data);
    add(_WalletBalanceUpdate(b));
    _startListenLnEvents();
  }
}
