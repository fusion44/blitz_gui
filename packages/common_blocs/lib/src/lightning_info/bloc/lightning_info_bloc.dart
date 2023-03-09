import 'dart:async';
import 'dart:convert';

import 'package:authentication/authentication.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'lightning_info_event.dart';
part 'lightning_info_state.dart';

class LightningInfoBloc
    extends Bloc<LightningInfoEvent, LightningInfoBaseState> {
  StreamSubscription<Map<String, dynamic>>? _sub;

  LightningInfoBloc() : super(LightningInfoInitial()) {
    _warmup();
    on<LightningInfoEvent>(_onEvent, transformer: sequential());
  }

  void _warmup() async {
    final authRepo = AuthRepo.instanceChecked();
    try {
      final res = await Future.wait([
        fetch(
          Uri.parse('${authRepo.baseUrl()}/latest/lightning/get-info'),
          authRepo.token(),
        ),
        fetch(
          Uri.parse('${authRepo.baseUrl()}/latest/lightning/get-fee-revenue'),
          authRepo.token(),
        ),
        fetch(
          Uri.parse('${authRepo.baseUrl()}/latest/lightning/get-balance'),
          authRepo.token(),
        )
      ]);

      final i = LightningInfo.fromJson(jsonDecode(res[0].body));
      final fr = FeeRevenueData.fromJson(jsonDecode(res[1].body));
      final wb = WalletBalance.fromJson(jsonDecode(res[2].body));

      add(
        _LightningInfoUpdate(
          lnInfo: i,
          feeRevenueData: fr,
          walletBalance: wb,
        ),
      );
    } catch (e) {
      add(_LightningInfoErrorEvent(e.toString()));
    }
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
      LightningInfoState curr;
      try {
        if (state is LightningInfoState) {
          curr = state as LightningInfoState;
        } else {
          curr = LightningInfoState(
            info: event.lnInfo ?? const LightningInfo(),
            walletBalance: event.walletBalance ?? const WalletBalance(),
            feeRevenueData: event.feeRevenueData ?? const FeeRevenueData(),
          );
        }
      } catch (e) {
        emit(LightningInfoErrorState(e.toString()));
        return;
      }

      emit(
        curr.copyWith(
          lnInfo: event.lnInfo,
          walletBalance: event.walletBalance,
          feeRevenueData: event.feeRevenueData,
        ),
      );
    } else if (event is _LightningInfoErrorEvent) {
      emit(LightningInfoErrorState(event.errorMessage));
    }
  }

  void _startListenLnEvents() {
    final subRepo = SubscriptionRepository.instanceChecked();

    _sub = subRepo.filteredStream([
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

  @override
  close() async {
    await _sub?.cancel();
    return super.close();
  }
}
