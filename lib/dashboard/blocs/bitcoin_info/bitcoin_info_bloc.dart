import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../common/subscription_repository.dart';
import 'bitcoin_info_model.dart';

part 'bitcoin_info_event.dart';
part 'bitcoin_info_state.dart';

class BitcoinInfoBloc extends Bloc<BitcoinInfoEvent, BitcoinInfoBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  BitcoinInfoBloc(this.repo) : super(BitcoinInfoInitial());

  @override
  Stream<BitcoinInfoBaseState> mapEventToState(
    BitcoinInfoEvent event,
  ) async* {
    if (event is StartListenBitcoinInfo) {
      _warmup();
    } else if (event is StopListenBitcoinInfo) {
      await _sub?.cancel();
    } else if (event is _BitcoinInfoUpdate) {
      yield BitcoinInfoState(event.info);
    }
  }

  void _startListenBitcoinEvents() {
    _sub = repo.filteredStream([SseEventTypes.btcInfo])?.listen((event) {
      if (event['id'] != 'btc_info') {
        throw StateError(
          'Invalid state. Requested ${SseEventTypes.btcInfo} but got ${event["id"]} ',
        );
      }
      final i = BitcoinInfo.fromJson(event['data']);
      add(_BitcoinInfoUpdate(i));
    });
  }

  void _warmup() async {
    // It might take a while until the first bitcoin event arrives.
    // It is necessary to fetch initial data via get a request.
    var response =
        await Dio().get('http://127.0.0.1:8000/bitcoin/getbitcoininfo');
    final i = BitcoinInfo.fromJson(response.data);
    add(_BitcoinInfoUpdate(i));
    _startListenBitcoinEvents();
  }
}
