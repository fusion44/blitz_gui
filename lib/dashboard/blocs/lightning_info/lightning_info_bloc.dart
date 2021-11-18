import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../common/models/lightning_info.dart';
import '../../../common/models/wallet_balance.dart';
import '../../../common/subscription_repository.dart';

part 'lightning_info_event.dart';
part 'lightning_info_state.dart';

class LightningInfoBloc
    extends Bloc<LightningInfoEvent, LightningInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  LightningInfoBloc(this.repo) : super(LightningInfoInitial());

  @override
  Stream<LightningInfoBaseState> mapEventToState(
    LightningInfoEvent event,
  ) async* {
    if (event is StartListenLightningInfo) {
      _startListenLnEvents();
    } else if (event is StopListenLightningInfo) {
      await _sub?.cancel();
    } else if (event is _LightningInfoUpdate) {
      LightningInfoState _curr;
      try {
        _curr = state as LightningInfoState;
      } catch (e) {
        _curr = const LightningInfoState();
      }

      yield _curr.copyWith(
        lnInfo: event.lnInfo,
        walletBalance: event.walletBalance,
      );
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([
      SseEventTypes.lnInfo,
      SseEventTypes.walletBalance,
    ])?.listen((event) {
      if (event['event'] == 'wallet_balance') {
        final wb = WalletBalance.fromJson(event['data']);
        add(_LightningInfoUpdate(walletBalance: wb));
      } else {
        final i = LightningInfo.fromJson(event['data']);
        add(_LightningInfoUpdate(lnInfo: i));
      }
    });
  }
}
