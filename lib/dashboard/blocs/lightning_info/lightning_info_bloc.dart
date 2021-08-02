import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../common/subscription_repository.dart';
import '../../../common/models/lightning_info.dart';

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
      _warmup();
    } else if (event is StopListenLightningInfo) {
      await _sub?.cancel();
    } else if (event is _LightningInfoUpdate) {
      yield LightningInfoState(event.info);
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([SseEventTypes.lnInfo])?.listen((event) {
      final i = LightningInfo.fromJson(event['data']);
      add(_LightningInfoUpdate(i));
    });
  }

  void _warmup() async {
    var response = await Dio().get('http://127.0.0.1:8000/lightning/getinfo');
    final i = LightningInfo.fromJson(response.data);
    add(_LightningInfoUpdate(i));
    _startListenLnEvents();
  }
}
