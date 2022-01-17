import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:subscription_repository/subscription_repository.dart';

import '../../fee_revenue/fee_revenue.dart';
import '../../wallet_balance/models/wallet_balance.dart';
import '../models/lightning_info.dart';

part 'lightning_info_event.dart';
part 'lightning_info_state.dart';

class LightningInfoBloc
    extends Bloc<LightningInfoEvent, LightningInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  LightningInfoBloc(this.repo) : super(LightningInfoInitial()) {
    on<LightningInfoEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    LightningInfoEvent event,
    Emitter<LightningInfoBaseState> emit,
  ) async {
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

      emit(
        _curr.copyWith(
          lnInfo: event.lnInfo,
          walletBalance: event.walletBalance,
          feeRevenueData: event.feeRevenueData,
        ),
      );
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([
      SseEventTypes.lnInfo,
      SseEventTypes.walletBalance,
      SseEventTypes.lnFeeRevenue
    ])?.listen((event) {
      if (event['event'] == 'wallet_balance') {
        final wb = WalletBalance.fromJson(event['data']);
        add(_LightningInfoUpdate(walletBalance: wb));
      } else if (event['event'] == 'ln_fee_revenue') {
        final fr = FeeRevenueData.fromJson(event['data']);
        add(_LightningInfoUpdate(feeRevenueData: fr));
      } else {
        final i = LightningInfo.fromJson(event['data']);
        add(_LightningInfoUpdate(lnInfo: i));
      }
    });
  }
}
