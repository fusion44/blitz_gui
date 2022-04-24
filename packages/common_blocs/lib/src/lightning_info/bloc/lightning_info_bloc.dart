import 'dart:async';
import 'dart:convert';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'lightning_info_event.dart';
part 'lightning_info_state.dart';

class LightningInfoBloc
    extends Bloc<LightningInfoEvent, LightningInfoBaseState> {
  final AuthRepo _authRepo;
  final SubscriptionRepository _repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  LightningInfoBloc(this._authRepo, this._repo)
      : super(LightningInfoInitial()) {
    _warmup();
    on<LightningInfoEvent>(_onEvent, transformer: sequential());
  }

  void _warmup() async {
    try {
      final res = await Future.wait([
        fetch(
          Uri.parse('${_authRepo.baseUrl()}/latest/lightning/get-info'),
          _authRepo.token(),
        ),
        fetch(
          Uri.parse('${_authRepo.baseUrl()}/latest/lightning/get-fee-revenue'),
          _authRepo.token(),
        ),
        fetch(
          Uri.parse('${_authRepo.baseUrl()}/latest/lightning/get-balance'),
          _authRepo.token(),
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
      LightningInfoState _curr;
      try {
        if (state is LightningInfoState) {
          _curr = state as LightningInfoState;
        } else {
          _curr = LightningInfoState(
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
        _curr.copyWith(
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
    _sub = _repo.filteredStream([
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
