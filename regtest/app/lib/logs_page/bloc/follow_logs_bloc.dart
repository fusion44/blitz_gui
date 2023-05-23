import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:regtest_core/core.dart';

part 'follow_logs_event.dart';
part 'follow_logs_state.dart';

class FollowLogsBloc extends Bloc<FollowLogsEvent, FollowLogsState> {
  final LnNode node;
  final int tail;
  StreamSubscription<String>? sub;

  FollowLogsBloc(this.node, {this.tail = 0}) : super(FollowLogsInitial()) {
    _init();
    on<_InitialLoadFinished>((event, emit) {
      emit(LogsUpdated(event.entries));
    });

    on<_NewLogEntry>((_NewLogEntry event, emit) {
      final s = state;
      if (s is LogsUpdated) {
        emit(LogsUpdated([...s.logs, event.entry]));
      }
    });
  }

  void dispose() => sub?.cancel();

  void _init() {
    sub = node.logStream.listen((event) {
      add(_NewLogEntry(event));
    });
  }
}
