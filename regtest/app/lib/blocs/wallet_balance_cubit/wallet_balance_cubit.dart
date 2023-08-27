import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'wallet_balance_state.dart';

class WalletBalanceCubit extends Cubit<WalletBalanceState> {
  final BlitzApiContainer _bapi;

  StreamSubscription<Map<String, dynamic>>? _sub;

  WalletBalanceCubit(this._bapi) : super(WalletBalanceInitial()) {
    _subscribe();
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }

  Future<void> _subscribe() async {
    try {
      _sub = _bapi.subRepo.filteredStream([
        SseEventTypes.walletBalance,
      ])?.listen(
        (event) => emit(
          WalletBalanceUpdated(WalletBalance.fromJson(event['data'])),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
