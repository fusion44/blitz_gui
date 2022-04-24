import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';

import '../repository/fee_revenue_repository.dart';

part 'fee_revenue_state.dart';

class FeeRevenueCubit extends Cubit<FeeRevenueState> {
  final FeeRevenueRepository _repo;

  FeeRevenueCubit(this._repo) : super(FeeRevenueInitial()) {
    _repo.revenueStream().listen((event) {
      emit(FeeRevenueUpdated(event));
    });
  }
}
