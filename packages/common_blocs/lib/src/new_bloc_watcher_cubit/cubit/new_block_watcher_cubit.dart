import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';
import 'package:subscription_repository/subscription_repository.dart';

part 'new_block_watcher_state.dart';

class NewBlockWatcherCubit extends Cubit<NewBlockWatcherState> {
  final SubscriptionRepository _subRepo;
  late final StreamSubscription<Map<String, dynamic>>? _sub;

  Future<void> dispose() async {
    await _sub?.cancel();
  }

  NewBlockWatcherCubit(this._subRepo) : super(NewBlockWatcherInitial()) {
    _sub = _subRepo.filteredStream([SseEventTypes.btcNewBloc])?.listen((event) {
      emit(NewBlockAppended(BlockData.fromJson(event['data'])));
    });
  }
}
