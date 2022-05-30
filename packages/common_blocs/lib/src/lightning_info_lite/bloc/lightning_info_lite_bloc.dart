import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'lightning_info_lite_event.dart';
part 'lightning_info_lite_state.dart';

class LightningInfoLiteBloc
    extends Bloc<LightningInfoLiteEvent, LightningInfoLiteBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  LightningInfoLiteBloc(this.repo) : super(LightningInfoLiteInitial()) {
    on<LightningInfoLiteEvent>(_onEvent, transformer: sequential());
  }

  FutureOr<void> _onEvent(
    LightningInfoLiteEvent event,
    Emitter<LightningInfoLiteBaseState> emit,
  ) async {
    if (event is StartListenLightningInfoLite) {
      _startListenLnEvents();
    } else if (event is StopListenLightningInfoLite) {
      await _sub?.cancel();
    } else if (event is _LightningInfoLiteUpdate) {
      LightningInfoLiteState curr;
      try {
        curr = state as LightningInfoLiteState;
      } catch (e) {
        curr = const LightningInfoLiteState();
      }

      emit(curr.copyWith(lnInfo: event.lnInfo));
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([SseEventTypes.lnInfoLite])?.listen((event) {
      final i = LightningInfoLite.fromJson(event['data']);
      add(_LightningInfoLiteUpdate(lnInfo: i));
    });
  }
}
