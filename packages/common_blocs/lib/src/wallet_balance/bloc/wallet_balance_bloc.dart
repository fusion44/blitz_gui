import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:subscription_repository/subscription_repository.dart';

import '../models/models.dart';

part 'wallet_balance_event.dart';
part 'wallet_balance_state.dart';

class WalletBalanceBloc
    extends Bloc<WalletBalanceBaseEvent, WalletBalanceBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  WalletBalanceBloc(this.repo) : super(WalletBalanceInitial()) {
    on<WalletBalanceBaseEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(WalletBalanceBaseEvent event,
      Emitter<WalletBalanceBaseState> emit) async {
    if (event is StartListenWalletBalance) {
      _startListenLnEvents();
    } else if (event is StopListenWalletBalance) {
      await _sub?.cancel();
    } else if (event is _WalletBalanceUpdate) {
      emit(WalletBalanceUpdated(event.balance));
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([SseEventTypes.walletBalance])?.listen((event) {
      final b = WalletBalance.fromJson(event['data']);
      add(_WalletBalanceUpdate(b));
    });
  }
}
