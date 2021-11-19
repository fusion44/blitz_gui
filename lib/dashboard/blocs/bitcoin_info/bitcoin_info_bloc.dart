import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../common/subscription_repository.dart';
import 'bitcoin_info_model.dart';

part 'bitcoin_info_event.dart';
part 'bitcoin_info_state.dart';

class BitcoinInfoBloc extends Bloc<BitcoinInfoEvent, BitcoinInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  BitcoinInfoBloc(this.repo) : super(BitcoinInfoInitial()) {
    on<BitcoinInfoEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    BitcoinInfoEvent event,
    Emitter<BitcoinInfoBaseState> emit,
  ) async {
    if (event is StartListenBitcoinInfo) {
      _startListenBitcoinEvents();
    } else if (event is StopListenBitcoinInfo) {
      await _sub?.cancel();
    } else if (event is _BitcoinInfoUpdate) {
      emit(BitcoinInfoState(event.info));
    }
  }

  void _startListenBitcoinEvents() {
    _sub = repo.filteredStream([SseEventTypes.btcInfo])?.listen((event) {
      if (event['event'] != 'btc_info') {
        throw StateError(
          'Invalid state. Requested ${SseEventTypes.btcInfo} but got ${event["event"]} ',
        );
      }
      final i = BitcoinInfo.fromJson(event['data']);
      add(_BitcoinInfoUpdate(i));
    });
  }
}
