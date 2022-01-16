part of 'fee_revenue_cubit.dart';

@immutable
abstract class FeeRevenueState {}

class FeeRevenueInitial extends FeeRevenueState {}

class FeeRevenueUpdated extends FeeRevenueState {
  final FeeRevenueData data;

  FeeRevenueUpdated(this.data);
}
