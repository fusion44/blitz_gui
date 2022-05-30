import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'wallet_locked_checker_event.dart';
part 'wallet_locked_checker_state.dart';

class WalletLockedCheckerBloc
    extends Bloc<WalletLockedCheckerEvent, WalletLockedCheckerState> {
  final SubscriptionRepository _subRepo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  WalletLockedCheckerBloc(this._subRepo) : super(WalletLockedCheckerInitial()) {
    on<StartCheckWalletLocked>((event, emit) async {
      _listenWalletEvents();
      emit(LoadingWalletStatus());
    });

    on<WalletLockStateUpdate>((event, emit) async {
      if (event.isLocked) {
        emit(WalletLocked());
      } else {
        add(StopCheckWalletLocked());
        emit(WalletUnlocked());
      }
    });

    on<StopCheckWalletLocked>((event, emit) async {
      _sub?.cancel();
    });
  }

  void _listenWalletEvents() {
    _sub = _subRepo.filteredStream([SseEventTypes.walletLockStatus])?.listen(
      (event) {
        final locked = event['data']['locked'];
        add(WalletLockStateUpdate(locked));
      },
    );
  }
}
