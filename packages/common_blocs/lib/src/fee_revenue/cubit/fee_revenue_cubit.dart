import 'dart:async';

import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/fee_revenue_repository.dart';

part 'fee_revenue_state.dart';

class FeeRevenueCubit extends Cubit<FeeRevenueState> {
  final FeeRevenueRepository _repo;

  late final StreamSubscription<FeeRevenueData> _sub;

  FeeRevenueCubit(this._repo) : super(FeeRevenueInitial()) {
    _sub = _repo.revenueStream().listen((event) {
      emit(FeeRevenueUpdated(event));
    });

    if (state is FeeRevenueInitial) {
      _warmup();
    }
  }

  void _warmup() async {
    final data = await _repo.currentRevenue();
    if (data != null) {
      emit(FeeRevenueUpdated(data));
    }
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}
